-- [nfnl] fnl/plugin/wildgitignore.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local string = autoload("nfnl.string")
local function starts_with_3f(str, prefix)
  return (prefix == str:sub(1, #prefix))
end
local function is_dir_3f(path)
  if (nil == path) then
    _G.error("Missing argument path on fnl/plugin/wildgitignore.fnl:8", 2)
  else
  end
  return (nil ~= vim.fs.dir(path)())
end
local function find_gitignore(_3fnth_parent)
  local nth_parent = (_3fnth_parent or 2)
  local function search(dir, remaining)
    local candidate = (dir .. "/.gitignore")
    if (remaining <= 0) then
      return nil
    elseif (1 == vim.fn.filereadable(candidate)) then
      return candidate
    elseif "else" then
      return search(vim.fn.fnamemodify(dir, ":h"), (remaining - 1))
    else
      return nil
    end
  end
  return search(vim.fn.getcwd(), nth_parent)
end
local function update_wildignore()
  local case_4_ = core.slurp(find_gitignore())
  if (nil ~= case_4_) then
    local gitignore = case_4_
    local lines = core.map(string.trim, string.split(gitignore, "\n"))
    local entries
    local function _5_(_241)
      return not (string["blank?"](_241) or starts_with_3f(_241, "#") or starts_with_3f(_241, "!"))
    end
    entries = core.filter(_5_, lines)
    local suffixed
    local function _6_(_241)
      if string["ends-with?"](_241, "/") then
        return (_241 .. "*")
      elseif is_dir_3f(_241) then
        return (_241 .. "/*")
      elseif "else" then
        return _241
      else
        return nil
      end
    end
    suffixed = core.map(_6_, entries)
    local prefixed
    local function _8_(_241)
      if starts_with_3f(_241, "/") then
        return ("**" .. _241)
      else
        return ("**/" .. _241)
      end
    end
    prefixed = core.map(_8_, suffixed)
    vim.opt.wildignore = ""
    local function _10_(_241)
      return vim.opt.wildignore:append(_241)
    end
    return core.map(_10_, prefixed)
  else
    return nil
  end
end
vim.api.nvim_create_augroup("wildignore-group", {clear = true})
vim.api.nvim_create_autocmd("VimEnter", {group = "wildignore-group", pattern = "*", callback = update_wildignore})
vim.api.nvim_create_autocmd("DirChanged", {group = "wildignore-group", pattern = "global", callback = update_wildignore})
return vim.api.nvim_create_autocmd("FileWritePost", {group = "wildignore-group", pattern = ".gitignore", callback = update_wildignore})
