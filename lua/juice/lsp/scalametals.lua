-- [nfnl] Compiled from fnl/juice/lsp/scalametals.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local function initialize_metals()
  local u = autoload("juice.util")
  local sl = autoload("juice.statusline")
  local lsp = autoload("juice.lsp")
  local metals = autoload("metals")
  local config = metals.bare_config()
  local telescope = autoload("telescope")
  vim.opt.signcolumn = "yes:1"
  vim.go.shortmess = (vim.go.shortmess .. "c")
  vim.opt.statusline = sl["build-statusline"]({"%{g:metals_status}"})
  do end (vim.g)["metals_status"] = "Initializing Metals..."
  config.settings = {showImplicitArguments = true, showImplicitConversionsAndClasses = true, showInferredType = true, decorationColor = "Conceal", serverVersion = "latest.snapshot", scalafixRulesDependencies = {"com.nequissimus::sort-imports:0.6.1"}}
  config.init_options.statusBarProvider = "on"
  config.capabilities = vim.lsp.protocol.make_client_capabilities()
  do end (config)["tvp"] = {panel_alignment = "right", toggle_node_mapping = "<CR>", node_command_mapping = "r"}
  local function _2_(client, bufnr)
    lsp["set-buffer-opts"](client, bufnr)
    vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
    local function _3_()
      return metals.type_of_range()
    end
    u.vmap("K", _3_, {"noremap", "silent"})
    local function _4_()
      return metals.hover_worksheet({border = "rounded"})
    end
    u.nmap("<localleader>mw", _4_, {"noremap", "silent"})
    local function _5_()
      return telescope.extensions.metals.commands()
    end
    u.nmap("<localleader>mm", _5_, {"noremap", "silent"})
    u.nmap("<localleader>mt", (autoload("metals.tvp")).toggle_tree_view, {"noremap", "silent"})
    return u.nmap("<localleader>mr", (autoload("metals.tvp")).reveal_in_tree, {"noremap", "silent"})
  end
  config.on_attach = _2_
  --[[ "Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)" ]]
  vim.api.nvim_create_augroup("metals-group", {})
  local function _6_()
    return metals.initialize_or_attach(config)
  end
  vim.api.nvim_create_autocmd("FileType", {group = "metals-group", pattern = {"scala", "sbt", "java"}, callback = _6_})
  --[[ "Initialize Metals for the first time" ]]
  return metals.initialize_or_attach(config)
end
local function register_init_command()
  local function _7_()
    return initialize_metals()
  end
  return vim.api.nvim_create_user_command("MetalsInit", _7_, {desc = "Start and connect to a Metals server"})
end
return {["register-init-command"] = register_init_command}
