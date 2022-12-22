local lua = function(str) return string.format("<cmd>lua %s<cr>", str) end

local NS = { noremap = true, silent = true }
local NSW = { noremap = true, silent = true, nowait = true }

-- Buffer-specific LSP options
local function setBufferOpts(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

  vim.api.nvim_set_keymap("n", "gd", lua("vim.lsp.buf.definition()"), NSW)
  vim.api.nvim_set_keymap("n", "gt", lua("vim.lsp.buf.type_definition()"), NSW)
  vim.api.nvim_set_keymap("n", "gi", lua("vim.lsp.buf.implementation()"), NS)
  vim.api.nvim_set_keymap("n", "gr", lua("vim.lsp.buf.references()"), NS)
  vim.api.nvim_set_keymap("n", "gs", lua("vim.lsp.buf.document_symbol()"), NS)
  vim.api.nvim_set_keymap("n", "gS", lua("vim.lsp.buf.workspace_symbol()"), NS)
  vim.api.nvim_set_keymap("n", "K", lua("vim.lsp.buf.hover()"), NS)
  vim.api.nvim_set_keymap("n", "<localleader>ca", lua("vim.lsp.buf.code_action()"), NS)
  vim.api.nvim_set_keymap("n", "<localleader>cr", lua("vim.lsp.buf.rename()"), NS)
  vim.api.nvim_set_keymap("n", "<localleader>cf", lua("vim.lsp.buf.format({async = true})"), NS)
end

-- Format the number of error and warning diagnostics and format for statusline
local function countDiagnostics()
  local str = ""
  local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  local warns = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  if errors ~= 0 then str = str .. "%#DiagnosticError#!" .. errors .. "%#Normal# " end
  if warns ~= 0 then str = str .. "%#DiagnosticWarn#!" .. warns .. "%#Normal# " end
  return str
end

local function setup()
  -- Setup default LSP key mappings
  vim.api.nvim_set_keymap("n", "<f6>",
    lua("vim.diagnostic.setqflist({severity = vim.diagnostic.severity.ERROR})"), NS)
  vim.api.nvim_set_keymap("n", "<f7>", lua("vim.diagnostic.setloclist()"), NS)
  vim.api.nvim_set_keymap("n", "<c-k>", lua("vim.diagnostic.goto_prev({wrap = false})"), NS)
  vim.api.nvim_set_keymap("n", "<c-j>", lua("vim.diagnostic.goto_next({wrap = false})"), NS)

  -- LSP virtual text, error and warning styling
  vim.cmd "hi Conceal cterm=italic ctermbg=none ctermfg=59 gui=italic guibg=none guifg=59"

  -- LSP popup styling (colors and borders)
  vim.cmd "hi NormalFloat ctermbg=black guibg=black"
  vim.cmd "hi WinSeparator ctermbg=black ctermfg=69 guibg=black guifg=69"
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, { border = "rounded" }
  )
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, { border = "rounded" }
  )
  vim.diagnostic.config({ float = { border = "rounded" } })

  -- Setup individual LSP servers
  require("juice.lsp.clangd").setup()
  require("juice.lsp.metals").setup()
  require("juice.lsp.sumneko").setup()
end

return {
  countDiagnostics = countDiagnostics,
  setBufferOpts = setBufferOpts,
  setup = setup,
}
