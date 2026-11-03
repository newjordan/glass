/// Scroll oracle models the two physical points independently; it never calls
/// Reflow or either mapping helper to produce an expected destination.
#[test]
#[ignore = "research: interleaved resize/scroll witness transport"]
fn scroll_witness_matrix() {
    fn markers(e: &Engine) -> Vec<(i32,i32)> {
        (-(e.history_size() as i32)..8).flat_map(|r| e.grid_line(r).chars().enumerate()
            .filter_map(move |(c,ch)| (ch=='M').then_some((r,c as i32))).collect::<Vec<_>>()).collect()
    }
    fn pictures(e: &Engine, i: &mut Intake) -> Vec<(i32,i32)> {
        let top=e.scrolled_off_top().saturating_sub(e.history_size()) as u64;
        i.describe(View {top,rows:(e.history_size()+8) as u16,alternate:false}).placements.iter()
            .map(|p|(p.row.round() as i32+top as i32-e.scrolled_off_top() as i32,p.column.round() as i32)).collect()
    }
    fn resize(e: &mut Engine,i: &mut Intake,w: usize,alt: bool) {
        if alt {feed(e,i,b"\x1b[?1049h");}
        e.resize(8,w);if let Some(r)=e.take_reflow(){i.reflow(&r);i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),8);}
        if alt {feed(e,i,b"\x1b[?1049l");}
    }
    fn shift(row: i32,top: i32,down: bool) -> Option<i32> {
        if row<top || row>=7 {Some(row)} else if down { (row<6).then_some(row+1) } else { (row>top).then_some(row-1) }
    }
    let mut cases=0;let mut failures=0;
    for fast in [false,true] {for alt in [false,true] {for row in 1..6 {for delta in [0,3,8,-8] {
        for (op,bytes,top,down) in [
            ("SU",b"\x1b[2;7r\x1b[1S".as_slice(),1,false),
            ("SD",b"\x1b[2;7r\x1b[1T".as_slice(),1,true),
            ("IL",b"\x1b[2;7r\x1b[4;1H\x1b[1L".as_slice(),3,true),
            ("DL",b"\x1b[2;7r\x1b[4;1H\x1b[1M".as_slice(),3,false),
            ("RI",b"\x1b[2;7r\x1b[2;1H\x1bM".as_slice(),1,true),
            ("LF",b"\x1b[2;7r\x1b[7;1H\n".as_slice(),1,false),
        ] {
            let mc=if delta<0 {8} else {0};let pc=mc+delta;
            let mut e=engine(8,10);e.set_fast(fast);let mut i=Intake::new(8);i.set_cell((10,20));
            feed(&mut e,&mut i,format!("\x1b[{};{}HM\x1b[{};{}H",row+1,mc+1,row+1,pc+1).as_bytes());
            feed(&mut e,&mut i,&picture(1101));feed(&mut e,&mut i,b"\x1b[1;1H");
            resize(&mut e,&mut i,7,alt);
            let before_m=markers(&e);let before_p=pictures(&e,&mut i);
            assert_eq!(before_m.len(),1);assert_eq!(before_p.len(),1);
            let m=before_m[0];let p=before_p[0];assert_eq!((p.0-m.0)*7+p.1-m.1,delta);
            let sm=shift(m.0,top,down);let sp=shift(p.0,top,down);
            let next_delta=sm.zip(sp).map(|(a,b)|(b-a)*7+p.1-m.1);
            feed(&mut e,&mut i,bytes);
            let after_m=markers(&e);let after_p=pictures(&e,&mut i);
            assert_eq!(after_m,sm.map(|r|vec![(r,m.1)]).unwrap_or_default(),"text oracle {op}");
            if sm.is_some() {assert_eq!(after_p,sp.map(|r|vec![(r,p.1)]).unwrap_or_default(),"physical picture oracle {op}");}
            resize(&mut e,&mut i,10,alt);
            let final_m=markers(&e);let got=pictures(&e,&mut i);
            let expected=match (next_delta,final_m.first()) {
                (Some(d),Some(&(r,c))) => {let flat=r*10+c+d;let rr=flat.div_euclid(10);let cc=flat.rem_euclid(10);
                    if rr>=-(e.history_size() as i32) && rr<8 {vec![(rr,cc)]} else {vec![]}},
                _ => vec![],
            };
            let pass=got==expected;if !pass {failures+=1;}
            eprintln!("scroll-witness fast={fast} alt={alt} row={row} delta={delta} op={op} before_m={before_m:?} before_p={before_p:?} after_m={after_m:?} after_p={after_p:?} final_m={final_m:?} got={got:?} expected={expected:?} pass={pass}");
            cases+=1;
        }
    }}}}
    eprintln!("scroll-witness-summary cases={cases} failures={failures}");
    assert_eq!(cases,480);assert_eq!(failures,0,"interleaved scroll transport failures");
}

#[test]
#[ignore = "research: saved state must not leak after RIS"]
fn scroll_witness_reset_lifetime() {
    for fast in [false,true] {
        let mut e=engine(8,10);e.set_fast(fast);let mut i=Intake::new(8);i.set_cell((10,20));
        feed(&mut e,&mut i,b"M\x1b[1;4H");feed(&mut e,&mut i,&picture(1102));
        e.resize(8,7);i.reflow(&e.take_reflow().unwrap());
        assert_eq!(i.resize_anchors.len(),1);
        feed(&mut e,&mut i,b"\x1bc");
        eprintln!("reset-lifetime fast={fast} placements={} saved={}",i.placements.len(),i.resize_anchors.len());
        assert!(i.placements.is_empty());assert!(i.resize_anchors.is_empty(),"saved witness leaked after RIS");
    }
}
