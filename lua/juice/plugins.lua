-- [nfnl] Compiled from fnl/juice/plugins.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.core")
local concat = _local_2_["concat"]
local _local_3_ = autoload("juice.util")
local autocmd = _local_3_["autocmd"]
local auto_setup = _local_3_["auto-setup"]
local set_opts = _local_3_["set-opts"]
local core
local function _4_()
  return auto_setup("juice.colors")
end
local function _5_()
  local ts = autoload("nvim-treesitter.configs")
  local languages = {"bash", "fennel", "gitcommit", "go", "hocon", "java", "json", "lua", "markdown", "scala", "sql", "vimdoc", "yaml"}
  local config = {ensure_installed = languages, highlight = {enable = true}, indent = {enable = true}}
  return ts.setup(config)
end
core = {{"Olical/nfnl", ft = "fennel"}, {"projekt0n/github-nvim-theme", priority = 1000, config = _4_, lazy = false}, {"nvim-treesitter/nvim-treesitter", event = {"BufReadPre", "BufNewFile"}, build = ":TSUpdate", config = _5_}}
local ui_tools
local function _6_()
  local oil = autoload("oil")
  local config = {default_file_explorer = true, delete_to_trash = true}
  return oil.setup(config)
end
local function _7_()
  local telescope = autoload("telescope")
  local actions = autoload("telescope.actions")
  local config = {defaults = {layout_config = {prompt_position = "bottom", height = 0.6}, layout_strategy = "bottom_pane", mappings = {i = {["<esc>"] = actions.close, ["<C-u>"] = false}}, path_display = {"truncate"}, prompt_prefix = "/", preview = false, border = false}}
  return telescope.setup(config)
end
local function _8_()
  vim.g.undotree_WindowLayout = 4
  vim.g.undotree_SetFocusWhenToggle = 1
  return nil
end
ui_tools = {{"stevearc/oil.nvim", cmd = "Oil", config = _6_}, {"nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = {"nvim-lua/plenary.nvim"}, config = _7_}, {"lewis6991/gitsigns.nvim", event = {"BufReadPre", "BufNewFile"}, config = true}, {"mbbill/undotree", cmd = "UndotreeToggle", config = _8_}}
local text_tools = {{"kylechui/nvim-surround", keys = {"cs", "ds", "ys"}, config = true}}
local dev_tools
local function _9_()
  return auto_setup("juice.lsp")
end
dev_tools = {{"neovim/nvim-lspconfig", config = _9_}, {"scalameta/nvim-metals", cmd = "MetalsInit", dependencies = {"nvim-lua/plenary.nvim"}}, {"Olical/conjure", ft = {"clojure", "fennel", "lisp", "scheme"}}}
local database_tools
local function _10_()
  local function _11_()
    return set_opts({commentstring = "-- %s", omnifunc = "vim_dadbod_completion#omni"})
  end
  return autocmd("FileType", {pattern = {"sql", "mysql"}, callback = _11_})
end
database_tools = {{"kristijanhusak/vim-dadbod-ui", cmd = {"DBUI", "DBUIToggle"}, config = _10_, dependencies = {{"tpope/vim-dadbod", lazy = true}, {"kristijanhusak/vim-dadbod-completion", lazy = true, ft = {"sql", "mysql"}}}}}
local function setup()
  local lazy = autoload("lazy")
  local plugins = concat(core, ui_tools, text_tools, dev_tools, database_tools)
  local opts = {ui = {border = "rounded"}, performance = {rtp = {disabled_plugins = {"rplugin", "tohtml", "tutor", "vimball"}}}}
  return lazy.setup(plugins, opts)
end
return {setup = setup}
