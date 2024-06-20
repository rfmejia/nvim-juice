-- [nfnl] Compiled from fnl/after/ftplugin/clojure.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.util")
local set_opts = _local_2_["set-opts"]
set_opts({shiftwidth = 2, tabstop = 2, expandtab = true, textwidth = 100, commentstring = ";; %s"})
local function _3_()
  return vim.lsp.buf.format({async = false})
end
return vim.api.nvim_create_autocmd("BufWritePre", {callback = _3_, desc = "vim.lsp.buf.format", pattern = {"*.clj", "*.edn"}, group = vim.api.nvim_create_augroup("format_group", {clear = true})})
