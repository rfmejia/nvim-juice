-- [nfnl] fnl/juice/util.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local inspect = autoload("vim.inspect")
local function lua_cmd(str)
  if (nil == str) then
    _G.error("Missing argument str on fnl/juice/util.fnl:5", 2)
  else
  end
  return string.format("<cmd>lua %s<cr>", str)
end
local function executable_3f(cmd)
  if (nil == cmd) then
    _G.error("Missing argument cmd on fnl/juice/util.fnl:9", 2)
  else
  end
  return (vim.fn.executable(cmd) == 1)
end
local function has_3f(cmd)
  if (nil == cmd) then
    _G.error("Missing argument cmd on fnl/juice/util.fnl:12", 2)
  else
  end
  return (vim.fn.has(cmd) == 1)
end
local function set_keys(mappings)
  if (nil == mappings) then
    _G.error("Missing argument mappings on fnl/juice/util.fnl:15", 2)
  else
  end
  for _, mapping in ipairs(mappings) do
    vim.keymap.set(unpack(mapping))
  end
  return nil
end
local function call(module, func, ...)
  if (nil == func) then
    _G.error("Missing argument func on fnl/juice/util.fnl:19", 2)
  else
  end
  if (nil == module) then
    _G.error("Missing argument module on fnl/juice/util.fnl:19", 2)
  else
  end
  return autoload(module)[func](...)
end
local function call_setup(modules)
  if (nil == modules) then
    _G.error("Missing argument modules on fnl/juice/util.fnl:23", 2)
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
local function index_of(seq_table, value)
  if (nil == value) then
    _G.error("Missing argument value on fnl/juice/util.fnl:28", 2)
  else
  end
  if (nil == seq_table) then
    _G.error("Missing argument seq-table on fnl/juice/util.fnl:28", 2)
  else
  end
  local function loop(states, idx, target)
    if core["nil?"](states[idx]) then
      return nil
    elseif (inspect(states[idx]) == target) then
      return idx
    elseif "else" then
      return loop(states, core.inc(idx), target)
    else
      return nil
    end
  end
  return loop(seq_table, 1, inspect(value))
end
local function next_state(states, state, _3ffallback)
  if (nil == state) then
    _G.error("Missing argument state on fnl/juice/util.fnl:38", 2)
  else
  end
  if (nil == states) then
    _G.error("Missing argument states on fnl/juice/util.fnl:38", 2)
  else
  end
  local new_state
  if (state ~= nil) then
    local tmp_6_ = index_of(states, state)
    if (tmp_6_ ~= nil) then
      local tmp_6_0 = core.inc(tmp_6_)
      if (tmp_6_0 ~= nil) then
        new_state = states[tmp_6_0]
      else
        new_state = nil
      end
    else
      new_state = nil
    end
  else
    new_state = nil
  end
  return (new_state or _3ffallback or states[1])
end
return {["lua-cmd"] = lua_cmd, ["executable?"] = executable_3f, ["has?"] = has_3f, ["set-keys"] = set_keys, call = call, ["call-setup"] = call_setup, ["index-of"] = index_of, ["next-state"] = next_state}
