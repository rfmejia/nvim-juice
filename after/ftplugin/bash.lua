-- [nfnl] fnl/after/ftplugin/bash.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
return core["merge!"](vim.opt_local, {makeprg = "/usr/bin/env bash %", signcolumn = "no", textwidth = 80})
