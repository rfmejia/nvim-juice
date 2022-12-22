local function setupLsp()
  require("clangd_extensions").setup({
    server = {
      on_attach = require("juice.lsp").setBufferOpts
    }
  })
end

return {
  setup = setupLsp,
}
