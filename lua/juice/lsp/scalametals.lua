-- [nfnl] Compiled from fnl/juice/lsp/scalametals.fnl by https://github.com/Olical/nfnl, do not edit.
local function initialize_metals()
  local u = require("juice.util")
  local sl = require("juice.statusline")
  local lsp = require("juice.lsp")
  local metals = require("metals")
  local config = metals.bare_config()
  local telescope = require("telescope")
  vim.opt.signcolumn = "yes:1"
  vim.go.shortmess = (vim.go.shortmess .. "c")
  vim.opt.statusline = sl["build-statusline"]({"%{g:metals_status}"})
  do end (vim.g)["metals_status"] = "Initializing Metals..."
  config.settings = {showImplicitArguments = true, showImplicitConversionsAndClasses = true, showInferredType = true, decorationColor = "Conceal", serverVersion = "latest.snapshot", scalafixRulesDependencies = {"com.nequissimus::sort-imports:0.6.1"}}
  config.init_options.statusBarProvider = "on"
  config.capabilities = vim.lsp.protocol.make_client_capabilities()
  do end (config)["tvp"] = {panel_alignment = "right", toggle_node_mapping = "<CR>", node_command_mapping = "r"}
  local function _1_(client, bufnr)
    lsp["set-buffer-opts"](client, bufnr)
    vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
    local function _2_()
      return metals.type_of_range()
    end
    u.vmap("K", _2_, {"noremap", "silent"})
    local function _3_()
      return metals.hover_worksheet({border = "rounded"})
    end
    u.nmap("<localleader>mw", _3_, {"noremap", "silent"})
    local function _4_()
      return telescope.extensions.metals.commands()
    end
    u.nmap("<localleader>mm", _4_, {"noremap", "silent"})
    u.nmap("<localleader>mt", (require("metals.tvp")).toggle_tree_view, {"noremap", "silent"})
    return u.nmap("<localleader>mr", (require("metals.tvp")).reveal_in_tree, {"noremap", "silent"})
  end
  config.on_attach = _1_
  --[[ "Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)" ]]
  vim.api.nvim_create_augroup("metals-group", {})
  local function _5_()
    return metals.initialize_or_attach(config)
  end
  vim.api.nvim_create_autocmd("FileType", {group = "metals-group", pattern = {"scala", "sbt", "java"}, callback = _5_})
  --[[ "Initialize Metals for the first time" ]]
  return metals.initialize_or_attach(config)
end
local function register_init_command()
  local function _6_()
    return initialize_metals()
  end
  return vim.api.nvim_create_user_command("MetalsInit", _6_, {desc = "Start and connect to a Metals server"})
end
return {["register-init-command"] = register_init_command}
