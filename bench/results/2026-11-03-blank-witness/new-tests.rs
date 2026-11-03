/// Blank slots are checked against the actual unique glyph, not either mapper.
/// A missing glyph is tracked separately: no invented destination is asserted.
#[test]
#[ignore = "research diagnostic: trailing blank slots need a content witness"]
fn blank_witness_marker_matrix() {
    let mut cases=0; let mut failures=0; let mut absent=0;
    for rows in [4usize,6] { for width in [3usize,7,14,20] { for target in [2usize,4,8] { for cursor in [0usize,rows-1] {
    for marker_row in [0usize,rows-1] { for column in [0usize,3] {
    for (kind,glyph,extent) in [('a','M',1usize),('c','漢',2),('e','🚀',2),('z','M',1)] {
    for gap in [0usize,2] { for records in [0usize,12] { for alt in [false,true] { for fast in [false,true] {
        let mut engine=engine(rows,10); engine.set_fast(fast);
        let mut intake=Intake::new(8); intake.set_cell((10,20));
        for _ in 0..records { feed(&mut engine,&mut intake,b"x\r\n"); }
        feed(&mut engine,&mut intake,format!("\x1b[{};{}H{glyph}{}\x1b[{};{}H",marker_row+1,column+1,if kind=='z' {"\u{301}"} else {""},marker_row+1,column+extent+gap+1).as_bytes());
        feed(&mut engine,&mut intake,&picture(996));
        feed(&mut engine,&mut intake,format!("\x1b[{};1H",cursor+1).as_bytes());
        for (step,(height,cols)) in [(target,width),(rows,10),(target,width)].into_iter().enumerate() {
            if alt { feed(&mut engine,&mut intake,b"\x1b[?1049h"); }
            engine.resize(height,cols);
            if let Some(reflow)=engine.take_reflow() { intake.reflow(&reflow); intake.set_scrolled_primary(engine.scrolled_off_top() as u64,engine.history_size(),height as u16); }
            if alt { feed(&mut engine,&mut intake,b"\x1b[?1049l"); }
            let text:Vec<(i32,i32)>=(-(engine.history_size() as i32)..height as i32).flat_map(|r| engine.grid_line(r).chars().enumerate().filter_map(move |(c,ch)|(ch==glyph).then_some((r,c as i32))).collect::<Vec<_>>()).collect();
            let top=engine.scrolled_off_top().saturating_sub(engine.history_size()) as u64;
            let shown=intake.describe(View{top,rows:(engine.history_size()+height) as u16,alternate:false});
            let pics:Vec<(i32,i32)>=shown.placements.iter().map(|p|(p.row.round() as i32+top as i32-engine.scrolled_off_top() as i32,p.column.round() as i32)).collect();
            let expected:Vec<(i32,i32)>=text.iter().filter_map(|&(r,c)| {
                let flat=r*cols as i32+c+(extent+gap) as i32;
                let dest=(flat.div_euclid(cols as i32),flat.rem_euclid(cols as i32));
                (dest.0>=-(engine.history_size() as i32) && dest.0<height as i32).then_some(dest)
            }).collect();
            // Only observations with a surviving glyph specify a logical slot.
            let checked=!text.is_empty(); let ok=!checked || pics==expected;
            cases+=1; absent+=usize::from(!checked); failures+=usize::from(!ok);
            eprintln!("slot-case rows={rows} target={target} cursor={cursor} width={width} marker={marker_row} column={column} kind={kind} gap={gap} records={records} alt={alt} fast={fast} step={step} text={text:?} expected={expected:?} pictures={pics:?} checked={checked} ok={ok}");
        }
    }}}}}}}}}}}
    eprintln!("slot-summary cases={cases} absent={absent} failures={failures}");
    assert_eq!(failures,0,"surviving unique glyph witnesses its trailing logical slot");
}

/// Negative control: a surviving glyph on ANOTHER line cannot revive a slot
/// whose own content was discarded by height/history truncation.
#[test]
#[ignore = "research diagnostic: deleted own-line witnesses never borrow neighbours"]
fn blank_witness_deleted_line_matrix() {
    let mut cases=0; let mut eligible=0; let mut failures=0;
    for rows in [4usize,6] { for target in [2usize,4,8] { for cols in [3usize,7,14] {
    for marker_row in [0usize,rows-1] { for cursor in [0usize,rows-1] {
    for column in [0usize,6] { for records in [0usize,12] { for alt in [false,true] { for fast in [false,true] {
        let mut engine=engine(rows,10); engine.set_fast(fast);
        let mut intake=Intake::new(8); intake.set_cell((10,20));
        for _ in 0..records { feed(&mut engine,&mut intake,b"x\r\n"); }
        for r in 0..rows { feed(&mut engine,&mut intake,format!("\x1b[{};1Habcdefghij",r+1).as_bytes()); }
        feed(&mut engine,&mut intake,format!("\x1b[{};{}HM\x1b[K\x1b[{};{}H",marker_row+1,column+1,marker_row+1,column+2).as_bytes());
        feed(&mut engine,&mut intake,&picture(997));
        let other=if marker_row==0 {rows-1} else {0};
        feed(&mut engine,&mut intake,format!("\x1b[{};1HW\x1b[{};1H",other+1,cursor+1).as_bytes());
        if alt { feed(&mut engine,&mut intake,b"\x1b[?1049h"); }
        engine.resize(target,cols);
        let reflow=engine.take_reflow();
        if let Some(reflow)=reflow { intake.reflow(&reflow); intake.set_scrolled_primary(engine.scrolled_off_top() as u64,engine.history_size(),target as u16); }
        if alt { feed(&mut engine,&mut intake,b"\x1b[?1049l"); }
        let mut own=0; let mut unrelated=0;
        for r in -(engine.history_size() as i32)..target as i32 {
            for ch in engine.grid_line(r).chars() { own+=usize::from(ch=='M'); unrelated+=usize::from(ch=='W'); }
        }
        let checked=own==0 && unrelated==1;
        let top=engine.scrolled_off_top().saturating_sub(engine.history_size()) as u64;
        let shown=intake.describe(View{top,rows:(engine.history_size()+target) as u16,alternate:false});
        let pictures=shown.placements.len(); let ok=!checked || pictures==0;
        cases+=1; eligible+=usize::from(checked); failures+=usize::from(!ok);
        eprintln!("deleted-case rows={rows} target={target} cols={cols} marker={marker_row} cursor={cursor} column={column} records={records} alt={alt} fast={fast} own={own} unrelated={unrelated} pictures={pictures} checked={checked} ok={ok}");
    }}}}}}}}}
    eprintln!("deleted-summary cases={cases} eligible={eligible} failures={failures}");
    assert!(eligible>0,"negative-control configurations execute");
    assert_eq!(failures,0,"an unrelated surviving glyph cannot revive the deleted line");
}

/// Two histories collapse to the same row/column and reflow input. A stateless
/// cell-destination map cannot reconstruct whether a blank belonged to M's
/// logical tail or the next hard row. This test characterizes, not resolves, it.
#[test]
#[ignore = "research diagnostic: blank-slot identity is absent after collapse"]
fn blank_witness_indistinguishable_histories() {
    fn run(cup: &[u8]) -> (String,Vec<(i32,i32)>,Vec<(i32,i32)>,String,String) {
        let mut engine=engine(4,10);
        let mut intake=Intake::new(8);intake.set_cell((10,20));
        feed(&mut engine,&mut intake,b"M");
        feed(&mut engine,&mut intake,cup);
        feed(&mut engine,&mut intake,&picture(998));
        feed(&mut engine,&mut intake,b"\x1b[1;1H");
        let mut states=Vec::new(); let mut positions=Vec::new(); let mut maps=Vec::new();
        for (height,cols) in [(2usize,3usize),(4,10)] {
            engine.resize(height,cols);
            let reflow=engine.take_reflow().expect("width changes");
            maps.push(format!("{reflow:?}"));
            intake.reflow(&reflow);
            intake.set_scrolled_primary(engine.scrolled_off_top() as u64,engine.history_size(),height as u16);
            states.push((-(engine.history_size() as i32)..height as i32).map(|r|engine.grid_line(r)).collect::<Vec<_>>().join("\n"));
            let top=engine.scrolled_off_top().saturating_sub(engine.history_size()) as u64;
            let shown=intake.describe(View{top,rows:(engine.history_size()+height) as u16,alternate:false});
            positions.push(shown.placements.iter().map(|p|(p.row.round() as i32+top as i32-engine.scrolled_off_top() as i32,p.column.round() as i32)).collect::<Vec<_>>());
        }
        (states[0].clone(),positions[0].clone(),positions[1].clone(),maps[1].clone(),states[1].clone())
    }
    let a=run(b"\x1b[1;4H"); let b=run(b"\x1b[2;1H");
    eprintln!("identity-case a_mid={:?} b_mid={:?} a_final={:?} b_final={:?} same_text={} same_map={}",a.1,b.1,a.2,b.2,a.0==b.0,a.3==b.3);
    assert_eq!(a.0,b.0,"same narrowed text");
    assert_eq!(a.1,b.1,"same narrowed picture position");
    assert_eq!(a.3,b.3,"identical full next Reflow including exact destinations");
    assert_eq!(a.4,b.4,"same final text");
    assert_eq!(a.2,b.2,"identical current input necessarily yields identical destination");
    assert_eq!(a.1,vec![(1,0)]);
    assert_eq!(a.2,vec![(1,0)]);
    assert_ne!(a.2,vec![(0,3)],"original marker-relative blank slot is no longer representable");
}

/// Shipping characterization: inactive primary bottom-line deletion leaves a
/// picture visible at row 1 even though its attached M row was discarded.
#[test]
#[ignore = "research diagnostic: stale picture after own-row deletion"]
fn blank_witness_shipping_ghost_characterization() {
    for alt in [false,true] { for fast in [false,true] {
        let mut engine=engine(4,10);engine.set_fast(fast);
        let mut intake=Intake::new(8);intake.set_cell((10,20));
        for r in 0..4 { feed(&mut engine,&mut intake,format!("\x1b[{};1Habcdefghij",r+1).as_bytes()); }
        feed(&mut engine,&mut intake,b"\x1b[4;1HM\x1b[K\x1b[4;2H");
        feed(&mut engine,&mut intake,&picture(999));
        feed(&mut engine,&mut intake,b"\x1b[1;1HW\x1b[1;1H");
        if alt { feed(&mut engine,&mut intake,b"\x1b[?1049h"); }
        engine.resize(2,14);
        if let Some(reflow)=engine.take_reflow() { intake.reflow(&reflow);intake.set_scrolled_primary(engine.scrolled_off_top() as u64,engine.history_size(),2); }
        if alt { feed(&mut engine,&mut intake,b"\x1b[?1049l"); }
        let text:Vec<String>=(-(engine.history_size() as i32)..2).map(|r|engine.grid_line(r)).collect();
        let shown=intake.describe(View{top:engine.top_line(),rows:2,alternate:false});
        let positions:Vec<(i32,i32)>=shown.placements.iter().map(|p|(p.row.round() as i32,p.column.round() as i32)).collect();
        let own=text.iter().any(|s|s.contains('M'));let unrelated=text.iter().any(|s|s.contains('W'));
        eprintln!("ghost-case alt={alt} fast={fast} text={text:?} own={own} unrelated={unrelated} pictures={positions:?} base={} history={}",engine.scrolled_off_top(),engine.history_size());
        assert!(!own && unrelated,"the same own row is gone in both arms");
        assert_eq!(positions,if alt {vec![(1,1)]} else {vec![]},"shipping defect, not desired behaviour");
    }}
}
