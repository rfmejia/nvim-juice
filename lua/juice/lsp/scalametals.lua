-- [nfnl] Compiled from fnl/juice/lsp/scalametals.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local statusline = autoload("juice.statusline")
local util = autoload("juice.util")
local function initialize_metals()
  local metals = autoload("metals")
  local config = metals.bare_config()
  local tvp = autoload("metals.tvp")
  local options = {signcolumn = "yes:1", shortmess = (vim.go.shortmess .. "c"), statusline = statusline.build({"%{g:metals_status}", " \226\151\143"})}
  local metals_settings = {inlayHints = {hintsInPatternMatch = {enable = true}, implicitArguments = {enable = true}, implicitConversions = {enable = true}, inferredTypes = {enable = true}, typeParameters = {enable = true}}}
  local metals_maps
  local function _2_(bufnr)
    _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/lsp/scalametals.fnl:17")
    local function _3_()
      return metals.hover_worksheet({border = "rounded"})
    end
    return {{"v", "K", metals.type_of_range, {desc = "[metals] show type of visual selection", buffer = bufnr}}, {"n", "<localleader>mw", _3_, {desc = "[metals] show (m)etals (w)orksheet output in popup", buffer = bufnr}}, {"n", "<localleader>mt", tvp.toggle_tree_view, {desc = "[metals] (m)etals (t)oggle tree view", buffer = bufnr}}, {"n", "<localleader>mr", tvp.reveal_in_tree, {desc = "[metals] (m)etals (r)eveal current member in tree view", buffer = bufnr}}}
  end
  metals_maps = _2_
  config.settings = metals_settings
  config.init_options.statusBarProvider = "on"
  config.capabilities = vim.lsp.protocol.make_client_capabilities()
  config["tvp"] = {panel_alignment = "right", toggle_node_mapping = "<CR>", node_command_mapping = "r"}
  local function _4_(client, bufnr)
    _G.assert((nil ~= bufnr), "Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/lsp/scalametals.fnl:45")
    _G.assert((nil ~= client), "Missing argument client on /home/rfmejia/.config/nvim/fnl/juice/lsp/scalametals.fnl:45")
    util["set-keys"](metals_maps(bufnr))
    return util["assoc-in"](vim.opt_local, options)
  end
  config.on_attach = _4_
  --[[ "Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)" ]]
  local function _5_()
    return metals.initialize_or_attach(config)
  end
  vim.api.nvim_create_autocmd("FileType", {pattern = {"scala", "java"}, callback = _5_, group = vim.api.nvim_create_augroup("metals-group", {clear = true})})
  local function _6_()
    return metals.initialize_or_attach(config)
  end
  vim.api.nvim_create_user_command("MetalsInit", _6_, {desc = "Re-attach to a Metals server"})
  --[[ "Initialize Metals for the first time" ]]
  vim.g["metals_status"] = "Initializing Metals..."
  return metals.initialize_or_attach(config)
end
return {["initialize-metals"] = initialize_metals}
