-- [nfnl] Compiled from fnl/juice/bootstrap.fnl by https://github.com/Olical/nfnl, do not edit.
local function setup()
  local lazypath = (vim.fn.stdpath("data") .. "/lazy/lazy.nvim")
  local lazy_exists_3f = (vim.uv or vim.loop).fs_stat(lazypath)
  if not lazy_exists_3f then
    vim.fn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath})
  else
  end
  return (vim.opt.rtp):prepend(lazypath)
end
return {setup = setup}
