local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd
local lua = function(str) return string.format("<cmd>lua %s<cr>", str) end
local map = vim.api.nvim_set_keymap
local set = vim.opt
local setg = vim.opt_global

local NS = { noremap = true, silent = true }
local NSW = { noremap = true, silent = true, nowait = true }

local function setupMetalsStatusLine()
  local function metalsStatus()
    local status = vim.g["metals_status"]
    if not status or status == "" then return "%l,%c"
    else return status
    end
  end

  return table.concat({
    "%f",                                        -- filename
    "%#ErrorMsg#%m%#Normal#",                    -- buffer modified flag
    "%q%h%r ",                                   -- buffer type flags
    "%=",                                        -- divider
    metalsStatus(),                              -- messages from nvim-metals
  })
end

local function setupDebugAdapterProtocol()
  require("dap").configurations.scala = {
    {
      type = "scala",
      request = "launch",
      name = "RunOrTest",
      metals = { runType = "runOrTestFile" }
    }, {
      type = "scala",
      request = "launch",
      name = "Test Target",
      metals = { runType = "testTarget" }
    }
  }

  local dap_group = augroup("dap", { clear = true })
  autocmd("FileType", {
    pattern = { "dap-repl" },
    callback = function() require("dap.ext.autocompl").attach() end,
    group = dap_group
  })

  map("n", "<localleader>dc", lua("require('dap').continue()"), NS)
  map("n", "<localleader>db", lua("require('dap').repl.toggle()"), NS)
  map("n", "<localleader>ds", lua("require('lsp').show_scope()"), NS)
  map("n", "<localleader>dK", lua("require('dap').dap_ui_widgets.hover()"), NS)
  map("n", "<localleader>db", lua("require('dap').toggle_breakpoint()"), NS)
  map("n", "<localleader>dso", lua("require('dap').step_over()"), NS)
  map("n", "<localleader>dsi", lua("require('dap').step_into()"), NS)
  map("n", "<localleader>dl", lua("require('dap').run_last()"), NS)
end

local function initializeMetals()
  local metals = require("metals")
  setg.shortmess:append("c")
  set.statusline = [[%!luaeval('require("juice.metals").setupStatusLine()')]]

  local metals_config = metals.bare_config()
  metals_config.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    decorationColor = "Conceal",
    bloopSbtAlreadyInstalled = true,
    scalafixRulesDependencies = { "com.nequissimus::sort-imports:0.6.1" }
  }
  metals_config.init_options.statusBarProvider = "on"
  metals_config.capabilities = vim.lsp.protocol.make_client_capabilities()
  setupDebugAdapterProtocol()

  metals_config.on_attach = function(client, bufnr)
    require("juice").setupBufferOpts(client, bufnr)
    metals.setup_dap()
  end
  metals.initialize_or_attach(metals_config)
end

local function setupMetalsLsp()
  local lsp_group = augroup("metals_lsp", { clear = true })
  autocmd("FileType", {
    pattern = { "java", "scala", "sbt", "sc" },
    callback = initializeMetals,
    group = lsp_group
  })
end

return {
  setupStatusLine = setupMetalsStatusLine,
  setup = setupMetalsLsp,
}
