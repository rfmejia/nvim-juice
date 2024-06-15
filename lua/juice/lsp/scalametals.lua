-- [nfnl] Compiled from fnl/juice/lsp/scalametals.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local statusline = autoload("juice.statusline")
local util = autoload("juice.util")
local function initialize_metals()
  local juice_lsp = autoload("juice.lsp")
  local metals = autoload("metals")
  local config = metals.bare_config()
  local telescope = autoload("telescope")
  vim.opt.signcolumn = "yes:1"
  vim.go.shortmess = (vim.go.shortmess .. "c")
  vim.opt.statusline = statusline.build({"%{g:metals_status}", " \226\151\143"})
  do end (vim.g)["metals_status"] = "Initializing Metals..."
  config.settings = {showImplicitArguments = true, showImplicitConversionsAndClasses = true, showInferredType = true}
  config.init_options.statusBarProvider = "on"
  config.capabilities = vim.lsp.protocol.make_client_capabilities()
  do end (config)["tvp"] = {panel_alignment = "right", toggle_node_mapping = "<CR>", node_command_mapping = "r"}
  config.handlers = juice_lsp.handlers
  local function _2_(client, bufnr)
    _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/lsp/scalametals.fnl:26")
    _G.assert((nil ~= client), "Missing argument client on /home/rfmejia/.config/nvim/fnl/juice/lsp/scalametals.fnl:26")
    local tvp = autoload("metals.tvp")
    local metals_maps
    local function _3_()
      return metals.hover_worksheet({border = "rounded"})
    end
    metals_maps = {v = {K = {metals.type_of_range, {"noremap", "silent"}, "show type of visual selection"}}, n = {["<localleader>mw"] = {_3_, {"noremap", "silent"}, "show (m)etals (w)orksheet output in popup"}, ["<localleader>mc"] = {telescope.extensions.metals.commands, {"noremap", "silent"}, "list (m)etals (c)commands"}, ["<localleader>mt"] = {tvp.toggle_tree_view, {"noremap", "silent"}, "(m)etals (t)oggle tree view"}, ["<localleader>mr"] = {tvp.reveal_in_tree, {"noremap", "silent"}, "(m)etals (r)eveal current member in tree view"}}}
    juice_lsp["set-buffer-opts"](client, bufnr)
    return util.bufmap(bufnr, metals_maps)
  end
  config.on_attach = _2_
  --[[ "Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)" ]]
  vim.api.nvim_create_augroup("metals-group", {})
  local function _4_()
    return metals.initialize_or_attach(config)
  end
  vim.api.nvim_create_autocmd("FileType", {group = "metals-group", pattern = {"scala", "sbt", "java"}, callback = _4_})
  --[[ "Initialize Metals for the first time" ]]
  return metals.initialize_or_attach(config)
end
local function register_init_command()
  local function _5_()
    return initialize_metals()
  end
  return vim.api.nvim_create_user_command("MetalsInit", _5_, {desc = "Start and connect to a Metals server"})
end
return {["register-init-command"] = register_init_command}
