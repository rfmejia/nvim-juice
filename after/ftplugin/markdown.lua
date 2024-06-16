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
return util.bufmap(vim.api.nvim_get_current_buf(), {n = {["<localleader>m"] = {util["lua-cmd"]("require('juice.filetypes.markdown')['insert-yaml-metadata']()"), {"noremap", "silent"}}, ["<localleader>v"] = {util["lua-cmd"]("require('juice.filetypes.markdown')['render-markdown-to-html']()"), {"noremap", "silent"}}, ["<localleader>d"] = {":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '----\\n\\n\\%s\\n'<cr>", {"noremap", "silent"}}, ["<localleader>t"] = {":r!date '+\\%H:\\%M' | xargs -0 printf '> \\%s ' | tr -d '\\n'<cr>A", {"noremap", "silent"}}}})
