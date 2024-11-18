-- [nfnl] Compiled from fnl/wildignore/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local string = autoload("nfnl.string")
local util = autoload("juice.util")
local function starts_with_3f(str, prefix)
  return (prefix == str:sub(1, #prefix))
end
local function update_wildignore()
  local gitignore = core.slurp(".gitignore")
  if gitignore then
    vim.opt.wildignore = ""
    local items = core.map(string.trim, string.split(gitignore, "\n"))
    local filtered
    local function _2_(_241)
      return not (string["blank?"](_241) or starts_with_3f(_241, "#") or starts_with_3f(_241, "!"))
    end
    filtered = core.filter(_2_, items)
    local prefixed
    local function _3_(_241)
      if starts_with_3f(_241, "/") then
        return ("**" .. _241)
      else
        return ("**/" .. _241)
      end
    end
    prefixed = core.map(_3_, filtered)
    local suffixed
    local function _5_(_241)
      if string["ends-with?"](_241, "/") then
        return (_241 .. "*")
      else
        return _241
      end
    end
    suffixed = core.map(_5_, prefixed)
    local function _7_(_241)
      return vim.opt.wildignore:append(_241)
    end
    return core.map(_7_, suffixed)
  else
    return nil
  end
end
local function setup()
  vim.api.nvim_create_augroup("wildignore-group", {clear = true})
  vim.api.nvim_create_autocmd("DirChanged", {group = "wildignore-group", pattern = "global", callback = update_wildignore})
  vim.api.nvim_create_autocmd("FileWritePost", {group = "wildignore-group", pattern = ".gitignore", callback = update_wildignore})
  return update_wildignore()
end
return {setup = setup}
