-- [nfnl] Compiled from after/ftplugin/markdown.fnl by https://github.com/Olical/nfnl, do not edit.
local u = require("juice.util")
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
  return print(meta)
end
u.nmap("<localleader>m", u["lua-cmd"]("require('juice.filetypes.markdown')['insert-yaml-metadata']()"), {"noremap", "silent"})
u.nmap("<localleader>v", u["lua-cmd"]("require('juice.filetypes.markdown')['render-markdown-to-html']()"), {"noremap", "silent"})
u.nmap("<localleader>d", ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '----\\n\\n\\%s\\n'<cr>", {"noremap", "silent"})
return u.nmap("<localleader>t", ":r!date '+\\%H:\\%M' | xargs -0 printf '> \\%s ' | tr -d '\\n'<cr>A", {"noremap", "silent"})
