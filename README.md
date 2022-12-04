**nvim-juice** is a neovim plugin containing my personal configuration in Lua,
primarily for setting up LSP support. These files are called from my vimrc
which detects if it's called within neovim.

The plugin depends on the following:

```vimscript
Plug 'neovim/nvim-lspconfig'          " quickstart configs for nvim lsp
Plug 'p00f/clangd_extensions.nvim'    " lsp support for clangd's off-spec features
Plug 'scalameta/nvim-metals'          " lsp support for scala
Plug 'nvim-lua/plenary.nvim'          " lua convenience methods (nvim-metals requirement)
Plug 'mfussenegger/nvim-dap'          " debug adapter protocol support
```
