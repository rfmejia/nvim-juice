-- [nfnl] Compiled from fnl/after/ftplugin/markdown.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.util")
local lua_cmd = _local_2_["lua-cmd"]
local nmap = _local_2_["nmap"]
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.textwidth = 80
vim.opt.wrap = true
vim.opt.spell = true
vim.opt.spelllang = "en_us"
local function render_markdown_to_html()
  local tmp_file = vim.fn.system({"mktemp", "--suffix=.html"})
  local current_file = vim.fn.expand("%:p")
  return vim.fn.system("$DOTFILES/pandoc/md-to-html", current_file, tmp_file, "&& ${BROWSER}", tmp_file)
end
local function insert_yaml_metadata()
  local filename = vim.fn.expand("%:t:r")
  local now = vim.fn.strftime("%FT%T%z", vim.fn.localtime())
  local meta = {"---", "title: ", filename, "created: ", now, "tags: []", "---"}
  return vim.print(meta)
end
nmap("<localleader>m", lua_cmd("require('juice.filetypes.markdown')['insert-yaml-metadata']()"), {"noremap", "silent"})
nmap("<localleader>v", lua_cmd("require('juice.filetypes.markdown')['render-markdown-to-html']()"), {"noremap", "silent"})
nmap("<localleader>d", ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '----\\n\\n\\%s\\n'<cr>", {"noremap", "silent"})
return nmap("<localleader>t", ":r!date '+\\%H:\\%M' | xargs -0 printf '> \\%s ' | tr -d '\\n'<cr>A", {"noremap", "silent"})
