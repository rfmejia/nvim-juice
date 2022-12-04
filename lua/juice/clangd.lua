local function setupLsp()
  require("clangd_extensions").setup({
    server = {
      on_attach = require("juice").setupBufferOpts
    }
  })
end

return {
  setup = setupLsp,
}
