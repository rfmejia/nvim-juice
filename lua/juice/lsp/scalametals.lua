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
  local tvp = autoload("metals.tvp")
  local options = {signcolumn = "yes:1", shortmess = (vim.go.shortmess .. "c"), statusline = statusline.build({"%{g:metals_status}", " \226\151\143"})}
  local metals_settings = {inlayHints = {hintsInPatternMatch = {enable = true}, implicitArguments = {enable = true}, implicitConversions = {enable = true}, inferredTypes = {enable = true}, typeParameters = {enable = true}}}
  local metals_maps
  local function _2_(bufnr)
    _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/lsp/scalametals.fnl:19")
    local function _3_()
      return metals.hover_worksheet({border = "rounded"})
    end
    return {{"v", "K", metals.type_of_range, {desc = "show type of visual selection", buffer = bufnr}}, {"n", "<localleader>mw", _3_, {desc = "show (m)etals (w)orksheet output in popup", buffer = bufnr}}, {"n", "<localleader>mc", telescope.extensions.metals.commands, {desc = "list (m)etals (c)commands", buffer = bufnr}}, {"n", "<localleader>mt", tvp.toggle_tree_view, {desc = "(m)etals (t)oggle tree view", buffer = bufnr}}, {"n", "<localleader>mr", tvp.reveal_in_tree, {desc = "(m)etals (r)eveal current member in tree view", buffer = bufnr}}}
  end
  metals_maps = _2_
  util["assoc-in"](vim.opt, options)
  config.settings = metals_settings
  config.init_options.statusBarProvider = "on"
  config.capabilities = vim.lsp.protocol.make_client_capabilities()
  config["tvp"] = {panel_alignment = "right", toggle_node_mapping = "<CR>", node_command_mapping = "r"}
  config.handlers = juice_lsp.handlers
  local function _4_(client, bufnr)
    _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/lsp/scalametals.fnl:51")
    _G.assert((nil ~= client), "Missing argument client on /home/rfmejia/.config/nvim/fnl/juice/lsp/scalametals.fnl:51")
    juice_lsp["set-buffer-opts"](client, bufnr)
    return util["set-keys"](metals_maps(bufnr))
  end
  config.on_attach = _4_
  --[[ "Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)" ]]
  vim.api.nvim_create_augroup("metals-group", {})
  local function _5_()
    return metals.initialize_or_attach(config)
  end
  vim.api.nvim_create_autocmd("FileType", {group = "metals-group", pattern = {"scala", "sbt", "java"}, callback = _5_})
  local function _6_()
    return metals.initialize_or_attach(config)
  end
  vim.api.nvim_create_user_command("MetalsInit", _6_, {desc = "Start and connect to a Metals server"})
  --[[ "Initialize Metals for the first time" ]]
  vim.g["metals_status"] = "Initializing Metals..."
  return metals.initialize_or_attach(config)
end
local function register_init_command()
  local function _7_()
    return initialize_metals()
  end
  return vim.api.nvim_create_user_command("MetalsInit", _7_, {desc = "Start and connect to a Metals server"})
end
return {["register-init-command"] = register_init_command}
