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
  map("n", "<leader>ca", lua("vim.lsp.buf.code_action()"), NS)
  map("n", "<leader>cr", lua("vim.lsp.buf.rename()"), NS)
  map("n", "<leader>cf", lua("vim.lsp.buf.format({async = true})"), NS)
end

local function setupLsp()
  setg.laststatus = 2    -- Always have a statusline
  set.signcolumn='yes:1'  -- Display line column

  map("n", "<f6>", lua("vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})"), NS)
  map("n", "<f7>", lua("vim.diagnostic.setloclist()"), NS)
  map("n", "<c-k>", lua("vim.diagnostic.goto_prev({wrap = false})"), NS)
  map("n", "<c-j>", lua("vim.diagnostic.goto_next({wrap = false})"), NS)
  map("n", "<leader>cl", lua("vim.lsp.codelens.run()"), NS)

  --  use black background for popups
  vim.cmd "hi NormalFloat ctermbg=black"
  vim.cmd "hi WinSeparator ctermbg=none ctermfg=69"

  --  use round borders for lsp popups
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = "rounded" }
  )
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, { border = "rounded" }
  )
  vim.diagnostic.config({ float = { border = "rounded" } })

  require("juice.clang").setup()
  require("juice.metals").setup()
end

return {
  setupBufferOpts = setupBufferOpts,
  setup = setupLsp,
}
