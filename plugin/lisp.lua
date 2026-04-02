-- [nfnl] fnl/plugin/lisp.fnl
vim.pack.add({"https://github.com/Olical/conjure", "https://github.com/julienvincent/nvim-paredit"})
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local core = autoload("nfnl.core")
local util = autoload("juice.util")
local paredit_opts = {use_default_keys = true, indent = {enabled = true}}
local conjure_opts = {["conjure#result#register"] = "*", ["conjure#mapping#doc_word"] = "gk", ["conjure#log#botright"] = true}
util.call("nvim-paredit", "setup", paredit_opts)
return core["merge!"](vim.g, conjure_opts)
