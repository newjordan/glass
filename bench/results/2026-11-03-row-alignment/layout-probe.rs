use alacritty_terminal::{grid::Row,term::cell::Cell};
fn main() {
 println!("Control Row<Cell>: size={} alignment={}; Cell: size={} alignment={}", std::mem::size_of::<Row<Cell>>(), std::mem::align_of::<Row<Cell>>(), std::mem::size_of::<Cell>(), std::mem::align_of::<Cell>());
 println!("Pointer slot (Box<Row<Cell>>): size={} alignment={}", std::mem::size_of::<Box<Row<Cell>>>(), std::mem::align_of::<Box<Row<Cell>>>());
}
