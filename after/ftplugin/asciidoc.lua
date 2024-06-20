-- [nfnl] Compiled from fnl/after/ftplugin/asciidoc.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.util")
local executable_3f = _local_2_["executable?"]
local set_opts = _local_2_["set-opts"]
local util = autoload("juice.util")
util["set-opts"]({shiftwidth = 2, tabstop = 2, textwidth = 80, wrap = true, spell = true, spelllang = "en_us"})
util["set-keys"]({{"n", "<localleader>d", ":r!date '+\\%a, \\%d \\%b \\%Y' | xargs -0 printf '\\n== \\%s\\n\\n'<cr>k", {desc = "insert current date as an h2 header", buffer = vim.api.nvim_get_current_buf(), silent = true}}, {"n", "<localleader>t", ":r!date '+\\%H:\\%M' | xargs -0 printf '=== \\%s ' | tr -d '\\n'<cr>A", {desc = "insert current time as an h3 header", buffer = vim.api.nvim_get_current_buf(), silent = true}}})
local function preview_in_browser(_in, out, browser_cmd)
  _G.assert((nil ~= browser_cmd), "Missing argument browser-cmd on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:25")
  _G.assert((nil ~= out), "Missing argument out on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:25")
  _G.assert((nil ~= _in), "Missing argument in on /home/rfmejia/.config/nvim/fnl/after/ftplugin/asciidoc.fnl:25")
  if util["executable?"]("asciidoctor") then
    local _3_, _4_ = vim.fn.system({"asciidoctor", "-o", out, _in})
    if (nil ~= _3_) then
      local ok = _3_
      return vim.fn.system({browser_cmd, out})
    elseif ((_3_ == nil) and (nil ~= _4_)) then
      local err_msg = _4_
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
  local function _7_()
    return preview_in_browser(_in, out, vim.env.BROWSER)
  end
  return vim.keymap.set("n", "<localleader>p", _7_, {desc = "convert to HTML and show preview in browser", buffer = vim.api.nvim_get_current_buf()})
else
  return nil
end
