// Visible cell centres, including their normalized source-image coordinates.
// Sampling every cell detects both resurrected text-covered cells and wrongly
// hidden surviving cells without duplicating rectangle slicing in the oracle.
fn cover_transport_cells(view: &super::Description, height: usize) -> Vec<[f32; 4]> {
    let mut cells = Vec::new();
    for p in &view.placements {
        let source = p.source.unwrap_or([0.0, 0.0, 30.0, height as f32 * 20.0]);
        for row in 0..p.height.ceil() as usize {
            for col in 0..p.width.ceil() as usize {
                cells.push([
                    p.row + row as f32,
                    p.column + col as f32,
                    (source[0] + (col as f32 + 0.5) / p.width * source[2]) / 30.0,
                    (source[1] + (row as f32 + 0.5) / p.height * source[3]) / (height as f32 * 20.0),
                ]);
            }
        }
    }
    cells.sort_by(|a, b| a.partial_cmp(b).unwrap());
    cells
}

fn cover_transport_b64(data: &[u8]) -> String {
    const TABLE: &[u8; 64] = b"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
    let mut result = String::new();
    for chunk in data.chunks(3) {
        let word = (u32::from(chunk[0]) << 16)
            | (u32::from(*chunk.get(1).unwrap_or(&0)) << 8)
            | u32::from(*chunk.get(2).unwrap_or(&0));
        result.push(TABLE[(word >> 18) as usize] as char);
        result.push(TABLE[((word >> 12) & 63) as usize] as char);
        result.push(if chunk.len() > 1 { TABLE[((word >> 6) & 63) as usize] as char } else { '=' });
        result.push(if chunk.len() > 2 { TABLE[(word & 63) as usize] as char } else { '=' });
    }
    result
}

#[test]
fn cover_transport_real_intake_cell_oracle() {
    let mut cases = 0;
    let mut failures = 0;
    for fast in [false, true] {
        for alternate in [false, true] {
            for osc in [false, true] {
                for start in [0_usize, 3, 6] {
                    for height in [2_usize, 4, 6] {
                        for (top, bottom) in [(2_usize, 7_usize), (4, 9)] {
                            for n in [1_usize, 2, 3] {
                                for down in [false, true] {
                                    for mask in [0_usize, 1, 2] {
                                        let mut engine = engine(20, 10);
                                        engine.set_fast(fast);
                                        let mut intake = Intake::new(20);
                                        intake.set_cell((10, 20));
                                        if alternate {
                                            feed(&mut engine, &mut intake, b"\x1b[?1049h");
                                        }
                                        feed(&mut engine, &mut intake, format!("\x1b[{};1H", start + 1).as_bytes());
                                        if osc {
                                            let data = super::testing::encode_png(30, height as u32 * 20);
                                            let payload = cover_transport_b64(&data);
                                            feed(&mut engine, &mut intake, format!("\x1b]1337;File=inline=1;width=3;height={height};preserveAspectRatio=0:{payload}\x07").as_bytes());
                                        } else {
                                            let mut payload = format!("\x1bPq\"1;1;30;{}#0;2;100;0;0", height * 20);
                                            for band in (0..height * 20).step_by(6) {
                                                if band > 0 { payload.push('-'); }
                                                let bits = ((1_u16 << (height * 20 - band).min(6)) - 1) as u8;
                                                payload.push_str("!30");
                                                payload.push(char::from(63 + bits));
                                            }
                                            payload.push_str("\x1b\\");
                                            feed(&mut engine, &mut intake, payload.as_bytes());
                                        }
                                        let mut expected = Vec::new();
                                        for row in 0..height {
                                            for col in 0..3 {
                                                let hidden = match mask {
                                                    0 => col == row % 3,
                                                    1 => col != row % 3,
                                                    _ => row % 2 == 0,
                                                };
                                                if hidden {
                                                    feed(&mut engine, &mut intake, format!("\x1b[{};{}Hx", start + row + 1, col + 1).as_bytes());
                                                } else {
                                                    expected.push([(start + row) as f32, col as f32, (col as f32 + 0.5) / 3.0, (row as f32 + 0.5) / height as f32]);
                                                }
                                            }
                                        }
                                        // Setup, same-direction repeat, then reverse: every step
                                        // transports an enumerated original visible-cell identity.
                                        for step in 0..4 {
                                            let direction = if step == 3 { !down } else { down };
                                            if step > 0 {
                                                expected.retain_mut(|cell| {
                                                    if cell[0] >= top as f32 && cell[0] < bottom as f32 {
                                                        cell[0] += if direction { n as f32 } else { -(n as f32) };
                                                        return cell[0] >= top as f32 && cell[0] < bottom as f32;
                                                    }
                                                    true
                                                });
                                                feed(&mut engine, &mut intake, format!("\x1b[{};{}r\x1b[{n}{}", top + 1, bottom, if direction { 'T' } else { 'S' }).as_bytes());
                                            }
                                            expected.sort_by(|a, b| a.partial_cmp(b).unwrap());
                                            let got = cover_transport_cells(&intake.describe(View { top: 0, rows: 20, alternate }), height);
                                            let pass = got.len() == expected.len() && got.iter().zip(&expected).all(|(a,b)| a.iter().zip(b).all(|(a,b)| (a-b).abs() < 1e-5));
                                            cases += 1;
                                            failures += usize::from(!pass);
                                            println!("cover-transport-json {}", serde_json::json!({"fast":fast,"alternate":alternate,"osc":osc,"start":start,"height":height,"top":top,"bottom":bottom,"n":n,"down":down,"mask":mask,"step":step,"got":got,"expected":expected,"pass":pass}));
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    println!("cover-transport-summary cases={cases} failures={failures}");
    assert_eq!(failures, 0);
}
