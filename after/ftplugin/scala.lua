-- [nfnl] Compiled from fnl/after/ftplugin/scala.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local notify = autoload("nfnl.notify")
local str = autoload("nfnl.string")
local util = autoload("juice.util")
util["assoc-in"](vim.opt_local, {shiftwidth = 2, tabstop = 2, expandtab = true, textwidth = 100, signcolumn = "yes:1"})
local function _2_()
  return vim.opt_local.indentkeys:remove("<>>")
end
vim.api.nvim_create_autocmd("FileType", {buffer = 0, callback = _2_})
local function run_scalafmt(path)
  local filename
  if str["blank?"](path) then
    filename = vim.fn.expand("%:p")
  else
    filename = path
  end
  local scalafmt_cmd = {"scalafmt", "--mode", "changed", "--config", ".scalafmt.conf", filename, filename}
  local _4_, _5_ = vim.fn.system(scalafmt_cmd)
  if (nil ~= _4_) then
    local ok = _4_
    return vim.cmd("e!")
  elseif ((_4_ == nil) and (nil ~= _5_)) then
    local err_msg = _5_
    return notify.error("[scala] Could not run `scalafmt`: ", err_msg)
  else
    return nil
  end
end
local function _7_()
  return run_scalafmt()
end
vim.api.nvim_buf_create_user_command(vim.api.nvim_get_current_buf(), "ScalafmtApply", _7_, {bang = true})
--[[ "Make sure we respect lsp if it's enabled" (vim.keymap.set "n" "<localleader>cf" (hashfn (run-scalafmt (vim.fn.expand "%:p"))) {:buffer true :desc "[scala] run scalafmt on buffer" :nowait true :silent true}) ]]
vim.keymap.set("n", "<localleader>s", "vip:sort<cr>", {desc = "[scala] sort in paragraph", nowait = true, buffer = true, silent = true})
if util["executable?"]("sbtn") then
  local function _8_()
    vim.cmd.split("term://sbtn")
    vim.api.nvim_win_set_height(0, 15)
    local function _9_()
      return vim.cmd.startinsert()
    end
    vim.api.nvim_create_autocmd({"BufWinEnter", "WinEnter"}, {buffer = vim.api.nvim_get_current_buf(), callback = _9_})
    return vim.cmd.startinsert()
  end
  vim.keymap.set("n", "<leader>os", _8_)
  vim.keymap.set("n", "<leader>oa", ":!tmux split-window -v -l 30\\% sbtn<cr><cr>", {desc = "[scala] open sbtn in a tmux split", buffer = true, silent = true})
else
end
if util["executable?"]("scala-cli") then
  return vim.keymap.set("n", "<leader>oc", ":!tmux split-window -v -l 30\\% scala-cli console %<cr><cr>", {desc = "[scala] open scala-cli in a tmux split", buffer = true, silent = true})
else
  return nil
end
