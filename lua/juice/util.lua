-- [nfnl] Compiled from fnl/juice/util.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local function lua_cmd(str)
  _G.assert((nil ~= str), "Missing argument str on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:4")
  return string.format("<cmd>lua %s<cr>", str)
end
local function executable_3f(cmd)
  _G.assert((nil ~= cmd), "Missing argument cmd on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:8")
  return (vim.fn.executable(cmd) == 1)
end
local function has_3f(cmd)
  _G.assert((nil ~= cmd), "Missing argument cmd on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:11")
  return (vim.fn.has(cmd) == 1)
end
local function set_keys(mappings)
  _G.assert((nil ~= mappings), "Missing argument mappings on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:14")
  for _, mapping in ipairs(mappings) do
    vim.keymap.set(unpack(mapping))
  end
  return nil
end
local function call(plugin, func, ...)
  _G.assert((nil ~= func), "Missing argument func on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:18")
  _G.assert((nil ~= plugin), "Missing argument plugin on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:18")
  return autoload(plugin)[func](...)
end
local function call_setup(...)
  for _, module in ipairs({...}) do
    call(module, "setup")
  end
  return nil
end
local function insert_lines(...)
  local buf = vim.api.nvim_get_current_buf()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local _row = (row - 1)
  return vim.api.nvim_buf_set_lines(buf, _row, (_row + 1), false, {...})
end
return {["lua-cmd"] = lua_cmd, ["executable?"] = executable_3f, ["has?"] = has_3f, ["set-keys"] = set_keys, call = call, ["call-setup"] = call_setup, ["insert-lines"] = insert_lines}
