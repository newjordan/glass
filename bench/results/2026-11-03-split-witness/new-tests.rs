
// Independent two-width geometry oracle: marker M is outside the scroll band.
// At width 7 picture starts one cell after M+7; SD splits it at two margins.
#[test]
fn split_witness_blank_fragment_roundtrip() {
    for fast in [false, true] {
        let mut e = engine(12, 10);
        e.set_fast(fast);
        let mut i = Intake::new(8);
        i.set_cell((10, 20));
        feed(&mut e, &mut i, b"\x1b[2;1HM\x1b[2;9H");
        feed(&mut e, &mut i, b"\x1b_Gi=71,s=1,v=1,a=T,f=24,c=1,r=5;AAAA\x1b\\");
        assert_eq!(i.placements.len(),1);
        feed(&mut e, &mut i, b"\x1b[H");
        e.resize(12,7);
        i.reflow(&e.take_reflow().expect("width reflow"));
        i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),12);
        assert_eq!((i.placements[0].line,i.placements[0].column,i.placements[0].height),(2,1.0,5.0));
        feed(&mut e,&mut i,b"\x1b[5;7r\x1b[1T");
        let middle:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        assert_eq!(middle,vec![(2,1.0,2.0),(5,1.0,2.0)]);
        e.resize(12,10);
        i.reflow(&e.take_reflow().expect("return reflow"));
        i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),12);
        let got:Vec<_>=i.placements.iter().map(|p|(p.line,p.column,p.height)).collect();
        eprintln!("split-roundtrip fast={fast} got={got:?} expected=[(1, 8.0, 2.0), (3, 9.0, 2.0)]");
        assert_eq!(got,vec![(1,8.0,2.0),(3,9.0,2.0)]);
    }
}
