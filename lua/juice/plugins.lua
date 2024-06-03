-- [nfnl] Compiled from fnl/juice/plugins.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("nfnl.core")
local concat = _local_2_["concat"]
local _local_3_ = autoload("juice.util")
local auto_setup = _local_3_["auto-setup"]
local nmap = _local_3_["nmap"]
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
local database_tools
local function _6_()
  local function _7_()
    return set_opts({commentstring = "-- %s", omnifunc = "vim_dadbod_completion#omni"})
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = {"sql", "mysql"}, callback = _7_})
end
database_tools = {{"kristijanhusak/vim-dadbod-ui", cmd = {"DBUI", "DBUIToggle"}, config = _6_, dependencies = {{"tpope/vim-dadbod", lazy = true}, {"kristijanhusak/vim-dadbod-completion", lazy = true, ft = {"sql", "mysql"}}}}}
local dev_tools
local function _8_()
  return auto_setup("juice.lsp")
end
dev_tools = {{"neovim/nvim-lspconfig", config = _8_}, {"scalameta/nvim-metals", cmd = "MetalsInit", dependencies = {"nvim-lua/plenary.nvim"}}, {"Olical/conjure", ft = {"clojure", "fennel", "lisp", "scheme"}}}
local editing_tools
local function _9_()
  vim.g.undotree_WindowLayout = 4
  vim.g.undotree_SetFocusWhenToggle = 1
  return nil
end
editing_tools = {{"kylechui/nvim-surround", keys = {"cs", "ds", "ys"}, config = true}, {"mbbill/undotree", cmd = "UndotreeToggle", config = _9_}}
local file_tools
local function _10_()
  local telescope = autoload("telescope")
  local actions = autoload("telescope.actions")
  local config = {defaults = {layout_config = {prompt_position = "bottom", height = 0.4}, layout_strategy = "bottom_pane", mappings = {i = {["<esc>"] = actions.close, ["<C-u>"] = false}}, path_display = {"truncate"}, prompt_prefix = "/", prompt_title = "test", border = false, preview = false}}
  return telescope.setup(config)
end
file_tools = {{"stevearc/oil.nvim", cmd = "Oil", config = {default_file_explorer = true, delete_to_trash = true}}, {"nvim-telescope/telescope.nvim", tag = "0.1.6", dependencies = {"nvim-lua/plenary.nvim"}, config = _10_}}
local git_tools = {{"lewis6991/gitsigns.nvim", event = {"BufReadPre", "BufNewFile"}, config = true}, {"NeogitOrg/neogit", dependencies = {{"nvim-lua/plenary.nvim"}, {"sindrets/diffview.nvim"}, {"nvim-telescope/telescope.nvim"}}, config = true}}
local vim_fu = {{"m4xshen/hardtime.nvim", dependencies = {{"MunifTanjim/nui.nvim"}, {"nvim-lua/plenary.nvim"}}, config = true}}
local function setup()
  local lazy = autoload("lazy")
  local plugins = concat(core, database_tools, dev_tools, editing_tools, file_tools, git_tools, vim_fu)
  local opts = {ui = {border = "rounded"}, performance = {rtp = {disabled_plugins = {"rplugin", "tohtml", "tutor", "vimball"}}}}
  return lazy.setup(plugins, opts)
end
return {setup = setup}
