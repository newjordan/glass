
// Production regression: physical fragment identity is internal, not a shared
// (dialect, image, placement-id) key. No resize prototype or anchor helper used.
#[test]
fn split_identity_repeated_band_scroll() {
    let mut failures=0;let mut cases=0;
    for fast in [false,true] {for local_death in [false,true] {
        let mut e=engine(20,10);e.set_fast(fast);
        let mut i=Intake::new(8);i.set_cell((10,20));
        feed(&mut e,&mut i,b"\x1b[3;2H\x1b_Gi=71,s=1,v=1,a=T,f=24,c=1,r=8;AAAA\x1b\\\x1b[H");
        feed(&mut e,&mut i,b"\x1b[6;20r\x1b[1T\x1b[4;20r\x1b[1T");
        let before:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        let seq:Vec<_>=i.placements.iter().map(|p|p.seq).collect();
        let unique=seq.iter().copied().collect::<std::collections::HashSet<_>>().len();
        // First source row; remaining source rows after two successive splits.
        let sources:Vec<_>=i.placements.iter().map(|p|p.source.unwrap()).collect();
        let source_ok=sources.iter().zip([[0.0,0.0,1.0,0.125],[0.0,0.125,1.0,0.25],[0.0,0.375,1.0,0.625]])
            .all(|(got,want)|got.iter().zip(want).all(|(a,b)|(*a-b).abs()<0.00001));
        if local_death {feed(&mut e,&mut i,b"\x1b[3;4r\x1b[1S");}
        let got:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        let expected=if local_death {vec![(4,1.0,2.0),(7,1.0,5.0)]}else{vec![(2,1.0,1.0),(4,1.0,2.0),(7,1.0,5.0)]};
        let max=*seq.iter().max().unwrap();
        feed(&mut e,&mut i,b"\x1b[1;10H\x1b_Gi=72,s=1,v=1,a=T,f=24,c=1,r=1;AAAA\x1b\\");
        let next=i.placements.iter().find(|p|p.picture==72).unwrap().seq;
        let monotonic=next>max;
        feed(&mut e,&mut i,b"\x1b_Ga=d,d=I,i=71;\x1b\\");
        let deleted=i.placements.iter().all(|p|p.picture!=71) && i.placements.len()==1;
        let pass=before==vec![(2,1.0,1.0),(4,1.0,2.0),(7,1.0,5.0)] && source_ok && got==expected && unique==3 && monotonic && deleted;
        eprintln!("split-identity-json {}",serde_json::json!({"fast":fast,"local_death":local_death,"before":before,"seq":seq,"unique":unique,"sources":sources,"got":got,"expected":expected,"next":next,"deleted":deleted,"pass":pass}));
        cases+=1;if !pass {failures+=1;}
    }}
    eprintln!("split-identity-summary cases={cases} failures={failures}");
    assert_eq!(cases,4);assert_eq!(failures,0,"fragment identity/lifetime failure");
}
