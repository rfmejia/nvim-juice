-- [nfnl] fnl/plugin/dbmode.fnl
vim.pack.add({"https://github.com/tpope/vim-dadbod", "https://github.com/kristijanhusak/vim-dadbod-completion"})
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local util = autoload("juice.util")
local dadbod_maps = {{"n", "<localleader>d;", ":DB g:db ", {desc = "[dadbod] run an sql statement in command mode", noremap = true, buffer = true}}, {"n", "<localleader>dd", ":.DB g:db<cr>", {desc = "[dadbod] run line as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>dp", "vip:DB g:db<cr>", {desc = "[dadbod] run paragraph as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>db", ":%DB g:db<cr>", {desc = "[dadbod] run buffer as sql statements", noremap = true, buffer = true}}}
local ft_autocmd_opts
local function _2_(filetypes, env_var, group_name)
  local function _3_()
    if env_var then
      util["set-keys"](dadbod_maps)
      pcall(vim.cmd.DB, ("g:db = " .. env_var))
      vim.opt_local.omnifunc = "vim_dadbod_completion#omni"
      return vim.print("[dadbod] Connected to database")
    else
      return nil
    end
  end
  return {pattern = filetypes, callback = _3_, group = "dbmode"}
end
ft_autocmd_opts = _2_
vim.api.nvim_create_augroup("dbmode", {clear = true})
vim.api.nvim_create_autocmd("FileType", ft_autocmd_opts({"sql", "mysql", "pgsql"}, vim.env.DADBOD_MYSQL_DB))
return vim.api.nvim_create_autocmd("FileType", ft_autocmd_opts("redis", vim.env.DADBOD_REDIS_DB))
