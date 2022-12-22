local function setupLsp()
  -- Directories to load Lua modules from (in addition to the current workspace)
  local system_paths = {
    "/usr/share/lua/5.4",
    vim.fn.expand("~/.luarocks/share/lua/5.4"),
  }

  -- Directories including the neovim runtime
  local libraries = { vim.api.nvim_get_runtime_file("", true) }
  for _, path in pairs(system_paths) do
    table.insert(libraries, path)
  end

  -- Runtime path specs
  local runtime_path = vim.split(package.path, ";")
  table.insert(runtime_path, "lua/?.lua")
  table.insert(runtime_path, "lua/?/init.lua")
  for _, path in pairs(system_paths) do
    table.insert(runtime_path, path .. '/?.lua')
    table.insert(runtime_path, path .. '/?/init.lua')
  end

  -- See docs for more configs https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#sumneko_lua
  require("lspconfig").sumneko_lua.setup({
    on_attach = require("juice.lsp").setBufferOpts,
    settings = {
      Lua = {
        runtime = {
          -- Running version of Lua
          version = "LuaJIT",
          path = runtime_path,
        },
        diagnostics = {
          -- Add `vim` global
          globals = { "vim" }
        },
        workspace = {
          library = libraries
        },
        telemetry = { enable = false }
      }
    }
  })
end

return { setup = setupLsp }
