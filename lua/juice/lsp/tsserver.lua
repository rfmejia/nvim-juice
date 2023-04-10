local function setupLsp()
  require("lspconfig").tsserver.setup({
    server = {
      on_attach = require("juice.lsp").setBufferOpts
    }
  })
end

return {
  setup = setupLsp,
}
