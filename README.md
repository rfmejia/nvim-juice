*nvim-juice* is my personal Neovim configuration written in [Fennel](https://fennel-lang.org).

* Bootstrap dependencies upon first run
* Automatically compile fennel config files into lua using [nfnl](https://github.com/Olical/nfnl)
* Manage packages using [lazy.nvim](https://github.com/folke/lazy.nvim)

## Quick start

To install, simply clone this repository to your `${XDG_CONFIG_HOME}` and run nvim:

``` git clone https://github.com/rfmejia/nvim-juice ${XDG_CONFIG_HOME}/nvim nvim ```

## Modifying Fennel configuration

All configuration is located in `fnl/`. `nfnl` automatically compiles fennel files upon saving into
`lua/`. Special handling is performed for `fnl/init.fnl` and `fnl/after/` to conform to the Neovim
directory structure; see `.nfnl.fnl` for the mapping function.

## LSP Servers

This configures the following LSP servers using
[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/)

* [clojure_lsp](https://clojure-lsp.io/)
* [fennel-ls](https://git.sr.ht/~xerool/fennel-ls/tree/HEAD/docs/installation.md)
* [gopls](https://github.com/golang/tools/blob/master/gopls/README.md)
* [jdtls](https://github.com/eclipse-jdtls/eclipse.jdt.ls)

* [scalametals](https://scalameta.org/metals/) via [nvim-metals](https://scalameta.org/metals/)
