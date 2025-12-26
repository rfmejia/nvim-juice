-- [nfnl] fnl/juice/packs/scalametals.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local pack = autoload("pack")
local statusline = autoload("juice.statusline")
local util = autoload("juice.util")
local function initialize_metals()
  local metals = autoload("metals")
  local config = metals.bare_config()
  local tvp = autoload("metals.tvp")
  local options = {signcolumn = "yes:1", shortmess = (vim.go.shortmess .. "c"), statusline = statusline.build({"%{g:metals_status}", " \226\151\143"})}
  local metals_settings = {disabledMode = true, defaultBspToBuildTool = true, enableSemanticHighlighting = true, inlayHints = {byNameParameters = {enable = true}, hintsInPatternMatch = {enable = true}, implicitArguments = {enable = true}, implicitConversions = {enable = true}, inferredTypes = {enable = true}, typeParameters = {enable = true}}, startMcpServer = true}
  local metals_maps
  local function _2_(bufnr)
    if (nil == bufnr) then
      _G.error("Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/packs/scalametals.fnl:24", 2)
    else
    end
    local function _4_()
      return metals.hover_worksheet({border = "rounded"})
    end
    return {{"v", "K", metals.type_of_range, {desc = "[metals] show type of visual selection", buffer = bufnr}}, {"n", "<localleader>mw", _4_, {desc = "[metals] show (m)etals (w)orksheet output in popup", buffer = bufnr}}, {"n", "<localleader>mt", tvp.toggle_tree_view, {desc = "[metals] (m)etals (t)oggle tree view", buffer = bufnr}}, {"n", "<localleader>mr", tvp.reveal_in_tree, {desc = "[metals] (m)etals (r)eveal current member in tree view", buffer = bufnr}}}
  end
  metals_maps = _2_
  config.settings = metals_settings
  config.init_options.statusBarProvider = "on"
  config.capabilities = vim.lsp.protocol.make_client_capabilities()
  config.tvp = {panel_alignment = "right", toggle_node_mapping = "<CR>", node_command_mapping = "r"}
  local function _5_(client, bufnr)
    if (nil == bufnr) then
      _G.error("Missing argument bufnr on /home/rfmejia/.config/nvim/fnl/juice/packs/scalametals.fnl:52", 2)
    else
    end
    if (nil == client) then
      _G.error("Missing argument client on /home/rfmejia/.config/nvim/fnl/juice/packs/scalametals.fnl:52", 2)
    else
    end
    util["set-keys"](metals_maps(bufnr))
    return core["merge!"](vim.opt_local, options)
  end
  config.on_attach = _5_
  --[[ "Automatically attach Metals to all Scala filetypes (only triggered upon BufEnter)" ]]
  local function _8_()
    return metals.initialize_or_attach(config)
  end
  vim.api.nvim_create_autocmd("FileType", {pattern = {"scala", "java"}, callback = _8_, group = vim.api.nvim_create_augroup("metals-group", {clear = true})})
  --[[ "Initialize Metals for the first time" ]]
  vim.g.metals_status = "Initializing Metals..."
  return metals.initialize_or_attach(config)
end
local function _9_()
  pack.add({{src = "https://github.com/scalameta/nvim-metals"}})
  local function _10_()
    local scalametals = autoload("juice.lsp.scalametals")
    return initialize_metals()
  end
  return pack["load-on-event"]("nvim-metals", "FileType", {pattern = "scala", callback = _10_})
end
return {setup = _9_}
