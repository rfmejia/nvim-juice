-- [nfnl] Compiled from fnl/juice/bootstrap.fnl by https://github.com/Olical/nfnl, do not edit.
local base_path = (vim.fn.stdpath("data") .. "/lazy")
local function ensure_installed(options)
  local install_path = string.format("%s/%s", base_path, options.repo)
  local assert_string
  local function _1_(value, err_msg)
    if not (type(value) == "string") then
      return error(err_msg)
    else
      return nil
    end
  end
  assert_string = _1_
  local path_exists_3f = (vim.uv or vim.loop).fs_stat(install_path)
  assert_string(options.user)
  assert_string(options.repo)
  assert_string(options.branch)
  if not path_exists_3f then
    print(string.format("Cloning %s/%s:%s to %s...", options.user, options.repo, options.branch, install_path))
    vim.fn.system({"git", "clone", "--filter=blob:none", string.format("https://github.com/%s/%s.git", options.user, options.repo), string.format("--branch=%s", options.branch), install_path})
  else
  end
  return (vim.opt.rtp):prepend(install_path)
end
local function setup()
  ensure_installed({user = "Olical", repo = "nfnl", branch = "main"})
  return ensure_installed({user = "folke", repo = "lazy.nvim", branch = "stable"})
end
return {setup = setup}
