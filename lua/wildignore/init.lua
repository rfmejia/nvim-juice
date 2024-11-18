-- [nfnl] Compiled from fnl/wildignore/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local string = autoload("nfnl.string")
local function starts_with_3f(str, prefix)
  return (prefix == str:sub(1, #prefix))
end
local function is_dir_3f(path)
  _G.assert((nil ~= path), "Missing argument path on /home/rfmejia/.config/nvim/fnl/wildignore/init.fnl:8")
  return (nil ~= vim.fs.dir(path)())
end
local function update_wildignore()
  local gitignore = core.slurp(".gitignore")
  if gitignore then
    vim.opt.wildignore = ""
    local lines = core.map(string.trim, string.split(gitignore, "\n"))
    local entries
    local function _2_(_241)
      return not (string["blank?"](_241) or starts_with_3f(_241, "#") or starts_with_3f(_241, "!"))
    end
    entries = core.filter(_2_, lines)
    local suffixed
    local function _3_(_241)
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
    suffixed = core.map(_3_, entries)
    local prefixed
    local function _5_(_241)
      if starts_with_3f(_241, "/") then
        return ("**" .. _241)
      else
        return ("**/" .. _241)
      end
    end
    prefixed = core.map(_5_, suffixed)
    local function _7_(_241)
      return vim.opt.wildignore:append(_241)
    end
    return core.map(_7_, prefixed)
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
