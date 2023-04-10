local function setupLsp()
  require("lspconfig").svelte.setup({
    server = {
      on_attach = require("juice.lsp").setBufferOpts
    }
  })
end

return {
  setup = setupLsp,
}
