-- [nfnl] Compiled from fnl/after/ftplugin/asciidoc.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.core")
local println = _local_2_["println"]
local _local_3_ = autoload("juice.util")
local executable_3f = _local_3_["executable?"]
local bufmap = _local_3_["bufmap"]
local set_opts = _local_3_["set-opts"]
set_opts({shiftwidth = 2, tabstop = 2, textwidth = 80, wrap = true, spell = true, spelllang = "en_us"})
bufmap(vim.api.nvim_get_current_buf(), {n = {["<localleader>d"] = {":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '\\n== \\%s\\n\\n'<cr>k", {"noremap", "silent"}, "insert current date as an h2 header"}, ["<localleader>t"] = {":r!date '+\\%H:\\%M' | xargs -0 printf '=== \\%s ' | tr -d '\\n'<cr>A", {"noremap", "silent"}, "insert current time as an h3 header"}}})
local function preview_in_browser(_in, out, browser_cmd)
  _G.assert((nil ~= browser_cmd), "Missing argument browser-cmd on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:20")
  _G.assert((nil ~= out), "Missing argument out on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:20")
  _G.assert((nil ~= _in), "Missing argument in on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:20")
  if executable_3f("asciidoctor") then
    local _4_, _5_ = vim.fn.system({"asciidoctor", "-o", out, _in})
    if (nil ~= _4_) then
      local ok = _4_
      return vim.fn.system({browser_cmd, out})
    elseif ((_4_ == nil) and (nil ~= _5_)) then
      local err_msg = _5_
      return error(("Could not run asciidoctor: " .. err_msg))
    else
      return nil
    end
  else
    return nil
  end
end
if vim.env.BROWSER then
  local _in = vim.fn.expand("%:p")
  local out = "/tmp/preview.html"
  local function _8_()
    return preview_in_browser(_in, out, vim.env.BROWSER)
  end
  return bufmap(vim.api.nvim_get_current_buf(), {n = {["<localleader>p"] = {_8_, {"noremap", "silent"}, "convert to HTML and show preview in browser"}}})
else
  return nil
end
