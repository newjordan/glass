# alacritty_terminal, as glass carries it

This crate is a fork of **[`alacritty_terminal`](https://crates.io/crates/alacritty_terminal)
0.26.0**, the terminal library of the [Alacritty](https://alacritty.org)
project. It keeps the screen a program's output draws: the grid, the
scrollback, the cursor, the modes, and what every escape sequence does to
them.

The library is the work of Christian Duerr, Joe Wilm and the [Alacritty
contributors](https://github.com/alacritty/alacritty/graphs/contributors).
glass is built on it, and is faster than it would otherwise be because that
work is careful, well tested and readable.

## Where it comes from

- **Source:** `alacritty_terminal/` of [alacritty/alacritty](https://github.com/alacritty/alacritty) at commit [`94e7c8874e526b1e67b349d9ba30ddf81669119e`](https://github.com/alacritty/alacritty/tree/94e7c8874e526b1e67b349d9ba30ddf81669119e/alacritty_terminal) ("Alacritty version 0.17.0"). It is identical to the 0.26.0 crate on crates.io.
- **Licence:** Apache License 2.0 ([LICENSE-APACHE](LICENSE-APACHE)), as upstream. The rest of glass is MIT; this crate stays Apache-2.0.
- **Upstream's history** is in [CHANGELOG.md](CHANGELOG.md), unchanged.

## Why a fork

glass already writes plain text, colours and cursor moves into this
library's grid itself, around the parser, and holds the result to the
library's own by tests. Going further means changing the grid, for example
how a scrolled row is cleared and how a combining mark is stored. That
needs the code here, not behind a crate boundary.

The crate is renamed (`glass-alacritty-terminal`) so it can't be taken for
an upstream release. Its library keeps the name `alacritty_terminal`, so
code using it reads as it did.

## What changed

[CHANGES.md](CHANGES.md) lists every change from upstream. Every changed
file also says at its top that glass changed it and how, as the Apache
License asks.

## Upstream

Alacritty does not accept contributions made with large language models,
and these changes were made with one, so they are not offered upstream.
They are here under the same Apache-2.0 licence for anyone to read or use.
