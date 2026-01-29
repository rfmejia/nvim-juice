-- [nfnl] fnl/plugin/essential.fnl
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local pacman = autoload("pacman")
local packs = {{src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master"}, "https://github.com/stevearc/oil.nvim"}
local util = autoload("juice.util")
local treesitter_opts = {highlight = {enable = true}, indent = {enable = true}}
local oil_opts = {default_file_explorer = true, delete_to_trash = true, skip_confirm_for_simple_edits = true, view_options = {show_hidden = true}}
--[[ "NOTE For nvim-treesitter, the `main` branch is an in-progress
           backward-incompatible rewrite, set branch to `master` until rewrite
           is complete" ]]
pacman.add(packs)
pacman["load-now"]({"nvim-treesitter", "oil.nvim"})
util.call("nvim-treesitter.configs", "setup", treesitter_opts)
util.call("oil", "setup", oil_opts)
local function _2_()
  return util.call("oil", "open")
end
return vim.keymap.set("n", "<leader>e", _2_, {desc = "[oil] explore files in current file's path", silent = true})
