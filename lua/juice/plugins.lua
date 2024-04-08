-- [nfnl] Compiled from fnl/juice/plugins.fnl by https://github.com/Olical/nfnl, do not edit.
local lazy = require("lazy")
local core = require("nfnl.core")
local opts = {ui = {border = "rounded"}, performance = {rtp = {disabled_plugins = {"rplugin", "tohtml", "tutor", "vimball"}}}}
local basic
local function _1_()
  local c = require("juice.colors")
  return c.setup()
end
local function _2_()
  local ts = require("nvim-treesitter.configs")
  local languages = {"bash", "dockerfile", "fennel", "hocon", "javascript", "json", "git_config", "gitcommit", "gitignore", "go", "html", "java", "lua", "markdown", "scala", "sql", "todotxt", "vim", "vimdoc", "yaml"}
  return ts.setup({ensure_installed = languages, highlight = {enable = true}, indent = {enable = true}})
end
basic = {{"Olical/nfnl", ft = "fennel"}, {"projekt0n/github-nvim-theme", priority = 1000, config = _1_, lazy = false}, {"nvim-treesitter/nvim-treesitter", event = {"BufReadPre", "BufNewFile"}, build = ":TSUpdate", config = _2_}}
local ui_tools
local function _3_()
  local oil = require("oil")
  local config = {default_file_explorer = true, delete_to_trash = true}
  return oil.setup(config)
end
local function _4_()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local config = {defaults = {layout_config = {prompt_position = "bottom", height = 0.6}, layout_strategy = "bottom_pane", mappings = {i = {["<esc>"] = actions.close, ["<C-u>"] = false}}, path_display = {"truncate"}, prompt_prefix = "? ", preview = false, border = false}}
  return telescope.setup(config)
end
local function _5_()
  local gitsigns = require("gitsigns")
  return gitsigns.setup()
end
local function _6_()
  vim.g.undotree_WindowLayout = 4
  vim.g.undotree_SetFocusWhenToggle = 1
  return nil
end
local function _7_()
  if vim.fn.exists("$TMUX") then
    return "VeryLazy"
  else
    return nil
  end
end
local function _9_()
  local nav = require("nvim-tmux-navigation")
  return nav.setup({disabled_when_zoomed = true, keybindings = {left = "<M-h>", down = "<M-j>", up = "<M-k>", right = "<M-l>"}})
end
ui_tools = {{"stevearc/oil.nvim", cmd = "Oil", config = _3_}, {"nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = {"nvim-lua/plenary.nvim"}, config = _4_}, {"lewis6991/gitsigns.nvim", event = {"BufReadPre", "BufNewFile"}, config = _5_}, {"mbbill/undotree", cmd = "UndotreeToggle", config = _6_}, {"alexghergh/nvim-tmux-navigation", event = _7_, config = _9_}}
local text_tools
local function _10_()
  local c = require("Comment")
  return c.setup()
end
local function _11_()
  local surround = require("nvim-surround")
  return surround.setup()
end
text_tools = {{"numToStr/Comment.nvim", keys = "gc", config = _10_}, {"kylechui/nvim-surround", keys = {"cs", "ds", "ys"}, config = _11_}}
local dev_tools
local function _12_()
  local lsp = require("juice.lsp")
  return lsp.setup()
end
local function _13_()
  vim.g.copilot_workspace_folders = {"$WORKSPACE/myshake-backends", "$WORKSPACE/myshake-bc"}
  return nil
end
dev_tools = {{"neovim/nvim-lspconfig", ft = {"go", "scala"}, config = _12_}, {"scalameta/nvim-metals", cmd = "MetalsInit", dependencies = {"nvim-lua/plenary.nvim"}}, {"Olical/conjure", ft = {"clojure", "fennel", "lisp", "scheme"}}, {"github/copilot.vim", cmd = "Copilot", config = _13_}}
local database_tools
local function _14_()
  local function _15_()
    vim.opt.commentstring = "--%s"
    vim.opt.omnifunc = "vim_dadbod_completion#omni"
    return nil
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = {"sql", "mysql"}, callback = _15_})
end
database_tools = {{"kristijanhusak/vim-dadbod-ui", cmd = {"DBUI", "DBUIToggle"}, config = _14_, dependencies = {{"tpope/vim-dadbod", lazy = true}, {"kristijanhusak/vim-dadbod-completion", lazy = true, ft = {"sql", "mysql"}}}}}
local plugins = core.concat(basic, ui_tools, text_tools, dev_tools, database_tools)
return lazy.setup(plugins, opts)
