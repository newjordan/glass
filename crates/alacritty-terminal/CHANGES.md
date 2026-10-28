# Changes from upstream

Every change glass has made to `alacritty_terminal` 0.26.0 (upstream commit
`94e7c8874e526b1e67b349d9ba30ddf81669119e`). Each changed file also says
so at its top, under a line beginning `Changed for glass`, so
`grep -rl "Changed for glass" src` lists them.

## Packaging

- **The package is renamed `glass-alacritty-terminal`, and is not published.** Its library is still `alacritty_terminal`.
- **The manifest** stands on its own rather than inheriting from upstream's workspace: edition 2024 as upstream, and glass's minimum Rust version.
- **Upstream's `rustfmt.toml`** is copied in, so the code keeps upstream's formatting. Its options need nightly rustfmt: `cargo +nightly fmt -p glass-alacritty-terminal`.
- **Upstream's `CHANGELOG.md`** is its history up to 0.26.0, unchanged. Changes since then are listed here.

## Upstream's fixes since 0.26.0

Upstream made these fixes on `master` after the 0.26.0 release; glass takes them as written. Only the library's part of each commit is applied, without the changelog lines.

| Upstream commit | Author | What it fixes |
| --- | --- | --- |
| [`985394dd`](https://github.com/alacritty/alacritty/commit/985394dd42ca1408868ccee8070c8c75cccd762f) | Neel | Making the pty non-blocking returns an error rather than panicking (`tty/unix.rs`). |
| [`7dd7b5b0`](https://github.com/alacritty/alacritty/commit/7dd7b5b09e06ca58daadfb12bd45a9aa8fa716f2) | Kevan | An off-by-one in the vi motion `ParagraphUp` (`vi_mode.rs`). |
| [`ede2ac14`](https://github.com/alacritty/alacritty/commit/ede2ac144da4dec4c075bfa803aacf3b3739bce6) | Daniel Fox Franke | A cell keeps at most 9 zerowidth characters. Before, a program could exhaust memory by writing marks onto one cell forever (`term/cell.rs`; adds the `arrayvec` dependency). |
| [`d692748d`](https://github.com/alacritty/alacritty/commit/d692748d3f61253ebe9f5094320120d22f6a046f) | Daniel Fox Franke | `Row::new` builds a row without `unsafe` and without a hidden one-column minimum (`grid/row.rs`). |
| [`54214706`](https://github.com/alacritty/alacritty/commit/542147067dd016fc5f49120ef0ba605a98a4e3a7) | Christian Duerr | A full keyboard mode stack drops its own oldest entry. Before, it dropped the title stack's (`term/mod.rs`). |

## Lints

Upstream's `lib.rs` denies clippy's warnings. Now that the library is a member of glass's workspace, clippy checks it, and clippy 1.99 has lints newer than upstream's code. These changes don't change behaviour.

- **`event_loop.rs`, `selection.rs`, `term/mod.rs`:** four nested `if`s are written as `if … && let` chains (`collapsible_if`).
- **`term/mod.rs`:** a tab stop test uses `is_multiple_of` (`manual_is_multiple_of`).
- **`tty/unix.rs`:** `ShellUser::from_env` allows `question_mark`, because the suggested `?` would move `pw`, which the later fields still read.
