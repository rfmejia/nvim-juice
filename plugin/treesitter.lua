-- [nfnl] fnl/plugin/treesitter.fnl
vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter"})
local function _1_()
  vim.treesitter.start()
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  return nil
end
return vim.api.nvim_create_autocmd("FileType", {pattern = {"clojure", "fennel", "java", "lua", "markdown", "scala"}, callback = _1_})
