-- [nfnl] Compiled from fnl/util.fnl by https://github.com/Olical/nfnl, do not edit.
local function make_opts(keys)
  local a = require("nfnl.core")
  local function _1_(acc, key)
    return a.merge(acc, {[key] = true})
  end
  return a.reduce(_1_, {}, keys)
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
return {nmap = nmap, imap = imap, vmap = vmap, tmap = tmap, ["lua-cmd"] = lua_cmd, ["lua-statusline"] = lua_statusline, ["executable?"] = executable_3f, ["has?"] = has_3f, ["exists?"] = exists_3f}
