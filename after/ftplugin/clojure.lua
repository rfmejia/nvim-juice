-- [nfnl] Compiled from fnl/after/ftplugin/clojure.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("juice.util")
util["assoc-in"](vim.opt, {shiftwidth = 2, tabstop = 2, expandtab = true, textwidth = 100, commentstring = ";; %s", spell = false})
local function _2_()
  return vim.lsp.buf.format({async = false})
end
return vim.api.nvim_create_autocmd("BufWritePre", {callback = _2_, desc = "vim.lsp.buf.format", pattern = {"*.clj", "*.edn"}, group = vim.api.nvim_create_augroup("format_group", {clear = true})})
