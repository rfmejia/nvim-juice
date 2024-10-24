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
  _G.assert((nil ~= cmd), "Missing argument cmd on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:12")
  return (vim.fn.has(cmd) == 1)
end
local function set_keys(mappings)
  _G.assert((nil ~= mappings), "Missing argument mappings on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:16")
  for _, mapping in ipairs(mappings) do
    vim.keymap.set(unpack(mapping))
  end
  return nil
end
local function assoc_in(t, ...)
  _G.assert((nil ~= t), "Missing argument t on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:20")
  for _, options in ipairs({...}) do
    if core["table?"](options) then
      for k, v in pairs(options) do
        core.assoc(t, k, v)
      end
    else
    end
  end
  return nil
end
local function auto_setup(...)
  for _, module in ipairs({...}) do
    autoload(module).setup()
  end
  return nil
end
return {["lua-cmd"] = lua_cmd, ["executable?"] = executable_3f, ["has?"] = has_3f, ["set-keys"] = set_keys, ["assoc-in"] = assoc_in, ["auto-setup"] = auto_setup}
