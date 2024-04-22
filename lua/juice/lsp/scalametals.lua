-- [nfnl] Compiled from fnl/juice/lsp/scalametals.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.util")
local autocmd = _local_2_["autocmd"]
local augroup = _local_2_["augroup"]
local nmap = _local_2_["nmap"]
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
    _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/lsp/scalametals.fnl:27")
    _G.assert((nil ~= client), "Missing argument client on /home/rfmejia/.config/nvim/fnl/juice/lsp/scalametals.fnl:27")
    local tvp = autoload("metals.tvp")
    lsp["set-buffer-opts"](client, bufnr)
    vim.opt.omnifunc = "v:lua.vim.lsp.omnifunc"
    vmap("K", metals.type_of_range, {"noremap", "silent"}, "scala type of visual range", bufnr)
    local function _5_()
      return metals.hover_worksheet({border = "rounded"})
    end
    nmap("<localleader>mw", _5_, {"noremap", "silent"}, "(m)etals (w)orksheet", bufnr)
    nmap("<localleader>mc", telescope.extensions.metals.commands, {"noremap", "silent"}, "(m)etals (c)commands", bufnr)
    nmap("<localleader>mt", tvp.toggle_tree_view, {"noremap", "silent"}, "(m)etals (t)oggle tree view", bufnr)
    return nmap("<localleader>mr", tvp.reveal_in_tree, {"noremap", "silent"}, "(m)etals (r)eveal in tree", bufnr)
  end
  config.on_attach = _4_
  --[[ "Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)" ]]
  augroup("metals-group", {})
  local function _6_()
    return metals.initialize_or_attach(config)
  end
  autocmd("FileType", {group = "metals-group", pattern = {"scala", "sbt", "java"}, callback = _6_})
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
