-- [nfnl] Compiled from fnl/juice/util.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.core")
local merge = _local_2_["merge"]
local reduce = _local_2_["reduce"]
local table_3f = _local_2_["table?"]
local function make_opts(_3fopts, _3fdesc, _3fbufnr)
  local init = {desc = _3fdesc, buffer = _3fbufnr}
  local reducer
  local function _3_(acc, opt)
    return merge(acc, {[opt] = true})
  end
  reducer = _3_
  return reduce(reducer, init, _3fopts)
end
--[[ "TODO optionally add a top-level string for comments" ]]
local function map(mappings)
  _G.assert((nil ~= mappings), "Missing argument mappings on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:11")
  for mode, maps in pairs(mappings) do
    for key, params in pairs(maps) do
      local action, flags, desc, bufnr = unpack(params)
      local opts = make_opts(flags, desc, bufnr)
      vim.keymap.set(mode, key, action, opts)
    end
  end
  return nil
end
local function bufmap(bufnr, mappings)
  _G.assert((nil ~= mappings), "Missing argument mappings on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:18")
  _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:18")
  for mode, maps in pairs(mappings) do
    for key, params in pairs(maps) do
      local action, flags, desc = unpack(params)
      local opts = make_opts(flags, desc, bufnr)
      vim.keymap.set(mode, key, action, opts)
    end
  end
  return nil
end
local function nmap(key, map0, _3fopts, _3fdesc, _3fbufnr)
  _G.assert((nil ~= map0), "Missing argument map on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:25")
  _G.assert((nil ~= key), "Missing argument key on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:25")
  return vim.keymap.set("n", key, map0, make_opts(_3fopts, _3fdesc, _3fbufnr))
end
local function imap(key, map0, _3fopts, _3fdesc, _3fbufnr)
  _G.assert((nil ~= map0), "Missing argument map on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:29")
  _G.assert((nil ~= key), "Missing argument key on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:29")
  return vim.keymap.set("i", key, map0, make_opts(_3fopts, _3fdesc, _3fbufnr))
end
local function vmap(key, map0, _3fopts, _3fdesc, _3fbufnr)
  _G.assert((nil ~= map0), "Missing argument map on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:33")
  _G.assert((nil ~= key), "Missing argument key on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:33")
  return vim.keymap.set("v", key, map0, make_opts(_3fopts, _3fdesc, _3fbufnr))
end
local function tmap(key, map0, _3fopts, _3fdesc, _3fbufnr)
  _G.assert((nil ~= map0), "Missing argument map on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:37")
  _G.assert((nil ~= key), "Missing argument key on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:37")
  return vim.keymap.set("t", key, map0, make_opts(_3fopts, _3fdesc, _3fbufnr))
end
local function lua_cmd(str)
  _G.assert((nil ~= str), "Missing argument str on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:41")
  return string.format("<cmd>lua %s<cr>", str)
end
local function lua_statusline(command)
  _G.assert((nil ~= command), "Missing argument command on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:45")
  return string.format("%%{luaeval(\"%s\")}", command)
end
local function executable_3f(cmd)
  _G.assert((nil ~= cmd), "Missing argument cmd on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:49")
  return (vim.fn.executable(cmd) == 1)
end
local function has_3f(cmd)
  _G.assert((nil ~= cmd), "Missing argument cmd on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:53")
  return (vim.fn.has(cmd) == 1)
end
local function set_opts(options)
  _G.assert((nil ~= options), "Missing argument options on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:57")
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
  _G.assert((nil ~= module), "Missing argument module on /home/rfmejia/.config/nvim/fnl/juice/util.fnl:63")
  return autoload(module).setup()
end
return {nmap = nmap, imap = imap, vmap = vmap, tmap = tmap, map = map, bufmap = bufmap, ["lua-cmd"] = lua_cmd, ["lua-statusline"] = lua_statusline, ["executable?"] = executable_3f, ["has?"] = has_3f, ["set-opts"] = set_opts, ["auto-setup"] = auto_setup, augroup = vim.api.nvim_create_augroup, autocmd = vim.api.nvim_create_autocmd}
