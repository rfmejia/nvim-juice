-- [nfnl] fnl/plugin/essential.fnl
vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter", "https://github.com/stevearc/oil.nvim"})
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local oil = autoload("oil")
local oil_opts = {default_file_explorer = true, delete_to_trash = true, skip_confirm_for_simple_edits = true, view_options = {show_hidden = true}}
oil.setup(oil_opts)
vim.keymap.set("n", "<leader>e", oil.open, {desc = "[oil] explore files in current file's path", silent = true})
local function _2_()
  vim.treesitter.start()
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  return nil
end
return vim.api.nvim_create_autocmd("FileType", {pattern = {"clojure", "fennel", "java", "lua", "markdown", "scala"}, callback = _2_})
