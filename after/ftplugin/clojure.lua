-- [nfnl] Compiled from fnl/after/ftplugin/clojure.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local lspconfig = autoload("lspconfig")
local util = autoload("juice.util")
util["assoc-in"](vim.opt_local, {shiftwidth = 2, tabstop = 2, expandtab = true, textwidth = 100, commentstring = ";; %s", spell = false})
local function _2_()
  return vim.lsp.buf.format({async = false})
end
vim.api.nvim_create_autocmd("BufWritePre", {pattern = {"*.clj", "*.edn"}, callback = _2_, desc = "[clojure] call vim.lsp.buf.format on save", group = vim.api.nvim_create_augroup("format_group", {clear = true})})
return lspconfig.clojure_lsp.setup({})
