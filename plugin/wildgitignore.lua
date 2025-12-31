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
    _G.error("Missing argument path on /home/rfmejia/.config/nvim/fnl/plugin/wildgitignore.fnl:8", 2)
  else
  end
  return (nil ~= vim.fs.dir(path)())
end
local function update_wildignore()
  local case_3_ = core.slurp(".gitignore")
  if (nil ~= case_3_) then
    local gitignore = case_3_
    local lines = core.map(string.trim, string.split(gitignore, "\n"))
    local entries
    local function _4_(_241)
      return not (string["blank?"](_241) or starts_with_3f(_241, "#") or starts_with_3f(_241, "!"))
    end
    entries = core.filter(_4_, lines)
    local suffixed
    local function _5_(_241)
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
    suffixed = core.map(_5_, entries)
    local prefixed
    local function _7_(_241)
      if starts_with_3f(_241, "/") then
        return ("**" .. _241)
      else
        return ("**/" .. _241)
      end
    end
    prefixed = core.map(_7_, suffixed)
    vim.opt.wildignore = ""
    local function _9_(_241)
      return vim.opt.wildignore:append(_241)
    end
    return core.map(_9_, prefixed)
  else
    return nil
  end
end
vim.api.nvim_create_augroup("wildignore-group", {clear = true})
vim.api.nvim_create_autocmd("VimEnter", {group = "wildignore-group", pattern = "*", callback = update_wildignore})
vim.api.nvim_create_autocmd("DirChanged", {group = "wildignore-group", pattern = "global", callback = update_wildignore})
return vim.api.nvim_create_autocmd("FileWritePost", {group = "wildignore-group", pattern = ".gitignore", callback = update_wildignore})
