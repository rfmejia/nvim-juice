-- [nfnl] fnl/pack/init.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local fs = autoload("nfnl.fs")
local str = autoload("nfnl.string")
local util = autoload("juice.util")
local function reify_spec(spec)
  if (nil == spec) then
    _G.error("Missing argument spec on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:7", 2)
  else
  end
  if (nil == spec.src) then
    return {"error", "Missing `src`"}
  else
    local name
    local _4_
    do
      local t_3_ = spec
      if (nil ~= t_3_) then
        t_3_ = t_3_.name
      else
      end
      _4_ = t_3_
    end
    name = (_4_ or core.last(str.split(spec.src, "/")))
    local full_spec = core.assoc(spec, "name", name)
    return {"ok", full_spec}
  end
end
local function pack_cloned_3f(_7_, pack_path)
  local name = _7_.name
  if (nil == pack_path) then
    _G.error("Missing argument pack-path on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:14", 2)
  else
  end
  if (nil == name) then
    _G.error("Missing argument name on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:14", 2)
  else
  end
  return fs["exists?"]((pack_path .. "/" .. name))
end
local function spec__3eclone_cmd(_10_, pack_path)
  local src = _10_.src
  local _3fversion = _10_.version
  if (nil == pack_path) then
    _G.error("Missing argument pack-path on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:18", 2)
  else
  end
  if (nil == src) then
    _G.error("Missing argument src on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:18", 2)
  else
  end
  if _3fversion then
    return {"git", "-C", pack_path, "clone", string.format("--branch=%s", _3fversion), src}
  else
    return {"git", "-C", pack_path, "clone", src}
  end
end
local function clone_src(spec, pack_path)
  if (nil == pack_path) then
    _G.error("Missing argument pack-path on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:24", 2)
  else
  end
  if (nil == spec) then
    _G.error("Missing argument spec on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:24", 2)
  else
  end
  vim.notify(string.format("[pack] Cloning %s to %s...", spec.name, pack_path))
  local function _16_(...)
    if ((_G.type(...) == "table") and ((...).code == 0)) then
      local function _17_(...)
        if ((_G.type(...) == "table") and ((...).code == 0)) then
          return vim.notify(string.format("[pack] Cloned %s", spec.name))
        elseif ((_G.type(...) == "table") and (nil ~= (...).stderr)) then
          local stderr = (...).stderr
          return vim.notify(string.format("[pack] Could not clone %s: %s", spec.name, stderr), vim.log.levels.WARN)
        else
          return nil
        end
      end
      return _17_(vim.system(spec__3eclone_cmd(spec, pack_path)):wait())
    elseif ((_G.type(...) == "table") and (nil ~= (...).stderr)) then
      local stderr = (...).stderr
      return vim.notify(string.format("[pack] Could not clone %s: %s", spec.name, stderr), vim.log.levels.WARN)
    else
      return nil
    end
  end
  return _16_(vim.system({"mkdir", "-p", pack_path}):wait())
end
local function add(specs)
  if (nil == specs) then
    _G.error("Missing argument specs on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:35", 2)
  else
  end
  local pack_path = (vim.fn.stdpath("data") .. "/site/pack/juice/opt")
  for _, spec in ipairs(specs) do
    local case_21_ = reify_spec(spec)
    if ((_G.type(case_21_) == "table") and (case_21_[1] == "error") and (nil ~= case_21_[2])) then
      local reason = case_21_[2]
      vim.notify(string.format("[pack] Invalid spec: %s", reason), vim.log.levels.WARN)
    elseif ((_G.type(case_21_) == "table") and (case_21_[1] == "ok") and (nil ~= case_21_[2])) then
      local full_spec = case_21_[2]
      if not pack_cloned_3f(full_spec, pack_path) then
        clone_src(full_spec, pack_path)
      else
      end
    else
    end
  end
  return nil
end
local function load_now(packs)
  if (nil == packs) then
    _G.error("Missing argument packs on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:54", 2)
  else
  end
  if core["sequential?"](packs) then
    for _, pack in ipairs(packs) do
      vim.cmd.packadd(pack)
    end
    return nil
  elseif core["string?"](packs) then
    return vim.cmd.packadd(packs)
  else
    return nil
  end
end
local function load_on_event(packs, events, opts)
  if (nil == opts) then
    _G.error("Missing argument opts on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:65", 2)
  else
  end
  if (nil == events) then
    _G.error("Missing argument events on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:65", 2)
  else
  end
  if (nil == packs) then
    _G.error("Missing argument packs on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:65", 2)
  else
  end
  vim.api.nvim_create_augroup("pack", {clear = false})
  local user_callback = core.get(opts, "callback")
  local function _29_(user_callback0)
    local function _30_()
      load_now(packs)
      if core["function?"](user_callback0) then
        return user_callback0()
      elseif core["string?"](user_callback0) then
        return vim.cmd(user_callback0)
      else
        return nil
      end
    end
    return _30_
  end
  core.update(opts, "callback", _29_)
  core.assoc(opts, "group", "pack", "once", true)
  return vim.api.nvim_create_autocmd(events, opts)
end
local function load_on_keymap(packs, keys, callback, _3ftrigger_after)
  if (nil == callback) then
    _G.error("Missing argument callback on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:83", 2)
  else
  end
  if (nil == keys) then
    _G.error("Missing argument keys on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:83", 2)
  else
  end
  if (nil == packs) then
    _G.error("Missing argument packs on /home/rfmejia/.config/nvim/fnl/pack/init.fnl:83", 2)
  else
  end
  local mode = "n"
  local clear_triggers
  local function _35_()
    if core["sequential?"](keys) then
      for _, lhs in ipairs(keys) do
        vim.keymap.del(mode, lhs)
      end
      return nil
    elseif core["string?"](keys) then
      return vim.keymap.del(mode, keys)
    else
      return nil
    end
  end
  clear_triggers = _35_
  local start
  local function _37_(mode0, lhs, user_opts)
    load_now(packs)
    clear_triggers()
    if core["function?"](callback) then
      callback()
    else
    end
    return (_3ftrigger_after or (nil == _3ftrigger_after) or vim.api.nvim_input(lhs))
  end
  start = _37_
  local set_trigger
  local function _39_(mode0, lhs)
    local function _40_()
      return start(mode0, lhs)
    end
    return vim.keymap.set(mode0, lhs, _40_)
  end
  set_trigger = _39_
  if core["sequential?"](keys) then
    for _, key in ipairs(keys) do
      set_trigger("n", key)
    end
    return nil
  elseif core["string?"](keys) then
    return set_trigger("n", keys)
  else
    return nil
  end
end
return {add = add, ["load-now"] = load_now, ["load-on-event"] = load_on_event, ["load-on-keymap"] = load_on_keymap}
