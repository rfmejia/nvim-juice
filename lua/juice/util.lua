-- [nfnl] Compiled from fnl/juice/util.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local function make_opts(keys)
  local a = autoload("nfnl.core")
  local function _2_(acc, key)
    return a.merge(acc, {[key] = true})
  end
  return a.reduce(_2_, {}, keys)
end
local function nmap(key, map, opts)
  return vim.keymap.set("n", key, map, make_opts(opts))
end
local function imap(key, map, opts)
  return vim.keymap.set("i", key, map, make_opts(opts))
end
local function vmap(key, map, opts)
  return vim.keymap.set("v", key, map, make_opts(opts))
end
local function tmap(key, map, opts)
  return vim.keymap.set("t", key, map, make_opts(opts))
end
local function lua_cmd(str)
  return string.format("<cmd>lua %s<cr>", str)
end
local function lua_statusline(command)
  return string.format("%%{luaeval(\"%s\")}", command)
end
local function executable_3f(cmd)
  return (vim.fn.executable(cmd) == 1)
end
local function has_3f(cmd)
  return (vim.fn.has(cmd) == 1)
end
local function exists_3f(env)
  return (vim.fn.exists(env) == 1)
end
local function set_opts(options)
  local core = autoload("nfnl.core")
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
  return autoload(module).setup()
end
return {nmap = nmap, imap = imap, vmap = vmap, tmap = tmap, ["lua-cmd"] = lua_cmd, ["lua-statusline"] = lua_statusline, ["executable?"] = executable_3f, ["has?"] = has_3f, ["exists?"] = exists_3f, ["set-opts"] = set_opts, ["auto-setup"] = auto_setup}
