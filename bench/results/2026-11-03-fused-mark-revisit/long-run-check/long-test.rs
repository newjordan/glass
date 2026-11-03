    /// Repeated redraw checked against direct upstream character input, including
    /// a plain pen (the fused lane) and rich pens that must use the fallback.
    #[test]
    fn fused_mark_redraws_match_direct_term_input() {
        use alacritty_terminal::vte::ansi::Handler;
        // Direct Term input cannot update Engine's Watch-owned scroll counter.
        // Compare every cell, cursor/template/mode and history, not that counter.
        let state = |e: &Engine| {
            let (cells, cursor, history, _) = e.grid_state();
            (cells, cursor, history)
        };
        let mut cases = 0;
        let mut observations = 0;
        for fast in [false, true] {
            for alternate in [false, true] {
                for cols in [4, 9] {
                    for row in [0, 3] {
                        for column in [0, cols - 2, cols - 1] {
                            for base in ['e', '漢'] {
                                for mark in ['\u{300}', '\u{301}', '\u{308}', '\u{34f}', '\u{36f}', '\u{200b}'] {
                                    for pen in 0..4 {
                                        let text = format!("{base}{mark}x\u{301}yz").repeat(4);
                                        let seed = format!("{base}{mark}xy");
                                        for cut in 0..=text.len() {
                                            let setup = |e: &mut Engine| {
                                                e.set_fast(fast);
                                                if alternate { e.process(b"\x1b[?1049h"); }
                                                e.term.goto(row, column);
                                                for c in seed.chars() { e.term.input(c); }
                                                match pen {
                                                    1 => e.term.terminal_attribute(Attr::Bold),
                                                    2 => e.term.terminal_attribute(Attr::UnderlineColor(Some(AnsiColor::Indexed(27)))),
                                                    3 => e.process(b"\x1b]8;id=seed;https://example.org\x1b\\"),
                                                    _ => (),
                                                }
                                            };
                                            let info = engine().info.lock().unwrap().clone();
                                            let mut expected = Engine::new(4, cols, info.clone());
                                            let mut actual = Engine::new(4, cols, info);
                                            setup(&mut expected);
                                            setup(&mut actual);
                                            for redraw in 0..3 {
                                                expected.term.goto(row, column);
                                                actual.term.goto(row, column);
                                                for c in text.chars() { expected.term.input(c); }
                                                actual.process(&text.as_bytes()[..cut]);
                                                actual.process(&text.as_bytes()[cut..]);
                                                assert_eq!(state(&actual), state(&expected), "fast={fast} alt={alternate} cols={cols} row={row} col={column} base={base} mark={mark:?} pen={pen} cut={cut} redraw={redraw}");
                                                for line in 0..4 {
                                                    let row = &actual.term.grid()[alacritty_terminal::index::Line(line)];
                                                    assert!(!row.extra_free() || (0..cols).all(|c| row[Column(c)].extra.is_none()),
                                                        "extra_free invalid fast={fast} alt={alternate} cols={cols} row={row:?} col={column} cut={cut}");
                                                }
                                                for _ in 0..2 { expected.term.input('z'); }
                                                actual.process(b"\x1b[2b");
                                                assert_eq!(state(&actual), state(&expected), "REP cut={cut} redraw={redraw}");
                                                observations += 2;
                                            }
                                            cases += 1;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        eprintln!("fused-mark redraw cases={cases} observations={observations} failures=0");
        assert!(cases > 20_000);
        assert_eq!(observations, cases * 6);
    }

