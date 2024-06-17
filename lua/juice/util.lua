-- [nfnl] Compiled from fnl/juice/util.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local function make_opts(_3fopts, _3fdesc, _3fbufnr)
  local init = {desc = _3fdesc, buffer = _3fbufnr}
  local reducer
  local function _2_(acc, opt)
    return core.merge(acc, {[opt] = true})
  end
  reducer = _2_
  return core.reduce(reducer, init, _3fopts)
end
local function bufmap(bufnr, mappings)
  _G.assert((nil ~= mappings), "Missing argument mappings on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:10")
  _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:10")
  for mode, maps in pairs(mappings) do
    for key, params in pairs(maps) do
      local action, flags, desc = unpack(params)
      local opts = make_opts(flags, desc, bufnr)
      vim.keymap.set(mode, key, action, opts)
    end
  end
  return nil
end
local function lua_cmd(str)
  _G.assert((nil ~= str), "Missing argument str on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:17")
  return string.format("<cmd>lua %s<cr>", str)
end
local function executable_3f(cmd)
  _G.assert((nil ~= cmd), "Missing argument cmd on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:21")
  return (vim.fn.executable(cmd) == 1)
end
local function has_3f(cmd)
  _G.assert((nil ~= cmd), "Missing argument cmd on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:25")
  return (vim.fn.has(cmd) == 1)
end
local function set_keys(mappings)
  _G.assert((nil ~= mappings), "Missing argument mappings on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:29")
  for _, mapping in ipairs(mappings) do
    local mode, lhs, rhs, opts = unpack(mapping)
    vim.keymap.set(mode, lhs, rhs, opts)
  end
  return nil
end
local function set_opts(options)
  _G.assert((nil ~= options), "Missing argument options on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:34")
  if core["table?"](options) then
    for k, v in pairs(options) do
      vim.opt[k] = v
    end
    return nil
  else
    return nil
  end
end
local function auto_setup(module)
  _G.assert((nil ~= module), "Missing argument module on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:40")
  return autoload(module).setup()
end
return {bufmap = bufmap, ["lua-cmd"] = lua_cmd, ["executable?"] = executable_3f, ["has?"] = has_3f, ["set-keys"] = set_keys, ["set-opts"] = set_opts, ["auto-setup"] = auto_setup}
