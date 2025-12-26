-- [nfnl] fnl/juice/packs/core.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local pack = autoload("pack")
local util = autoload("juice.util")
--[[ "NOTE For nvim-treesitter, the `main` branch is an in-progress
           backward-incompatible rewrite, set branch to `master` until rewrite
           is complete" ]]
local function _2_()
  pack.add({{src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "master"}, {src = "https://github.com/stevearc/oil.nvim"}})
  pack["load-now"]({"nvim-treesitter", "oil.nvim"})
  util.call("nvim-treesitter.configs", "setup", {highlight = {enable = true}, indent = {enable = true}})
  util.call("oil", "setup", {default_file_explorer = true, delete_to_trash = true, skip_confirm_for_simple_edits = true, view_options = {show_hidden = true}})
  local function _3_()
    return util.call("oil", "open")
  end
  return vim.keymap.set("n", "<leader>e", _3_, {desc = "[oil] explore files in current file's path", silent = true})
end
return {setup = _2_}
