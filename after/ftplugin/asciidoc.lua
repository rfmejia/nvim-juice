-- [nfnl] Compiled from fnl/after/ftplugin/asciidoc.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = require("juice.util")
local nmap = _local_2_["nmap"]
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.spell = true
vim.opt.spelllang = "en_us"
nmap("<localleader>D", ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '\\n== \\%s\\n\\n'<cr>k", {"noremap", "silent"})
return nmap("<localleader>t", ":r!date '+\\%H:\\%M' | xargs -0 printf '=== \\%s ' | tr -d '\\n'<cr>A", {"noremap", "silent"})
