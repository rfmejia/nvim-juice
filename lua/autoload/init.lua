-- [nfnl] Compiled from fnl/autoload/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local hash_command = "md5sum"
local hash_file_path = (vim.env.XDG_STATE_HOME .. "/nvim/autoload.json")
local function load_hashes(path)
  _G.assert((nil ~= path), "Missing argument path on /home/rfmejia/.config/nvim/fnl/autoload/init.fnl:7")
  return vim.json.decode(core.slurp(path), {})
end
local function save_hashes(path, obj)
  _G.assert((nil ~= obj), "Missing argument obj on /home/rfmejia/.config/nvim/fnl/autoload/init.fnl:10")
  _G.assert((nil ~= path), "Missing argument path on /home/rfmejia/.config/nvim/fnl/autoload/init.fnl:10")
  local now = os.time()
  obj["updated"] = now
  return core.spit(path, vim.json.encode(obj))
end
local function init_hash_file()
  --[[ "TODO Create only if file does not exist" ]]
  local now = os.time()
  return save_hashes(hash_file_path, {created = os.time()})
end
local function compute_hash(input_string)
  _G.assert((nil ~= input_string), "Missing argument input-string on /home/rfmejia/.config/nvim/fnl/autoload/init.fnl:20")
  local result = vim.system({hash_command}, {text = true, stdin = {input_string}}):wait()
  if (result.code == 0) then
    return vim.fn.split(result.stdout, " ")[1]
  else
    vim.notify(("Could not compute hash" .. result.stderr), vim.log.levels.ERROR)
    return nil
  end
end
local function hash_valid_3f(lookup_table, key_hash, source_hash)
  _G.assert((nil ~= source_hash), "Missing argument source-hash on /home/rfmejia/.config/nvim/fnl/autoload/init.fnl:30")
  _G.assert((nil ~= key_hash), "Missing argument key-hash on /home/rfmejia/.config/nvim/fnl/autoload/init.fnl:30")
  _G.assert((nil ~= lookup_table), "Missing argument lookup-table on /home/rfmejia/.config/nvim/fnl/autoload/init.fnl:30")
  local hash_info = lookup_table[key_hash]
  if (nil == hash_info) then
    return {error = "missing"}
  elseif (source_hash ~= hash_info.source) then
    return {error = "mismatch"}
  elseif not hash_info.allowed then
    return {error = "disallowed"}
  elseif "else" then
    return nil
  else
    return nil
  end
end
assert(assert(("missing" == hash_valid_3f({}, "a", "1234").error)), assert(("mismatch" == hash_valid_3f({a = {source = "1234", allowed = true}}, "a", "12345").error)), assert(("disallowed" == hash_valid_3f({a = {source = "1234", allowed = false}}, "a", "1234").error)), assert((nil == hash_valid_3f({a = {source = "1234", allowed = true}}, "a", "1234"))))
local function get_lua_project()
  local path
  do
    local tmp_3_auto = vim.fs.root(0, ".nvim")
    if (nil ~= tmp_3_auto) then
      path = (tmp_3_auto .. "/.nvim/project.lua")
    else
      path = nil
    end
  end
  local source
  if (nil ~= path) then
    source = core.slurp(path)
  else
    source = nil
  end
  if (source and (#source > 0)) then
    return {path = path, source = source}
  else
    return nil
  end
end
local function allow_project_source(path, source, allowed)
  _G.assert((nil ~= allowed), "Missing argument allowed on /home/rfmejia/.config/nvim/fnl/autoload/init.fnl:56")
  _G.assert((nil ~= source), "Missing argument source on /home/rfmejia/.config/nvim/fnl/autoload/init.fnl:56")
  _G.assert((nil ~= path), "Missing argument path on /home/rfmejia/.config/nvim/fnl/autoload/init.fnl:56")
  local key_hash = compute_hash(path)
  local source_hash = compute_hash(source)
  local valid_hashes = load_hashes(hash_file_path)
  local entry = {source = source_hash, allowed = allowed}
  valid_hashes[key_hash] = entry
  return save_hashes(hash_file_path, valid_hashes)
end
local function allow_project(allowed)
  _G.assert((nil ~= allowed), "Missing argument allowed on /home/rfmejia/.config/nvim/fnl/autoload/init.fnl:64")
  local project = get_lua_project()
  if project then
    return allow_project_source(project.path, project.source, allowed)
  else
    return nil
  end
end
local function ask_allow_project(prompt)
  _G.assert((nil ~= prompt), "Missing argument prompt on /home/rfmejia/.config/nvim/fnl/autoload/init.fnl:69")
  local function _8_(_241)
    local answer = ((_241 == "y") or (_241 == "Y"))
    allow_project(answer)
    if answer then
      return vim.notify("Project allowed", vim.log.levels.INFO)
    else
      return vim.notify("Project disallowed", vim.log.levels.INFO)
    end
  end
  return vim.ui.input({prompt = (prompt .. "; Allow source? (y/N) ")}, _8_)
end
--[[ "FIXME Do not use `tset`, update table without mutating" (init-hash-file) ]]
local function load_project()
  local project = get_lua_project()
  if project then
    local key_hash = compute_hash(project.path)
    local source_hash = compute_hash(project.source)
    local valid_hashes = load_hashes(hash_file_path)
    local errors = hash_valid_3f(valid_hashes, key_hash, source_hash)
    if (nil == errors) then
      vim.cmd.source(project.path)
      return vim.notify("Project file loaded", vim.log.levels.INFO)
    elseif ("disallowed" == errors.error) then
      --[[ "do nothing" ]]
      return nil
    elseif ("mismatch" == errors.error) then
      return ask_allow_project("Project file was changed")
    elseif "else" then
      return ask_allow_project("New project file found")
    else
      return nil
    end
  else
    return nil
  end
end
local function setup()
  vim.api.nvim_create_autocmd("VimEnter", {group = "wildignore-group", pattern = "*", callback = load_project})
  return vim.api.nvim_create_autocmd("DirChanged", {group = "wildignore-group", pattern = "global", callback = load_project})
end
return {setup = setup, ["load-project"] = load_project, ["ask-allow-project"] = ask_allow_project}
