-- [nfnl] Compiled from fnl/juice/plugins.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = require("juice.util")
local autocmd = _local_2_["autocmd"]
local auto_setup = _local_2_["auto-setup"]
local _local_3_ = autoload("nfnl.core")
local concat = _local_3_["concat"]
local basic
local function _4_()
  return auto_setup("juice.colors")
end
local function _5_()
  local ts = autoload("nvim-treesitter.configs")
  local languages = {"bash", "dockerfile", "fennel", "hocon", "javascript", "json", "git_config", "gitcommit", "gitignore", "go", "html", "java", "lua", "markdown", "scala", "sql", "todotxt", "vim", "vimdoc", "yaml"}
  local config = {ensure_installed = languages, highlight = {enable = true}, indent = {enable = true}}
  return ts.setup(config)
end
basic = {{"Olical/nfnl", ft = "fennel"}, {"projekt0n/github-nvim-theme", priority = 1000, config = _4_, lazy = false}, {"nvim-treesitter/nvim-treesitter", event = {"BufReadPre", "BufNewFile"}, build = ":TSUpdate", config = _5_}}
local ui_tools
local function _6_()
  local oil = autoload("oil")
  local config = {default_file_explorer = true, delete_to_trash = true}
  return oil.setup(config)
end
local function _7_()
  local telescope = autoload("telescope")
  local actions = autoload("telescope.actions")
  local config = {defaults = {layout_config = {prompt_position = "bottom", height = 0.6}, layout_strategy = "bottom_pane", mappings = {i = {["<esc>"] = actions.close, ["<C-u>"] = false}}, path_display = {"truncate"}, prompt_prefix = "? ", border = false, preview = false}}
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
local function _10_()
  if vim.fn.exists("$TMUX") then
    return "VeryLazy"
  else
    return nil
  end
end
local function _12_()
  local nav = autoload("nvim-tmux-navigation")
  local config = {disabled_when_zoomed = true, keybindings = {left = "<M-h>", down = "<M-j>", up = "<M-k>", right = "<M-l>"}}
  return nav.setup(config)
end
ui_tools = {{"stevearc/oil.nvim", cmd = "Oil", config = _6_}, {"nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = {"nvim-lua/plenary.nvim"}, config = _7_}, {"lewis6991/gitsigns.nvim", event = {"BufReadPre", "BufNewFile"}, config = _8_}, {"mbbill/undotree", cmd = "UndotreeToggle", config = _9_}, {"alexghergh/nvim-tmux-navigation", event = _10_, config = _12_}}
local text_tools
local function _13_()
  return auto_setup("Comment")
end
local function _14_()
  return auto_setup("nvim-surround")
end
text_tools = {{"numToStr/Comment.nvim", keys = "gc", config = _13_}, {"kylechui/nvim-surround", keys = {"cs", "ds", "ys"}, config = _14_}}
local dev_tools
local function _15_()
  return auto_setup("juice.lsp")
end
local function _16_()
  vim.g.copilot_workspace_folders = {"$WORKSPACE/myshake-backends", "$WORKSPACE/myshake-bc"}
  return nil
end
dev_tools = {{"neovim/nvim-lspconfig", ft = {"go", "scala"}, config = _15_}, {"scalameta/nvim-metals", cmd = "MetalsInit", dependencies = {"nvim-lua/plenary.nvim"}}, {"Olical/conjure", ft = {"clojure", "fennel", "lisp", "scheme"}}, {"github/copilot.vim", cmd = "Copilot", config = _16_}}
local database_tools
local function _17_()
  local function _18_()
    vim.opt.commentstring = "--%s"
    vim.opt.omnifunc = "vim_dadbod_completion#omni"
    return nil
  end
  return autocmd("FileType", {pattern = {"sql", "mysql"}, callback = _18_})
end
database_tools = {{"kristijanhusak/vim-dadbod-ui", cmd = {"DBUI", "DBUIToggle"}, config = _17_, dependencies = {{"tpope/vim-dadbod", lazy = true}, {"kristijanhusak/vim-dadbod-completion", lazy = true, ft = {"sql", "mysql"}}}}}
local function setup()
  local lazy = autoload("lazy")
  local plugins = concat(basic, ui_tools, text_tools, dev_tools, database_tools)
  local opts = {ui = {border = "rounded"}, performance = {rtp = {disabled_plugins = {"rplugin", "tohtml", "tutor", "vimball"}}}}
  return lazy.setup(plugins, opts)
end
return {setup = setup}
