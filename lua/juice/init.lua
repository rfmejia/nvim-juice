local autocmd = vim.api.nvim_create_autocmd
local lua = function(str) return string.format("<cmd>lua %s<cr>", str) end
local map = vim.api.nvim_set_keymap
local set = vim.opt
local setg = vim.opt_global
local setb = vim.api.nvim_buf_set_option

local NS = { noremap = true, silent = true }
local NSW = { noremap = true, silent = true, nowait = true }

local function setupBufferOpts(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  setb(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  map("n", "gd", lua("vim.lsp.buf.definition()"), NSW)
  map("n", "gt", lua("vim.lsp.buf.type_definition()"), NSW)
  map("n", "gi", lua("vim.lsp.buf.implementation()"), NS)
  map("n", "gr", lua("vim.lsp.buf.references()"), NS)
  map("n", "gs", lua("vim.lsp.buf.document_symbol()"), NS)
  map("n", "gS", lua("vim.lsp.buf.workspace_symbol()"), NS)
  map("n", "K", lua("vim.lsp.buf.hover()"), NS)
  map("n", "<localleader>ca", lua("vim.lsp.buf.code_action()"), NS)
  map("n", "<localleader>cr", lua("vim.lsp.buf.rename()"), NS)
  map("n", "<localleader>cf", lua("vim.lsp.buf.format({async = true})"), NS)
end

local function setup()
  setg.laststatus = 2 -- Always have a statusline
  set.signcolumn = 'yes:1' -- Display line column

  -- Highlight yanked text
  autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
      vim.highlight.on_yank({
        timeout = 200,
        on_visual = false
      })
    end,
  })

  -- Setup default LSP key mappings
  map("n", "<f6>", lua("vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})"), NS)
  map("n", "<f7>", lua("vim.diagnostic.setloclist()"), NS)
  map("n", "<c-k>", lua("vim.diagnostic.goto_prev({wrap = false})"), NS)
  map("n", "<c-j>", lua("vim.diagnostic.goto_next({wrap = false})"), NS)

  -- LSP virtual text styling
  vim.cmd "hi Conceal cterm=italic ctermbg=none ctermfg=59"

  -- LSP popup styling (colors and borders)
  vim.cmd "hi NormalFloat ctermbg=black"
  vim.cmd "hi WinSeparator ctermbg=none ctermfg=69"
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = "rounded" }
  )
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, { border = "rounded" }
  )
  vim.diagnostic.config({ float = { border = "rounded" } })

  -- Setup individual LSP servers
  require("juice.clangd").setup()
  require("juice.metals").setup()
  require("juice.sumneko").setup()
end

return {
  setupBufferOpts = setupBufferOpts,
  setup = setup,
}
