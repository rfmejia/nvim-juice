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

-- local function setupTreeSitter()
--   require("nvim-treesitter.configs").setup({
--     ensure_installed = {
--       "bash",
--       "c",
--       "help",
--       "javascript",
--       "json",
--       "html",
--       "lua",
--       "markdown",
--       "rust",
--       "scala",
--       "svelte",
--       "typescript",
--       "vim",
--       "yaml"
--     },
--     highlight = {
--       enable = true,
--     }
--   })
-- end

local function setup()
  vim.go.laststatus = 2 -- Always have a statusline
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

  -- setupTreeSitter()

  -- Setup LSP
  require("juice.lsp").setup()
end

return {
  getStatusline = getStatusLine,
  setup = setup,
}
