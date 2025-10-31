-- [nfnl] fnl/after/ftplugin/clojure.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
core["merge!"](vim.opt_local, {shiftwidth = 2, tabstop = 2, expandtab = true, textwidth = 100, spell = true, spellfile = "clj.en.utf-8.add", commentstring = ";; %s"})
local function _2_()
  return vim.lsp.buf.format({async = false})
end
vim.api.nvim_create_autocmd("BufWritePre", {pattern = {"*.clj", "*.edn"}, callback = _2_, desc = "[clojure] call vim.lsp.buf.format on save", group = vim.api.nvim_create_augroup("format_group", {clear = true})})
return vim.lsp.enable("clojure_lsp")
