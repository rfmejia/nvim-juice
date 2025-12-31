-- [nfnl] fnl/juice/util.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local function lua_cmd(str)
  if (nil == str) then
    _G.error("Missing argument str on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:4", 2)
  else
  end
  return string.format("<cmd>lua %s<cr>", str)
end
local function executable_3f(cmd)
  if (nil == cmd) then
    _G.error("Missing argument cmd on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:8", 2)
  else
  end
  return (vim.fn.executable(cmd) == 1)
end
local function has_3f(cmd)
  if (nil == cmd) then
    _G.error("Missing argument cmd on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:11", 2)
  else
  end
  return (vim.fn.has(cmd) == 1)
end
local function set_keys(mappings)
  if (nil == mappings) then
    _G.error("Missing argument mappings on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:14", 2)
  else
  end
  for _, mapping in ipairs(mappings) do
    vim.keymap.set(unpack(mapping))
  end
  return nil
end
local function apply(f, params)
  if (nil == params) then
    _G.error("Missing argument params on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:18", 2)
  else
  end
  if (nil == f) then
    _G.error("Missing argument f on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:18", 2)
  else
  end
  if (core["sequential?"](params) and core["sequential?"](core.first(params))) then
    for _, subparams in ipairs(params) do
      core.pr({subparams = subparams})
      if not core["nil?"](subparams) then
        f(unpack(subparams))
      else
      end
    end
    return nil
  elseif core["sequential?"](params) then
    return f(unpack(params))
  elseif "else" then
    return f(params)
  else
    return nil
  end
end
--[[ (apply vim.print "single") (apply vim.print ["a" "b"]) (apply core.println [[1 2] [3 4]\]) (apply core.println [[1 2] nil [3 4]\]) ]]
local function call(module, func, ...)
  if (nil == func) then
    _G.error("Missing argument func on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:35", 2)
  else
  end
  if (nil == module) then
    _G.error("Missing argument module on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:35", 2)
  else
  end
  return autoload(module)[func](...)
end
local function call_setup(modules)
  if (nil == modules) then
    _G.error("Missing argument modules on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:39", 2)
  else
  end
  if core["string?"](modules) then
    return call(modules, "setup")
  elseif core["sequential?"](modules) then
    for _, module in ipairs(modules) do
      call(module, "setup")
    end
    return nil
  else
    return nil
  end
end
return {["lua-cmd"] = lua_cmd, ["executable?"] = executable_3f, ["has?"] = has_3f, ["set-keys"] = set_keys, call = call, ["call-setup"] = call_setup}
