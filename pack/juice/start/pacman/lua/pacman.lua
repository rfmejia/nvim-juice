-- [nfnl] fnl/pack/juice/start/pacman/fnl/pacman.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local fs = autoload("nfnl.fs")
local str = autoload("nfnl.string")
local util = autoload("juice.util")
local function sanitize_url(url)
  if (nil == url) then
    _G.error("Missing argument url on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:7", 2)
  else
  end
  local trimmed = str.trim(url)
  if str["ends-with?"](trimmed, "/") then
    return string.sub(trimmed, 1, core.dec(string.len(url)))
  else
    return trimmed
  end
end
local function reify_spec(user_spec)
  if (nil == user_spec) then
    _G.error("Missing argument user-spec on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:13", 2)
  else
  end
  if (core["table?"](user_spec) and str["blank?"](user_spec.src)) then
    return {"error", "Missing `src`"}
  elseif not (core["table?"](user_spec) or core["string?"](user_spec)) then
    return {"error", "Spec is not a table or string"}
  elseif "else" then
    local spec
    if core["string?"](user_spec) then
      spec = {src = sanitize_url(user_spec)}
    else
      spec = core.update(user_spec, "src", sanitize_url)
    end
    local name
    local _7_
    do
      local t_6_ = spec
      if (nil ~= t_6_) then
        t_6_ = t_6_.name
      else
      end
      _7_ = t_6_
    end
    name = (_7_ or core.last(str.split(spec.src, "/")))
    local full_spec = core.assoc(spec, "name", name)
    return {"ok", full_spec}
  else
    return nil
  end
end
local function pack_cloned_3f(_10_, pack_path)
  local name = _10_.name
  if (nil == pack_path) then
    _G.error("Missing argument pack-path on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:26", 2)
  else
  end
  if (nil == name) then
    _G.error("Missing argument name on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:26", 2)
  else
  end
  return fs["exists?"]((pack_path .. "/" .. name))
end
local function spec__3eclone_cmd(_13_, pack_path)
  local src = _13_.src
  local _3fversion = _13_.version
  if (nil == pack_path) then
    _G.error("Missing argument pack-path on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:30", 2)
  else
  end
  if (nil == src) then
    _G.error("Missing argument src on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:30", 2)
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
    _G.error("Missing argument pack-path on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:36", 2)
  else
  end
  if (nil == spec) then
    _G.error("Missing argument spec on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:36", 2)
  else
  end
  vim.notify(string.format("[pack] Cloning %s to %s...", spec.name, pack_path))
  local function _19_(...)
    if ((_G.type(...) == "table") and ((...).code == 0)) then
      local function _20_(...)
        if ((_G.type(...) == "table") and ((...).code == 0)) then
          return vim.notify(string.format("[pack] Cloned %s", spec.name))
        elseif ((_G.type(...) == "table") and (nil ~= (...).stderr)) then
          local stderr = (...).stderr
          return vim.notify(string.format("[pack] Could not clone %s: %s", spec.name, stderr), vim.log.levels.WARN)
        else
          return nil
        end
      end
      return _20_(vim.system(spec__3eclone_cmd(spec, pack_path)):wait())
    elseif ((_G.type(...) == "table") and (nil ~= (...).stderr)) then
      local stderr = (...).stderr
      return vim.notify(string.format("[pack] Could not clone %s: %s", spec.name, stderr), vim.log.levels.WARN)
    else
      return nil
    end
  end
  return _19_(vim.system({"mkdir", "-p", pack_path}):wait())
end
local function add_spec(spec, pack_path)
  if (nil == pack_path) then
    _G.error("Missing argument pack-path on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:47", 2)
  else
  end
  if (nil == spec) then
    _G.error("Missing argument spec on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:47", 2)
  else
  end
  local case_25_ = reify_spec(spec)
  if ((_G.type(case_25_) == "table") and (case_25_[1] == "error") and (nil ~= case_25_[2])) then
    local reason = case_25_[2]
    return vim.notify(string.format("[pack] Invalid spec: %s", reason), vim.log.levels.WARN)
  elseif ((_G.type(case_25_) == "table") and (case_25_[1] == "ok") and (nil ~= case_25_[2])) then
    local full_spec = case_25_[2]
    if not pack_cloned_3f(full_spec, pack_path) then
      return clone_src(full_spec, pack_path)
    else
      return nil
    end
  else
    return nil
  end
end
local function add(specs)
  if (nil == specs) then
    _G.error("Missing argument specs on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:54", 2)
  else
  end
  local pack_path = (vim.fn.stdpath("data") .. "/site/pack/juice/opt")
  if core["sequential?"](specs) then
    for _, spec in ipairs(specs) do
      add_spec(spec, pack_path)
    end
    return nil
  elseif core["string?"](specs) then
    return add_spec(specs, pack_path)
  elseif "else" then
    return vim.notify("[pack] Invalid spec: must be a list or string", vim.log.levels.WARN)
  else
    return nil
  end
end
local function load_now(packs)
  if (nil == packs) then
    _G.error("Missing argument packs on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:75", 2)
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
    _G.error("Missing argument opts on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:86", 2)
  else
  end
  if (nil == events) then
    _G.error("Missing argument events on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:86", 2)
  else
  end
  if (nil == packs) then
    _G.error("Missing argument packs on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:86", 2)
  else
  end
  vim.api.nvim_create_augroup("pack", {clear = false})
  local user_callback = core.get(opts, "callback")
  local function _35_(user_callback0)
    local function _36_()
      load_now(packs)
      if core["function?"](user_callback0) then
        return user_callback0()
      elseif core["string?"](user_callback0) then
        return vim.cmd(user_callback0)
      else
        return nil
      end
    end
    return _36_
  end
  core.update(opts, "callback", _35_)
  core.assoc(opts, "group", "pack", "once", true)
  return vim.api.nvim_create_autocmd(events, opts)
end
local function load_on_keymap(packs, keys, callback, _3ftrigger_after)
  if (nil == callback) then
    _G.error("Missing argument callback on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:104", 2)
  else
  end
  if (nil == keys) then
    _G.error("Missing argument keys on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:104", 2)
  else
  end
  if (nil == packs) then
    _G.error("Missing argument packs on /home/rfmejia/.config/nvim/fnl/pack/juice/start/pacman/fnl/pacman.fnl:104", 2)
  else
  end
  local mode = "n"
  local clear_triggers
  local function _41_()
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
  clear_triggers = _41_
  local start
  local function _43_(mode0, lhs, user_opts)
    load_now(packs)
    clear_triggers()
    if core["function?"](callback) then
      callback()
    else
    end
    if (_3ftrigger_after or (nil == _3ftrigger_after)) then
      return vim.api.nvim_input(lhs)
    else
      return nil
    end
  end
  start = _43_
  local set_trigger
  local function _46_(mode0, lhs)
    local function _47_()
      return start(mode0, lhs)
    end
    return vim.keymap.set(mode0, lhs, _47_)
  end
  set_trigger = _46_
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
