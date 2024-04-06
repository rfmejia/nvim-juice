-- [nfnl] Compiled from after/ftplugin/asciidoc.fnl by https://github.com/Olical/nfnl, do not edit.
local a = require("nfnl.core")
local u = require("util")
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.spell = true
vim.opt.spelllang = "en_us"
u.nmap("<localleader>D", ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '\\n== \\%s\\n\\n'<cr>k", {"noremap", "silent"})
return u.nmap("<localleader>t", ":r!date '+\\%H:\\%M' | xargs -0 printf '=== \\%s ' | tr -d '\\n'<cr>A", {"noremap", "silent"})