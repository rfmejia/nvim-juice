-- [nfnl] Compiled from fnl/juice/bootstrap.fnl by https://github.com/Olical/nfnl, do not edit.
local function ensure_installed(user, repo, branch)
  _G.assert((nil ~= branch), "Missing argument branch on /home/rfmejia/.config/nvim/fnl/juice/bootstrap.fnl:1")
  _G.assert((nil ~= repo), "Missing argument repo on /home/rfmejia/.config/nvim/fnl/juice/bootstrap.fnl:1")
  _G.assert((nil ~= user), "Missing argument user on /home/rfmejia/.config/nvim/fnl/juice/bootstrap.fnl:1")
  local base_path = (vim.fn.stdpath("data") .. "/lazy")
  local install_path = string.format("%s/%s", base_path, repo)
  local path_exists_3f = (vim.uv or vim.loop).fs_stat(install_path)
  if not path_exists_3f then
    local message = string.format("Cloning %s/%s:%s to %s...", user, repo, branch, install_path)
    local git_cmd = {"git", "clone", "--filter=blob:none", string.format("https://github.com/%s/%s.git", user, repo), string.format("--branch=%s", branch), install_path}
    print(message)
    vim.fn.system(git_cmd)
  else
  end
  return (vim.opt.rtp):prepend(install_path)
end
local function setup()
  ensure_installed("Olical", "nfnl", "main")
  return ensure_installed("folke", "lazy.nvim", "stable")
end
return {setup = setup}
