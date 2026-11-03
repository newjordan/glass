
// No mapping helper used by this oracle. Each retained vertical slice inherits
// its original marker offset, plus its physical start-row displacement at 7 cols.
#[test]
fn split_witness_matrix() {
    let mut cases=0; let mut failures=0;
    for fast in [false,true] { for inactive in [false,true] {
    for marker_col in 0..5 { for picture_col in [8,9] {
    for height in [3,4,5,6] { for above in 1..height {
    for down in [1,2,3] {
        let mut e=engine(20,10);e.set_fast(fast);
        let mut i=Intake::new(8);i.set_cell((10,20));
        feed(&mut e,&mut i,format!("\x1b[2;{}HM\x1b[2;{}H",marker_col+1,picture_col+1).as_bytes());
        feed(&mut e,&mut i,format!("\x1b_Gi=71,s=1,v=1,a=T,f=24,c=1,r={height};AAAA\x1b\\").as_bytes());
        feed(&mut e,&mut i,b"\x1b[H");
        if inactive {feed(&mut e,&mut i,b"\x1b[?1049h");}
        e.resize(20,7);i.reflow(&e.take_reflow().unwrap());
        i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),20);
        if inactive {feed(&mut e,&mut i,b"\x1b[?1049l");}
        let narrow:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        assert_eq!(narrow,vec![(2,(picture_col-7) as f32,height as f32)]);
        let top=2+above;let bottom=2+height+down;
        feed(&mut e,&mut i,format!("\x1b[{};{}r\x1b[{down}T",top+1,bottom).as_bytes());
        let physical:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        assert_eq!(physical,vec![(2,(picture_col-7) as f32,above as f32),((top+down) as u64,(picture_col-7) as f32,(height-above) as f32)]);
        let physical_sources:Vec<_>=i.placements.iter().map(|p|p.source.unwrap()).collect();
        let source_ok=physical_sources.iter().zip([[0.0,0.0,1.0,above as f32/height as f32],[0.0,above as f32/height as f32,1.0,(height-above) as f32/height as f32]])
            .all(|(got,want)|got.iter().zip(want).all(|(a,b)|(*a-b).abs()<0.00001));
        if inactive {feed(&mut e,&mut i,b"\x1b[?1049h");}
        e.resize(20,10);i.reflow(&e.take_reflow().unwrap());
        i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),20);
        if inactive {feed(&mut e,&mut i,b"\x1b[?1049l");}
        let got:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        let second_flat=10+picture_col+(above+down)*7;
        let expected=vec![(1,picture_col as f32,above as f32),((second_flat/10) as u64,(second_flat%10) as f32,(height-above) as f32)];
        let saved=i.resize_anchors.len();
        let unique=i.placements.iter().map(|p|p.seq).collect::<std::collections::HashSet<_>>().len();
        let pass=got==expected && source_ok && saved==2 && unique==2;
        if !pass {failures+=1;}
        eprintln!("split-case fast={fast} inactive={inactive} marker={marker_col} picture={picture_col} height={height} above={above} down={down} got={got:?} expected={expected:?} sources={physical_sources:?} saved={saved} unique={unique} pass={pass}");
        cases+=1;
    }}}}}}}
    eprintln!("split-summary cases={cases} failures={failures}");
    assert_eq!(cases,1680);assert_eq!(failures,0);
}

#[test]
fn split_witness_repeated_split_and_local_death() {
    for fast in [false,true] {for local_death in [false,true] {
        let mut e=engine(20,10);e.set_fast(fast);
        let mut i=Intake::new(8);i.set_cell((10,20));
        feed(&mut e,&mut i,b"\x1b[2;1HM\x1b[2;9H\x1b_Gi=71,s=1,v=1,a=T,f=24,c=1,r=8;AAAA\x1b\\\x1b[H");
        e.resize(20,7);i.reflow(&e.take_reflow().unwrap());
        i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),20);
        feed(&mut e,&mut i,b"\x1b[6;20r\x1b[1T\x1b[4;20r\x1b[1T");
        let physical:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        assert_eq!(physical,vec![(2,1.0,1.0),(4,1.0,2.0),(7,1.0,5.0)]);
        let unique=i.placements.iter().map(|p|p.seq).collect::<std::collections::HashSet<_>>().len();
        let saved=i.resize_anchors.len();
        if local_death {feed(&mut e,&mut i,b"\x1b[3;4r\x1b[1S");}
        e.resize(20,10);i.reflow(&e.take_reflow().unwrap());
        i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),20);
        let got:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        let expected=if local_death {vec![(3,2.0,2.0),(5,3.0,5.0)]}else{vec![(1,8.0,1.0),(3,2.0,2.0),(5,3.0,5.0)]};
        eprintln!("split-repeat fast={fast} local_death={local_death} unique={unique} saved={saved} got={got:?} expected={expected:?}");
        assert_eq!(unique,3,"split identifiers alias");assert_eq!(saved,3,"fragment lost witness");
        assert_eq!(got,expected,"one fragment's death must not delete surviving siblings");
    }}
}
