-- [nfnl] Compiled from fnl/after/ftplugin/markdown.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local util = autoload("juice.util")
util["assoc-in"](vim.opt, {shiftwidth = 2, tabstop = 2, textwidth = 100, wrap = true, spell = true, spelllang = "en_us"})
local function render_markdown_to_html()
  local current_file = vim.fn.expand("%:p")
  local tmp_file = vim.fn.system({"mktemp", "--suffix=.html"})
  local pandoc_cmd = {"pandoc", "--standalone", "--embed-resource", "-c", "~/.pandoc/github-markdown.css", "-f", "gfm", "-t", "html", current_file, "-o", tmp_file}
  local browser_cmd = {vim.env.BROWSER, tmp_file}
  return (vim.fn.system(pandoc_cmd) and vim.fn.system(browser_cmd))
end
local function insert_yaml_metadata()
  local filename = vim.fn.expand("%:t:r")
  local now = vim.fn.strftime("%FT%T%z", vim.fn.localtime())
  return util["insert-lines"]("---", ("title: " .. filename), ("created: " .. now), "tags: []", "---", "")
end
return util["set-keys"]({{"n", "<localleader>m", insert_yaml_metadata, {desc = "[markdown] insert metadata as a YAML header", buffer = vim.api.nvim_get_current_buf(), silent = true}}, {"n", "<localleader>v", render_markdown_to_html, {desc = "[markdown] convert to HTML and show preview in browser", buffer = vim.api.nvim_get_current_buf(), silent = true}}})
