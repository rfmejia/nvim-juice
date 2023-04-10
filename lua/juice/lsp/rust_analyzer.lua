local function setupLsp()
  require("lspconfig").rust_analyzer.setup({
    server = {
      on_attach = require("juice.lsp").setBufferOpts
    }
  })
end

return {
  setup = setupLsp,
}
