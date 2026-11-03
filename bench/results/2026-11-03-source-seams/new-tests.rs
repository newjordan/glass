
// The oracle transports individual original source rows, never scroll_rect.
// Frame rectangles are expanded back into those rows to catch illicit splicing.
#[test]
fn source_seams_real_apc_row_oracle() {
    let mut cases = 0;
    let mut failures = 0;
    for fast in [false, true] {
        for alternate in [false, true] {
            for cropped in [false, true] {
                for start in [0u64, 2, 4, 6] {
                    for height in [2u64, 4, 6, 8] {
                        for (top, bottom) in [(2u64, 7u64), (4, 9)] {
                            for n in [1u64, 2, 3] {
                                for down in [false, true] {
                                    let mut e = engine(20, 10);
                                    e.set_fast(fast);
                                    let mut i = Intake::new(8);
                                    i.set_cell((10, 20));
                                    if alternate { feed(&mut e, &mut i, b"\x1b[?1049h"); }
                                    // Real RGB images, magnified; cropped form selects
                                    // the right half and middle half of a 2x4 image.
                                    let image = if cropped { "s=2,v=4,x=1,y=1,w=1,h=2" } else { "s=1,v=1" };
                                    let data = if cropped { "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA" } else { "AAAA" };
                                    let command = format!("\x1b[{};2H\x1b_Gi=81,{image},a=T,f=24,c=2,r={height};{data}\x1b\\\x1b[H", start + 1);
                                    feed(&mut e, &mut i, command.as_bytes());
                                    assert_eq!(i.placements.len(), 1, "real APC intake");
                                    let command = format!("\x1b[{};{}r\x1b[{n}{}", top + 1, bottom, if down { 'T' } else { 'S' });
                                    feed(&mut e, &mut i, command.as_bytes());
                                    let shown = i.describe(View { top: 0, rows: 20, alternate });
                                    let mut got = Vec::new();
                                    for p in &shown.placements {
                                        let source = p.source.unwrap_or(if cropped { [0.0, 0.0, 2.0, 4.0] } else { [0.0, 0.0, 1.0, 1.0] });
                                        for r in 0..p.height.round() as u64 {
                                            got.push([f64::from(p.row) + r as f64, f64::from(p.column), f64::from(p.width), f64::from(source[0]), f64::from(source[1]) + r as f64 * f64::from(source[3]) / f64::from(p.height), f64::from(source[2]), f64::from(source[3]) / f64::from(p.height)]);
                                        }
                                    }
                                    got.sort_by(|a,b| a[0].total_cmp(&b[0]));
                                    let mut expected = Vec::new();
                                    for r in 0..height {
                                        let old = start + r;
                                        let new = if old < top || old >= bottom { Some(old) }
                                            else if down { (old + n < bottom).then_some(old + n) }
                                            else if old >= top + n { Some(old - n) } else { None };
                                        if let Some(new) = new {
                                            let (x,y,w,h) = if cropped { (1.0,1.0,1.0,2.0) } else { (0.0,0.0,1.0,1.0) };
                                            expected.push([new as f64,1.0,2.0,x,y + r as f64 * h / height as f64,w,h / height as f64]);
                                        }
                                    }
                                    expected.sort_by(|a,b| a[0].total_cmp(&b[0]));
                                    let pass = got.len() == expected.len() && got.iter().zip(&expected).all(|(a,b)| a.iter().zip(b).all(|(x,y)| (x-y).abs() < 0.00001));
                                    eprintln!("source-seams-json {}", serde_json::json!({"fast":fast,"alternate":alternate,"cropped":cropped,"start":start,"height":height,"top":top,"bottom":bottom,"n":n,"down":down,"got":got,"expected":expected,"pass":pass}));
                                    cases += 1;
                                    failures += usize::from(!pass);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    eprintln!("source-seams-summary cases={cases} failures={failures}");
    assert_eq!(cases, 1536);
    assert_eq!(failures, 0, "screen adjacency must not splice non-contiguous source rows");
}
