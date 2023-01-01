local function getStatusLine()
  return table.concat({
    "%f", -- filename
    "%#Todo#%m%{GitFileStatus()}%#StatusLine#", -- buffer modified flag
    "%q%h%r ", -- buffer type flags
    "%=", -- divider
    require("juice.lsp").countDiagnostics(), -- error and warning counts
    "%l,%c", -- ruler
  })
end

local function setup()
  vim.go.laststatus = 2 -- Always have a statusline
  vim.o.signcolumn = 'yes:1' -- Display line column
  vim.o.statusline = [[%!luaeval('require("juice").getStatusline()')]]

  -- Reset viminfofile
  -- vim.cmd [[let &viminfofile=""]]
  -- set

  -- Highlight yanked text
  vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
      vim.highlight.on_yank({
        timeout = 200,
        on_visual = false
      })
    end,
  })

  -- Setup treesitter
  require("juice.treesitter").setup()

  -- Setup LSP
  require("juice.lsp").setup()
end

return {
  getStatusline = getStatusLine,
  setup = setup,
}
