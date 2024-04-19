-- [nfnl] Compiled from fnl/juice/util.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.core")
local merge = _local_2_["merge"]
local reduce = _local_2_["reduce"]
local table_3f = _local_2_["table?"]
local function make_opts(keys)
  local function _3_(acc, key)
    return merge(acc, {[key] = true})
  end
  return reduce(_3_, {}, keys)
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
  _G.assert((nil ~= str), "Missing argument str on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:24")
  return string.format("<cmd>lua %s<cr>", str)
end
local function lua_statusline(command)
  _G.assert((nil ~= command), "Missing argument command on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:28")
  return string.format("%%{luaeval(\"%s\")}", command)
end
local function executable_3f(cmd)
  _G.assert((nil ~= cmd), "Missing argument cmd on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:32")
  return (vim.fn.executable(cmd) == 1)
end
local function has_3f(cmd)
  _G.assert((nil ~= cmd), "Missing argument cmd on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:36")
  return (vim.fn.has(cmd) == 1)
end
local function set_opts(options)
  _G.assert((nil ~= options), "Missing argument options on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:40")
  if table_3f(options) then
    for k, v in pairs(options) do
      vim.opt[k] = v
    end
    return nil
  else
    return nil
  end
end
local function auto_setup(module)
  _G.assert((nil ~= module), "Missing argument module on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:46")
  return autoload(module).setup()
end
return {nmap = nmap, imap = imap, vmap = vmap, tmap = tmap, ["lua-cmd"] = lua_cmd, ["lua-statusline"] = lua_statusline, ["executable?"] = executable_3f, ["has?"] = has_3f, ["set-opts"] = set_opts, ["auto-setup"] = auto_setup, augroup = vim.api.nvim_create_augroup, autocmd = vim.api.nvim_create_autocmd, ["user-command"] = vim.api.nvim_create_user_command}
