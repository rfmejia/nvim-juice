**nvim-juice** is my personal neovim configuration written in [Fennel][1].

- Simple bootstrapping of dependencies inside `init.lua`
- Clearly and concisely configures neovim using a LISP and [Aniseed][2]
- Efficiently manages packages via [lazy.nvim][3]

## Quick start

To install, simply

1. Clone this repository, and
2. Create a symlink of `init.lua` and `fnl/` into your `${XDG_CONFIG_HOME}`

That's it. Upon starting neovim the script will download the bare minimum
packages, add them to your runtime path, transpile Fennel config files into Lua,
and rest of the packages will be configured automatically.

[1]: https://fennel-lang.org
[2]: https://github.com/olical/aniseed/
[3]: https://github.com/folke/lazy.nvim
