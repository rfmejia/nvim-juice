-- [nfnl] fnl/after/ftplugin/scala.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local notify = autoload("nfnl.notify")
local scalametals = autoload("juice.lsp.scalametals")
local str = autoload("nfnl.string")
local core = autoload("nfnl.core")
local util = autoload("juice.util")
core["merge!"](vim.opt_local, {shiftwidth = 2, tabstop = 2, expandtab = true, textwidth = 100, signcolumn = "yes:1"})
vim.opt_local.indentkeys:remove("<>>")
vim.keymap.set("n", "<localleader>s", "vip:sort<cr>", {desc = "[scala] sort in paragraph", nowait = true, buffer = true, silent = true})
if util["executable?"]("sbtn") then
  local function _2_()
    vim.cmd.split("term://sbtn")
    vim.api.nvim_win_set_height(0, 15)
    local function _3_()
      return vim.cmd.startinsert()
    end
    vim.api.nvim_create_autocmd({"BufWinEnter", "WinEnter"}, {buffer = vim.api.nvim_get_current_buf(), callback = _3_})
    return vim.cmd.startinsert()
  end
  vim.keymap.set("n", "<leader>os", _2_)
  vim.keymap.set("n", "<leader>oa", ":!tmux split-window -v -l 30\\% sbtn<cr><cr>", {desc = "[scala] open sbtn in a tmux split", buffer = true, silent = true})
else
end
if util["executable?"]("scala-cli") then
  vim.keymap.set("n", "<leader>oc", ":!tmux split-window -v -l 30\\% scala-cli console %<cr><cr>", {desc = "[scala] open scala-cli in a tmux split", buffer = true, silent = true})
else
end
scalametals["initialize-metals"]()
local function metals_lsp_started_3f()
  local has_metals_3f = false
  for _, client in ipairs(vim.lsp.get_clients()) do
    local or_6_ = has_metals_3f
    if not or_6_ then
      local _8_
      do
        local t_7_ = client
        if (nil ~= t_7_) then
          t_7_ = t_7_.name
        else
        end
        _8_ = t_7_
      end
      or_6_ = ("metals" == _8_)
    end
    has_metals_3f = or_6_
  end
  return has_metals_3f
end
local function run_scalafmt(path)
  local filename
  if str["blank?"](path) then
    filename = vim.fn.expand("%:p")
  else
    filename = path
  end
  local scalafmt_cmd = {"scalafmt", "--mode", "changed", "--config", ".scalafmt.conf", filename, filename}
  local _11_, _12_ = vim.fn.system(scalafmt_cmd)
  if (nil ~= _11_) then
    local ok = _11_
    return vim.cmd("e!")
  elseif ((_11_ == nil) and (nil ~= _12_)) then
    local err_msg = _12_
    return notify.error("[scala] Could not run `scalafmt`: ", err_msg)
  else
    return nil
  end
end
local function _14_()
  return run_scalafmt()
end
vim.api.nvim_buf_create_user_command(vim.api.nvim_get_current_buf(), "ScalafmtApply", _14_, {bang = true})
if metals_lsp_started_3f() then
  return vim.keymap.set("n", "<localleader>m", ":Metals<C-d>", {desc = "[metals] show all commands", buffer = true})
else
  local function _15_()
    return run_scalafmt(vim.fn.expand("%:p"))
  end
  local function _16_()
    util.call("metals", "start_server")
    core.println("Starting Metals server")
    return vim.keymap.set("n", "<localleader>m", ":Metals<C-d>", {desc = "[metals] show all commands", buffer = true})
  end
  return util["set-keys"]({{"n", "grf", _15_, {desc = "[scala] run scalafmt on buffer", buffer = true, nowait = true, silent = true}}, {"n", "<localleader>m", _16_, {desc = "[metals] show all commands", buffer = true, silent = false}}})
end
