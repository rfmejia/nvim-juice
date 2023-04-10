local lua = function(str) return string.format("<cmd>lua %s<cr>", str) end
local NS = { noremap = true, silent = true }

-- Cusomize status line with additional messages from metals
local function getStatusline()
  local function metalsStatus()
    local status = vim.g["metals_status"]
    if not status or status == "" then return ""
    else return status .. " "
    end
  end

  return table.concat({
    "%f", -- filename
    "%#Todo#%m%{GitFileStatus()}%#StatusLine#", -- buffer modified flag
    "%q%h%r ", -- buffer type flags
    "%=", -- divider
    "%#DiagnosticInfo#" .. metalsStatus(), -- messages from nvim-metals
    require("juice.lsp").countDiagnostics() .. "%#StatusLine#", -- error and warning counts
    " %l,%c", -- ruler
  })
end

-- Configure and initialize DAP
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

  local dap_group = vim.api.nvim_create_augroup("dap", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "dap-repl" },
    callback = function() require("dap.ext.autocompl").attach() end,
    group = dap_group
  })

  vim.api.nvim_set_keymap("n", "<localleader>dc", lua("require('dap').continue()"), NS)
  vim.api.nvim_set_keymap("n", "<localleader>dr", lua("require('dap').repl.toggle()"), NS)
  vim.api.nvim_set_keymap("n", "<localleader>ds", lua("require('lsp').show_scope()"), NS)
  vim.api.nvim_set_keymap("n", "<localleader>dK", lua("require('dap').dap_ui_widgets.hover()"), NS)
  vim.api.nvim_set_keymap("n", "<localleader>db", lua("require('dap').toggle_breakpoint()"), NS)
  vim.api.nvim_set_keymap("n", "<localleader>dso", lua("require('dap').step_over()"), NS)
  vim.api.nvim_set_keymap("n", "<localleader>dsi", lua("require('dap').step_into()"), NS)
  vim.api.nvim_set_keymap("n", "<localleader>dl", lua("require('dap').run_last()"), NS)
end

-- Configure and initialize metals
local function initializeMetals()
  local metals = require("metals")
  vim.go.shortmess = vim.go.shortmess .. "c"
  vim.o.statusline = [[%!luaeval('require("juice.lsp.metals").getStatusline()')]]
  vim.g["metals_status"] = "Initializing Metals..."

  vim.api.nvim_set_keymap("n", "<localleader>cw", lua("require('metals').hover_worksheet()"), NS)

  local metals_config = metals.bare_config()
  metals_config.settings = {
    showImplicitArguments = true,
    showInferredType = true,
    decorationColor = "Conceal",
    scalafixRulesDependencies = { "com.nequissimus::sort-imports:0.6.1" }
  }
  metals_config.init_options.statusBarProvider = "on"
  metals_config.capabilities = vim.lsp.protocol.make_client_capabilities()
  setupDebugAdapterProtocol()

  metals_config.on_attach = function(client, bufnr)
    require("juice.lsp").setBufferOpts(client, bufnr)
    metals.setup_dap()
  end
  metals.initialize_or_attach(metals_config)
end

-- Add an autocmd to initialize Metals upon entering a Scala/Java file
local function defineAutocmd()
  local lsp_group = vim.api.nvim_create_augroup("metals_lsp", { clear = true })
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "java", "scala", "sbt", "sc" },
    callback = initializeMetals,
    group = lsp_group
  })
end

local function defineUserCommand()
  vim.api.nvim_create_user_command(
    "MetalsInit",
    function(opts)
      initializeMetals()
      vim.api.nvim_del_user_command("MetalsInit")
    end,
    {
      desc = "Start and connect to a Metals server"
    })
end

return {
  defineAutocmd = defineAutocmd,
  getStatusline = getStatusline,
  setup = defineUserCommand,
}
