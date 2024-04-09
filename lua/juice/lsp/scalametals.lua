-- [nfnl] Compiled from fnl/juice/lsp/scalametals.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.util")
local autocmd = _local_2_["autocmd"]
local augroup = _local_2_["augroup"]
local nmap = _local_2_["nmap"]
local user_command = _local_2_["user-command"]
local vmap = _local_2_["vmap"]
local _local_3_ = autoload("juice.statusline")
local build_statusline = _local_3_["build-statusline"]
local function initialize_metals()
  local lsp = autoload("juice.lsp")
  local metals = autoload("metals")
  local config = metals.bare_config()
  local telescope = autoload("telescope")
  vim.opt.signcolumn = "yes:1"
  vim.go.shortmess = (vim.go.shortmess .. "c")
  vim.opt.statusline = build_statusline({"%{g:metals_status}"})
  do end (vim.g)["metals_status"] = "Initializing Metals..."
  config.settings = {showImplicitArguments = true, showImplicitConversionsAndClasses = true, showInferredType = true, decorationColor = "Conceal", serverVersion = "latest.snapshot", scalafixRulesDependencies = {"com.nequissimus::sort-imports:0.6.1"}}
  config.init_options.statusBarProvider = "on"
  config.capabilities = vim.lsp.protocol.make_client_capabilities()
  do end (config)["tvp"] = {panel_alignment = "right", toggle_node_mapping = "<CR>", node_command_mapping = "r"}
  local function _4_(client, bufnr)
    lsp["set-buffer-opts"](client, bufnr)
    vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
    local function _5_()
      return metals.type_of_range()
    end
    vmap("K", _5_, {"noremap", "silent"})
    local function _6_()
      return metals.hover_worksheet({border = "rounded"})
    end
    nmap("<localleader>mw", _6_, {"noremap", "silent"})
    local function _7_()
      return telescope.extensions.metals.commands()
    end
    nmap("<localleader>mm", _7_, {"noremap", "silent"})
    nmap("<localleader>mt", (autoload("metals.tvp")).toggle_tree_view, {"noremap", "silent"})
    return nmap("<localleader>mr", (autoload("metals.tvp")).reveal_in_tree, {"noremap", "silent"})
  end
  config.on_attach = _4_
  --[[ "Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)" ]]
  augroup("metals-group", {})
  local function _8_()
    return metals.initialize_or_attach(config)
  end
  autocmd("FileType", {group = "metals-group", pattern = {"scala", "sbt", "java"}, callback = _8_})
  --[[ "Initialize Metals for the first time" ]]
  return metals.initialize_or_attach(config)
end
local function register_init_command()
  local function _9_()
    return initialize_metals()
  end
  return user_command("MetalsInit", _9_, {desc = "Start and connect to a Metals server"})
end
return {["register-init-command"] = register_init_command}
