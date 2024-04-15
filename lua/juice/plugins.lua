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
  local languages = {"bash", "dockerfile", "fennel", "hocon", "javascript", "json", "git_config", "gitcommit", "gitignore", "go", "html", "java", "lua", "markdown", "scala", "sql", "todotxt", "vim", "vimdoc", "yaml"}
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
  local config = {defaults = {layout_config = {prompt_position = "bottom", height = 0.6}, layout_strategy = "bottom_pane", mappings = {i = {["<esc>"] = actions.close, ["<C-u>"] = false}}, path_display = {"truncate"}, prompt_prefix = ":", border = false, preview = false}}
  return telescope.setup(config)
end
local function _8_()
  return auto_setup("gitsigns")
end
local function _9_()
  vim.g.undotree_WindowLayout = 4
  vim.g.undotree_SetFocusWhenToggle = 1
  return nil
end
ui_tools = {{"stevearc/oil.nvim", cmd = "Oil", config = _6_}, {"nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = {"nvim-lua/plenary.nvim"}, config = _7_}, {"lewis6991/gitsigns.nvim", event = {"BufReadPre", "BufNewFile"}, config = _8_}, {"mbbill/undotree", cmd = "UndotreeToggle", config = _9_}}
local text_tools
local function _10_()
  return auto_setup("Comment")
end
local function _11_()
  return auto_setup("nvim-surround")
end
text_tools = {{"numToStr/Comment.nvim", keys = "gc", config = _10_}, {"kylechui/nvim-surround", keys = {"cs", "ds", "ys"}, config = _11_}}
local dev_tools
local function _12_()
  return auto_setup("juice.lsp")
end
local function _13_()
  vim.g.copilot_workspace_folders = {"$WORKSPACE/myshake-backends", "$WORKSPACE/myshake-bc"}
  return nil
end
dev_tools = {{"neovim/nvim-lspconfig", ft = {"go", "scala"}, config = _12_}, {"scalameta/nvim-metals", cmd = "MetalsInit", dependencies = {"nvim-lua/plenary.nvim"}}, {"Olical/conjure", ft = {"clojure", "fennel", "lisp", "scheme"}}, {"github/copilot.vim", cmd = "Copilot", config = _13_}}
local database_tools
local function _14_()
  local function _15_()
    return set_opts({commentstring = "-- %s", omnifunc = "vim_dadbod_completion#omni"})
  end
  return autocmd("FileType", {pattern = {"sql", "mysql"}, callback = _15_})
end
database_tools = {{"kristijanhusak/vim-dadbod-ui", cmd = {"DBUI", "DBUIToggle"}, config = _14_, dependencies = {{"tpope/vim-dadbod", lazy = true}, {"kristijanhusak/vim-dadbod-completion", lazy = true, ft = {"sql", "mysql"}}}}}
local function setup()
  local lazy = autoload("lazy")
  local plugins = concat(core, ui_tools, text_tools, dev_tools, database_tools)
  local opts = {ui = {border = "rounded"}, performance = {rtp = {disabled_plugins = {"rplugin", "tohtml", "tutor", "vimball"}}}}
  return lazy.setup(plugins, opts)
end
return {setup = setup}
