-- [nfnl] fnl/plugin/essential.fnl
vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter", "https://github.com/stevearc/oil.nvim"})
local _let_1_ = require("nfnl.module")
local autoload = _let_1_.autoload
local util = autoload("juice.util")
local builtin = {"nvim.undotree", "nvim.tohtml", "nvim.difftool"}
local oil_opts = {default_file_explorer = true, delete_to_trash = true, skip_confirm_for_simple_edits = true, view_options = {show_hidden = true}}
for _, plugin in ipairs(builtin) do
  vim.cmd.packadd(plugin)
end
util.call("oil", "setup", oil_opts)
local function _2_()
  return util.call("oil", "open")
end
vim.keymap.set("n", "<leader>e", _2_, {desc = "[oil] explore files in current file's path", silent = true})
local function _3_()
  vim.treesitter.start()
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  return nil
end
return vim.api.nvim_create_autocmd("FileType", {pattern = {"clojure", "fennel", "java", "lua", "markdown", "scala"}, callback = _3_})
