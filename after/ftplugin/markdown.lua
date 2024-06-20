-- [nfnl] Compiled from fnl/after/ftplugin/markdown.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("juice.util")
util["set-opts"]({shiftwidth = 2, tabstop = 2, textwidth = 100, wrap = true, spell = true, spelllang = "en_us"})
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
return util["set-keys"]({{"n", "<localleader>m", util["lua-cmd"]("require('juice.filetypes.markdown')['insert-yaml-metadata']()"), {desc = "insert metadata as a YAML header", buffer = vim.api.nvim_get_current_buf(), silent = true}}, {"n", "<localleader>v", util["lua-cmd"]("require('juice.filetypes.markdown')['render-markdown-to-html']()"), {desc = "convert to HTML and show preview in browser", buffer = vim.api.nvim_get_current_buf(), silent = true}}, {"n", "<localleader>d", ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '----\\n\\n\\%s\\n'<cr>", {desc = "insert current date as an h2 header", buffer = vim.api.nvim_get_current_buf(), silent = true}}, {"n", "<localleader>t", ":r!date '+\\%H:\\%M' | xargs -0 printf '> \\%s ' | tr -d '\\n'<cr>A", {desc = "insert current time as an h3 header", buffer = vim.api.nvim_get_current_buf(), silent = true}}})
