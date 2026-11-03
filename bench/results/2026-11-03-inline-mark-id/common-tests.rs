
    #[test]
    fn logical_single_marks_layout_wire_and_lifetimes() {
        fn traits<T: Send + Sync>() {}
        traits::<Cell>();
        assert_eq!(std::mem::size_of::<Cell>(), 24);
        eprintln!("inline-layout bytes={} align={}", std::mem::size_of::<Cell>(), std::mem::align_of::<Cell>());
        let chars: Vec<char> = (0x300..=0x36f).map(|v| char::from_u32(v).unwrap())
            .chain(['\u{2ff}', '\u{370}', '\u{1ab0}', '\0']).collect();
        for mark in chars {
            let mut cell = Cell::default();
            cell.push_zerowidth(mark);
            assert!(cell.has_extra());
            assert!(!cell.is_empty());
            assert_eq!(cell.zerowidth(), Some(&[mark][..]));
            let owner = Cell { extra: Some(Arc::new(CellExtra::with_mark(mark))), ..Cell::default() };
            assert_eq!(cell, owner);
            assert_eq!(format!("{cell:?}"), format!("{owner:?}"));
            #[cfg(feature = "serde")]
            {
                let wire = serde_json::to_string(&cell).unwrap();
                assert_eq!(wire, serde_json::to_string(&owner).unwrap());
                assert!(!wire.contains("inline"));
                assert_eq!(serde_json::from_str::<Cell>(&wire).unwrap(), cell);
            }
            let mut row = Row::new(4);
            row[Column(2)] = cell.clone();
            assert_eq!(row.line_length(), Column(3));
            for operation in 0..7 {
                let mut copy = cell.clone();
                match operation {
                    0 => copy.push_zerowidth('\u{308}'),
                    1 => copy.set_underline_color(Some(Color::Indexed(7))),
                    2 => copy.set_hyperlink(Some(Hyperlink::new(Some("i"), "https://example.net".into()))),
                    3 => copy.clear_wide(),
                    4 => copy.clear_extra(),
                    5 => copy.set_underline_color(None),
                    _ => copy.set_hyperlink(None),
                }
                assert_eq!(cell.zerowidth(), Some(&[mark][..]));
                match operation {
                    0 => assert_eq!(copy.zerowidth(), Some(&[mark, '\u{308}'][..])),
                    1 => { assert_eq!(copy.underline_color(), Some(Color::Indexed(7))); assert_eq!(copy.zerowidth(), Some(&[mark][..])); },
                    2 => { assert_eq!(copy.hyperlink().unwrap().id(), "i"); assert_eq!(copy.zerowidth(), Some(&[mark][..])); },
                    3 => assert_eq!(copy.zerowidth(), Some(&[][..])),
                    4 => assert!(!copy.has_extra()),
                    _ => assert_eq!(copy.zerowidth(), Some(&[mark][..])),
                }
            }
            let copied = Cell::from_template('x', &cell);
            assert_eq!(copied.zerowidth(), Some(&[mark][..]));
            let joined = std::thread::spawn(move || {
                let mut changed = copied.clone();
                changed.push_zerowidth('\u{308}');
                assert_eq!(copied.zerowidth(), Some(&[mark][..]));
                changed
            }).join().unwrap();
            assert_eq!(joined.zerowidth(), Some(&[mark, '\u{308}'][..]));
        }
        let empty = Cell { extra: Some(Arc::new(CellExtra::default())), ..Cell::default() };
        assert_ne!(empty, Cell::default());
    }
