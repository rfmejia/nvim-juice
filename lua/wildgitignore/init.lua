-- [nfnl] fnl/wildgitignore/init.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local string = autoload("nfnl.string")
local function starts_with_3f(str, prefix)
  return (prefix == str:sub(1, #prefix))
end
local function is_dir_3f(path)
  _G.assert((nil ~= path), "Missing argument path on /home/rfmejia/.config/nvim/fnl/wildgitignore/init.fnl:8")
  return (nil ~= vim.fs.dir(path)())
end
local function update_wildignore()
  local _2_ = core.slurp(".gitignore")
  if (nil ~= _2_) then
    local gitignore = _2_
    local lines = core.map(string.trim, string.split(gitignore, "\n"))
    local entries
    local function _3_(_241)
      return not (string["blank?"](_241) or starts_with_3f(_241, "#") or starts_with_3f(_241, "!"))
    end
    entries = core.filter(_3_, lines)
    local suffixed
    local function _4_(_241)
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
    suffixed = core.map(_4_, entries)
    local prefixed
    local function _6_(_241)
      if starts_with_3f(_241, "/") then
        return ("**" .. _241)
      else
        return ("**/" .. _241)
      end
    end
    prefixed = core.map(_6_, suffixed)
    vim.opt.wildignore = ""
    local function _8_(_241)
      return vim.opt.wildignore:append(_241)
    end
    return core.map(_8_, prefixed)
  else
    return nil
  end
end
local function setup()
  vim.api.nvim_create_augroup("wildignore-group", {clear = true})
  vim.api.nvim_create_autocmd("VimEnter", {group = "wildignore-group", pattern = "*", callback = update_wildignore})
  vim.api.nvim_create_autocmd("DirChanged", {group = "wildignore-group", pattern = "global", callback = update_wildignore})
  return vim.api.nvim_create_autocmd("FileWritePost", {group = "wildignore-group", pattern = ".gitignore", callback = update_wildignore})
end
return {setup = setup}
