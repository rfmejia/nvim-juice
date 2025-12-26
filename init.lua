-- [nfnl] fnl/init.fnl
--[[ "Check and load `nfnl` pack; Clone repository if not" ]]
do
  local nfnl_url = "https://github.com/rfmejia/nfnl"
  local pack_path = (vim.fn.stdpath("data") .. "/site/pack/juice/start")
  local dir_exists_3f
  local function _1_(path)
    return (vim.uv or vim.loop).fs_stat(path)
  end
  dir_exists_3f = _1_
  if not dir_exists_3f((pack_path .. "/nfnl")) then
    vim.notify(string.format("[bootstrap] Cloning %s to %s...", nfnl_url, pack_path))
    local function _2_(...)
      if ((_G.type(...) == "table") and ((...).code == 0)) then
        local function _3_(...)
          if ((_G.type(...) == "table") and ((...).code == 0)) then
            return vim.notify("[bootstrap] OK")
          elseif ((_G.type(...) == "table") and (nil ~= (...).stderr)) then
            local stderr = (...).stderr
            return vim.notify(("[bootstrap] Could not clone `nfnl`: " .. stderr), vim.log.levels.ERROR)
          else
            return nil
          end
        end
        return _3_(vim.system({"git", "-C", pack_path, "clone", nfnl_url}):wait())
      elseif ((_G.type(...) == "table") and (nil ~= (...).stderr)) then
        local stderr = (...).stderr
        return vim.notify(("[bootstrap] Could not clone `nfnl`: " .. stderr), vim.log.levels.ERROR)
      else
        return nil
      end
    end
    _2_(vim.system({"mkdir", "-p", pack_path}):wait())
    vim.cmd("packloadall!")
  else
  end
end
local util = autoload("juice.util")
return util["call-setup"]("juice.options", "juice.colorscheme", "juice.plugins", "juice.mappings", "juice.commands", "juice.lsp", "juice.dotenvrc", "journal-tools", "git-info", "tmux-nav", "trim-whitespace", "wildgitignore")
