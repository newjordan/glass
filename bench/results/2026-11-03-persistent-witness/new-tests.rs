/// Independent explicit destinations for resize-only state, including the two
/// histories that the previous stateless mapper collapsed. No output of the
/// mapper is used to construct expected coordinates.
#[test]
#[ignore = "research diagnostic: persistent witness roundtrips"]
fn persistent_witness_roundtrips() {
    fn position(engine: &Engine, intake: &mut Intake) -> Vec<(i32,i32)> {
        let top=engine.scrolled_off_top().saturating_sub(engine.history_size()) as u64;
        let view=intake.describe(View {top,rows:(engine.history_size()+16) as u16,alternate:false});
        view.placements.iter().map(|p|(p.row.round() as i32+top as i32-engine.scrolled_off_top() as i32,p.column.round() as i32)).collect()
    }
    fn resize(engine: &mut Engine,intake: &mut Intake,height: usize,width: usize,alt: bool) {
        if alt {feed(engine,intake,b"\x1b[?1049h");}
        engine.resize(height,width);
        if let Some(r)=engine.take_reflow(){intake.reflow(&r);intake.set_scrolled_primary(engine.scrolled_off_top() as u64,engine.history_size(),height as u16);}
        if alt {feed(engine,intake,b"\x1b[?1049l");}
    }
    let mut cases=0;
    for alt in [false,true] { for fast in [false,true] {
        let mut states=Vec::new();
        for (name,cup,expected) in [("tail",b"\x1b[1;4H".as_slice(),(0,3)),("blank",b"\x1b[2;1H".as_slice(),(1,0))] {
            let mut e=engine(4,10);e.set_fast(fast);let mut i=Intake::new(8);i.set_cell((10,20));
            feed(&mut e,&mut i,b"M");feed(&mut e,&mut i,cup);feed(&mut e,&mut i,&picture(1001));feed(&mut e,&mut i,b"\x1b[1;1H");
            let mut positions=Vec::new();let mut anchors=Vec::new();let mut text=Vec::new();
            for (step,(height,width)) in [(2,3),(4,10),(2,3),(4,10)].into_iter().enumerate() {
                resize(&mut e,&mut i,height,width,alt);
                let got=position(&e,&mut i);let want=if step%2==0 {(1,0)} else {expected};
                eprintln!("roundtrip-case alt={alt} fast={fast} name={name} step={step} pictures={got:?} expected={want:?} anchor={:?}",i.resize_anchors);
                assert_eq!(got,vec![want]);
                positions.push(got);anchors.push(format!("{:?}",i.resize_anchors));
                text.push((-(e.history_size() as i32)..height as i32).map(|r|e.grid_line(r)).collect::<Vec<_>>());
                cases+=1;
            }
            states.push((positions,anchors,text));
        }
        assert_eq!(states[0].0[0],states[1].0[0],"same collapsed picture");
        assert_eq!(states[0].2,states[1].2,"same grid throughout");
        assert_ne!(states[0].1[0],states[1].1[0],"persistent identity differs at collapse");
        assert_ne!(states[0].0[1],states[1].0[1],"both original slots return, neither deleted");
        // A right-hand witness gives a negative offset; full-width Unicode
        // spacers must not be selected in preference to the actual glyph.
        for (name,bytes,column) in [("right",b"\x1b[1;7HM\x1b[1;5H".as_slice(),4),("wide","\x1b[1;3H漢\x1b[1;6H".as_bytes(),5)] {
            let mut e=engine(6,10);e.set_fast(fast);let mut i=Intake::new(8);i.set_cell((10,20));
            feed(&mut e,&mut i,bytes);feed(&mut e,&mut i,&picture(1002));feed(&mut e,&mut i,b"\x1b[1;1H");
            for (step,width) in [3,10,7,10].into_iter().enumerate() {
                resize(&mut e,&mut i,6,width,alt);
                // Oracle is the unique text glyph plus a fixed initial signed
                // offset, independently scanning actual text (not Reflow).
                // Width changes can push the marker into retained history.
                let needle=if name=="right" {'M'} else {'漢'};
                let markers:Vec<_>=(-(e.history_size() as i32)..6).flat_map(|row|e.grid_line(row).chars().enumerate().filter_map(move |(col,ch)|(ch==needle).then_some((row,col as i32))).collect::<Vec<_>>()).collect();
                assert_eq!(markers.len(),1);
                let delta=if name=="right" {-2} else {3};
                let flat=markers[0].0*width as i32+markers[0].1+delta;
                let want=(flat.div_euclid(width as i32),flat.rem_euclid(width as i32));
                let _ = column; // Screen-relative row is not roundtrip-invariant: text can enter history.
                let got=position(&e,&mut i);
                eprintln!("roundtrip-case alt={alt} fast={fast} name={name} step={step} pictures={got:?} expected={want:?} anchor={:?}",i.resize_anchors);
                assert_eq!(got,vec![want]);cases+=1;
            }
        }
    }}
    eprintln!("roundtrip-summary cases={cases}");assert_eq!(cases,64);
}

/// Deliberate out-of-scope falsification. Moving the witness's text by a band
/// scroll between resizes must not be misreported as a successful anchor.
#[test]
#[ignore = "research diagnostic: intervening scroll invalidates prototype state"]
fn persistent_witness_intervening_scroll_characterization() {
    for fast in [false,true] {
        let mut e=engine(6,10);e.set_fast(fast);let mut i=Intake::new(8);i.set_cell((10,20));
        feed(&mut e,&mut i,b"\x1b[3;1HM\x1b[3;4H");feed(&mut e,&mut i,&picture(1003));feed(&mut e,&mut i,b"\x1b[1;1H");
        e.resize(6,7);let r=e.take_reflow().unwrap();i.reflow(&r);i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),6);
        feed(&mut e,&mut i,b"\x1b[2;5r\x1b[1S");
        e.resize(6,10);let r=e.take_reflow().unwrap();i.reflow(&r);i.set_scrolled_primary(e.scrolled_off_top() as u64,e.history_size(),6);
        let markers:Vec<_>=(0..6).flat_map(|row|e.grid_line(row).chars().enumerate().filter_map(move |(col,ch)|(ch=='M').then_some((row,col as i32))).collect::<Vec<_>>()).collect();
        let view=i.describe(View{top:e.top_line(),rows:6,alternate:false});
        let pics:Vec<_>=view.placements.iter().map(|p|(p.row.round() as i32,p.column.round() as i32)).collect();
        eprintln!("scroll-characterization fast={fast} markers={markers:?} pictures={pics:?}");
        assert_eq!(markers,vec![(1,0)]);
        assert_ne!(pics,vec![(1,3)],"known out-of-scope prototype failure");
    }
}
