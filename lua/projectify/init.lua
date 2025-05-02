-- [nfnl] fnl/projectify/init.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local hash_command = "md5sum"
local hash_file_path = (vim.env.XDG_STATE_HOME .. "/nvim/projectify.json")
--[[ {:FIXME ["Do not use `tset`, update table without mutating"] :TODO ["Find ergonomic way to initialize project" "Create init hash only if file does not exist" "Create function to read only chmod 600 init-hash and project files" "Move effectful functions to the edges"]} (init-hash-file) ]]
local function load_hashes(path)
  _G.assert((nil ~= path), "Missing argument path on /home/rfmejia/.config/nvim/fnl/projectify/init.fnl:14")
  return vim.json.decode(core.slurp(path), {})
end
local function save_hashes(path, obj)
  _G.assert((nil ~= obj), "Missing argument obj on /home/rfmejia/.config/nvim/fnl/projectify/init.fnl:17")
  _G.assert((nil ~= path), "Missing argument path on /home/rfmejia/.config/nvim/fnl/projectify/init.fnl:17")
  local now = os.time()
  obj["updated"] = now
  return core.spit(path, vim.json.encode(obj))
end
local function init_hash_file()
  local now = os.time()
  return save_hashes(hash_file_path, {created = os.time()})
end
local function compute_hash(input_string)
  _G.assert((nil ~= input_string), "Missing argument input-string on /home/rfmejia/.config/nvim/fnl/projectify/init.fnl:26")
  local result = vim.system({hash_command}, {text = true, stdin = {input_string}}):wait()
  if (result.code == 0) then
    return vim.fn.split(result.stdout, " ")[1]
  else
    vim.notify(("Could not compute hash" .. result.stderr), vim.log.levels.ERROR)
    return nil
  end
end
local function read_local_project_file()
  local path
  do
    local tmp_3_ = vim.fs.root(0, ".nvim")
    if (nil ~= tmp_3_) then
      path = (tmp_3_ .. "/.nvim/project.lua")
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
local function project_allowed_3f(project)
  if not (project and project.path and project.source) then
    return {error = "nil-project"}
  else
    local key_hash = compute_hash(project.path)
    local source_hash = compute_hash(project.source)
    local hash_lookup = load_hashes(hash_file_path)
    local valid_hash = hash_lookup[key_hash]
    if (nil == valid_hash) then
      return {error = "missing"}
    elseif (source_hash ~= valid_hash.source) then
      return {error = "mismatch"}
    elseif not valid_hash.allowed then
      return {error = "disallowed"}
    elseif "else" then
      return nil
    else
      return nil
    end
  end
end
local function allow_project(_8_, allowed)
  local path = _8_["path"]
  local source = _8_["source"]
  _G.assert((nil ~= allowed), "Missing argument allowed on /home/rfmejia/.config/nvim/fnl/projectify/init.fnl:55")
  _G.assert((nil ~= source), "Missing argument source on /home/rfmejia/.config/nvim/fnl/projectify/init.fnl:55")
  _G.assert((nil ~= path), "Missing argument path on /home/rfmejia/.config/nvim/fnl/projectify/init.fnl:55")
  local key_hash = compute_hash(path)
  local source_hash = compute_hash(source)
  local valid_hashes = load_hashes(hash_file_path)
  local entry = {source = source_hash, allowed = allowed}
  valid_hashes[key_hash] = entry
  save_hashes(hash_file_path, valid_hashes)
  return vim.cmd.source(path)
end
local function ask_allow_project(project, _3fprompt)
  _G.assert((nil ~= project), "Missing argument project on /home/rfmejia/.config/nvim/fnl/projectify/init.fnl:64")
  local prompt
  local _9_
  if _3fprompt then
    _9_ = (_3fprompt .. "; ")
  else
    _9_ = ""
  end
  prompt = (_9_ .. "Allow source? (y/N) ")
  local function _11_(_241)
    local answer = ((_241 == "y") or (_241 == "Y"))
    allow_project(project, answer)
    if answer then
      return vim.notify("Project allowed and loaded", vim.log.levels.INFO)
    else
      return vim.notify("Project disallowed", vim.log.levels.INFO)
    end
  end
  return vim.ui.input({prompt = prompt}, _11_)
end
local function load_project(project)
  local errors = project_allowed_3f(project)
  if (nil == errors) then
    vim.cmd.source(project.path)
    return vim.notify("Project file loaded", vim.log.levels.INFO)
  elseif (("nil-project" == errors.error) or ("disallowed" == errors.error)) then
    --[[ "do nothing" ]]
    return nil
  elseif ("mismatch" == errors.error) then
    return ask_allow_project(project, "Project file was updated")
  elseif "else" then
    return ask_allow_project(project, "New project file found")
  else
    return nil
  end
end
local function load_local_project()
  return load_project(read_local_project_file())
end
local function setup()
  vim.api.nvim_create_autocmd("VimEnter", {group = "wildignore-group", pattern = "*", callback = load_local_project})
  vim.api.nvim_create_autocmd("DirChanged", {group = "wildignore-group", pattern = "global", callback = load_local_project})
  vim.api.nvim_create_user_command("ProjectifyInitHash", init_hash_file, {desc = "[projectify] Initialize hash file"})
  vim.api.nvim_create_user_command("ProjectifyLoad", load_local_project, {desc = "[projectify] Load project file"})
  local function _14_()
    allow_project(read_local_project_file(), true)
    return vim.notify("Project allowed and loaded", vim.log.levels.INFO)
  end
  vim.api.nvim_create_user_command("ProjectifyAllow", _14_, {desc = "[projectify] Allow and load project file"})
  local function _15_()
    allow_project(read_local_project_file(), false)
    return vim.notify("Project disallowed", vim.log.levels.INFO)
  end
  return vim.api.nvim_create_user_command("ProjectifyDisallow", _15_, {desc = "[projectify] Disallow project file"})
end
--[[ "Tests" (assert (assert (= "missing" (. (hash-valid? {} "a" "1234") "error"))) (assert (= "mismatch" (. (hash-valid? {:a {:allowed true :source "1234"}} "a" "12345") "error"))) (assert (= "disallowed" (. (hash-valid? {:a {:allowed false :source "1234"}} "a" "1234") "error"))) (assert (= nil (hash-valid? {:a {:allowed true :source "1234"}} "a" "1234")))) ]]
return {setup = setup, ["load-local-project"] = load_local_project, ["ask-allow-project"] = ask_allow_project}
