-- [nfnl] Compiled from fnl/juice/plugins.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = require("juice.util")
local auto_setup = _local_2_["auto-setup"]
local opts = {ui = {border = "rounded"}, performance = {rtp = {disabled_plugins = {"rplugin", "tohtml", "tutor", "vimball"}}}}
local basic
local function _3_()
  return auto_setup("juice.colors")
end
local function _4_()
  local ts = autoload("nvim-treesitter.configs")
  local languages = {"bash", "dockerfile", "fennel", "hocon", "javascript", "json", "git_config", "gitcommit", "gitignore", "go", "html", "java", "lua", "markdown", "scala", "sql", "todotxt", "vim", "vimdoc", "yaml"}
  return ts.setup({ensure_installed = languages, highlight = {enable = true}, indent = {enable = true}})
end
basic = {{"Olical/nfnl", ft = "fennel"}, {"projekt0n/github-nvim-theme", priority = 1000, config = _3_, lazy = false}, {"nvim-treesitter/nvim-treesitter", event = {"BufReadPre", "BufNewFile"}, build = ":TSUpdate", config = _4_}}
local ui_tools
local function _5_()
  local oil = autoload("oil")
  local config = {default_file_explorer = true, delete_to_trash = true}
  return oil.setup(config)
end
local function _6_()
  local telescope = autoload("telescope")
  local actions = autoload("telescope.actions")
  local config = {defaults = {layout_config = {prompt_position = "bottom", height = 0.6}, layout_strategy = "bottom_pane", mappings = {i = {["<esc>"] = actions.close, ["<C-u>"] = false}}, path_display = {"truncate"}, prompt_prefix = "? ", border = false, preview = false}}
  return telescope.setup(config)
end
local function _7_()
  return auto_setup("gitsigns")
end
local function _8_()
  vim.g.undotree_WindowLayout = 4
  vim.g.undotree_SetFocusWhenToggle = 1
  return nil
end
local function _9_()
  if vim.fn.exists("$TMUX") then
    return "VeryLazy"
  else
    return nil
  end
end
local function _11_()
  local nav = autoload("nvim-tmux-navigation")
  return nav.setup({disabled_when_zoomed = true, keybindings = {left = "<M-h>", down = "<M-j>", up = "<M-k>", right = "<M-l>"}})
end
ui_tools = {{"stevearc/oil.nvim", cmd = "Oil", config = _5_}, {"nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = {"nvim-lua/plenary.nvim"}, config = _6_}, {"lewis6991/gitsigns.nvim", event = {"BufReadPre", "BufNewFile"}, config = _7_}, {"mbbill/undotree", cmd = "UndotreeToggle", config = _8_}, {"alexghergh/nvim-tmux-navigation", event = _9_, config = _11_}}
local text_tools
local function _12_()
  return auto_setup("Comment")
end
local function _13_()
  return auto_setup("nvim-surround")
end
text_tools = {{"numToStr/Comment.nvim", keys = "gc", config = _12_}, {"kylechui/nvim-surround", keys = {"cs", "ds", "ys"}, config = _13_}}
local dev_tools
local function _14_()
  return auto_setup("juice.lsp")
end
local function _15_()
  vim.g.copilot_workspace_folders = {"$WORKSPACE/myshake-backends", "$WORKSPACE/myshake-bc"}
  return nil
end
dev_tools = {{"neovim/nvim-lspconfig", ft = {"go", "scala"}, config = _14_}, {"scalameta/nvim-metals", cmd = "MetalsInit", dependencies = {"nvim-lua/plenary.nvim"}}, {"Olical/conjure", ft = {"clojure", "fennel", "lisp", "scheme"}}, {"github/copilot.vim", cmd = "Copilot", config = _15_}}
local database_tools
local function _16_()
  local function _17_()
    vim.opt.commentstring = "--%s"
    vim.opt.omnifunc = "vim_dadbod_completion#omni"
    return nil
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = {"sql", "mysql"}, callback = _17_})
end
database_tools = {{"kristijanhusak/vim-dadbod-ui", cmd = {"DBUI", "DBUIToggle"}, config = _16_, dependencies = {{"tpope/vim-dadbod", lazy = true}, {"kristijanhusak/vim-dadbod-completion", lazy = true, ft = {"sql", "mysql"}}}}}
local function setup()
  local lazy = autoload("lazy")
  local core = autoload("nfnl.core")
  local plugins = core.concat(basic, ui_tools, text_tools, dev_tools, database_tools)
  return lazy.setup(plugins, opts)
end
return {setup = setup}
