-- Clone bootstrap plugins if not installed and add to `runtimepath`
local function ensure(options)
  local base_path = vim.fn.stdpath("data") .. "/lazy"

  if type(options.user) ~= "string" then
    error("required `user`")
  elseif type(options.repo) ~= "string" then
    error("required `repo`")
  elseif type(options.branch) ~= "string" then
    error("required `branch`")
  end

  local install_path = string.format("%s/%s", base_path, options.repo)
  vim.opt.rtp:prepend(install_path)
  if not vim.loop.fs_stat(install_path) then
    print(string.format("Cloning %s/%s:%s to %s...", options.user, options.repo, options.branch, install_path))
    vim.fn.system({
      "git",
      "clone",
      "--filter=blob:none",
      string.format("https://github.com/%s/%s.git", options.user, options.repo),
      string.format("--branch=%s", options.branch),
      install_path,
    })
  end
end

ensure({user = "Olical", repo = "nfnl", branch = "main"})
ensure({user = "folke", repo = "lazy.nvim", branch = "stable" })

require("nfnl").setup()
require("startup")
