-- [nfnl] fnl/plugin/essential.fnl
vim.pack.add({"https://github.com/stevearc/oil.nvim", "https://github.com/rmagatti/auto-session"})
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local autosession = autoload("auto-session")
local str = autoload("nfnl.string")
local oil = autoload("oil")
local autosession_opts = {suppressed_dirs = {"/", "~/", "/tmp"}, git_use_branch_name = true, git_auto_restore_on_branch_change = true}
local autosession_sessionoptions = {"blank", "buffers", "curdir", "folds", "help", "tabpages", "winsize", "winpos", "terminal", "localoptions"}
local oil_opts = {default_file_explorer = true, delete_to_trash = true, skip_confirm_for_simple_edits = true, view_options = {show_hidden = true}}
oil.setup(oil_opts)
vim.keymap.set("n", "<leader>e", oil.open, {desc = "[oil] explore files in current file's path", silent = true})
autosession.setup(autosession_opts)
vim.o.sessionoptions = str.join(",", autosession_sessionoptions)
return nil
