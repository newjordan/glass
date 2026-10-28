# Changes from upstream

Every change glass has made to `alacritty_terminal` 0.26.0 (upstream commit
`94e7c8874e526b1e67b349d9ba30ddf81669119e`). Each changed file also says so
at its top.

## Packaging

- **The package is renamed `glass-alacritty-terminal`, and is not published.** Its library is still `alacritty_terminal`.
- **The manifest** stands on its own rather than inheriting from upstream's workspace: edition 2024 as upstream, and glass's minimum Rust version.
- **Upstream's `rustfmt.toml`** is copied in, so the code keeps upstream's formatting.
- **Unchanged:** the dependencies, the features, the source (`src/`) and the tests (`tests/`, the reference tests included) are as upstream has them.
