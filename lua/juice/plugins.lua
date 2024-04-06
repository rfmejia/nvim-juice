-- [nfnl] Compiled from lua/juice/plugins.fnl by https://github.com/Olical/nfnl, do not edit.
local lazy = require("lazy")
local opts = {ui = {border = "rounded"}, performance = {rtp = {disabled_plugins = {"rplugin", "tohtml", "tutor", "vimball"}}}}
local plugins
local function _1_()
  local c = require("juice.colors")
  return c.setup()
end
local function _2_()
  local oil = require("oil")
  return oil.setup()
end
local function _3_()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local config = {defaults = {mappings = {i = {["<esc>"] = actions.close}}}}
  return telescope.setup(config)
end
local function _4_()
  local gitsigns = require("gitsigns")
  return gitsigns.setup()
end
local function _5_()
  local lsp = require("juice.lsp")
  return lsp.setup()
end
local function _6_()
  if vim.fn.exists("$TMUX") then
    return "VeryLazy"
  else
    return nil
  end
end
local function _8_()
  local nav = require("nvim-tmux-navigation")
  return nav.setup({disabled_when_zoomed = true, keybindings = {left = "<M-h>", down = "<M-j>", up = "<M-k>", right = "<M-l>"}})
end
local function _9_()
  local ts = require("nvim-treesitter.configs")
  local languages = {"bash", "dockerfile", "fennel", "hocon", "javascript", "json", "git_config", "gitcommit", "gitignore", "go", "html", "java", "lua", "markdown", "scala", "sql", "todotxt", "vim", "vimdoc", "yaml"}
  return ts.setup({ensure_installed = languages, highlight = {enable = true}, indent = {enable = true}})
end
local function _10_()
  vim.g.undotree_WindowLayout = 4
  vim.g.undotree_SetFocusWhenToggle = 1
  return nil
end
local function _11_()
  local c = require("Comment")
  return c.setup()
end
local function _12_()
  local surround = require("nvim-surround")
  return surround.setup()
end
local function _13_()
  vim.g.copilot_workspace_folders = {"$WORKSPACE/myshake-backends", "$WORKSPACE/myshake-bc"}
  return nil
end
local function _14_()
  local function _15_()
    vim.opt.commentstring = "--%s"
    vim.opt.omnifunc = "vim_dadbod_completion#omni"
    return nil
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = {"sql", "mysql"}, callback = _15_})
end
plugins = {{"projekt0n/github-nvim-theme", priority = 1000, config = _1_, lazy = false}, {"Olical/nfnl", ft = "fennel"}, {"Olical/conjure", ft = {"clojure", "fennel", "lisp", "scheme"}}, {"stevearc/oil.nvim", cmd = "Oil", config = _2_}, {"nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = {"nvim-lua/plenary.nvim"}, config = _3_}, {"lewis6991/gitsigns.nvim", event = {"BufReadPre", "BufNewFile"}, config = _4_}, {"neovim/nvim-lspconfig", ft = {"go", "scala"}, config = _5_}, {"scalameta/nvim-metals", cmd = "MetalsInit", dependencies = {"nvim-lua/plenary.nvim"}}, {"alexghergh/nvim-tmux-navigation", event = _6_, config = _8_}, {"nvim-treesitter/nvim-treesitter", event = {"BufReadPre", "BufNewFile"}, build = ":TSUpdate", config = _9_}, {"mbbill/undotree", cmd = "UndotreeToggle", config = _10_}, {"numToStr/Comment.nvim", keys = "gc", config = _11_}, {"kylechui/nvim-surround", keys = {"cs", "ds", "ys"}, config = _12_}, {"github/copilot.vim", cmd = "Copilot", config = _13_}, {"kristijanhusak/vim-dadbod-ui", cmd = {"DBUI", "DBUIToggle"}, config = _14_, dependencies = {{"tpope/vim-dadbod", lazy = true}, {"kristijanhusak/vim-dadbod-completion", lazy = true, ft = {"sql", "mysql"}}}}}
return lazy.setup(plugins, opts)
