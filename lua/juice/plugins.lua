-- [nfnl] Compiled from fnl/juice/plugins.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local util = autoload("juice.util")
local mappings = autoload("juice.mappings")
local core_tools
local function _2_()
  local ts = autoload("nvim-treesitter.configs")
  local languages = {"bash", "clojure", "fennel", "gitcommit", "go", "hocon", "java", "json", "lua", "markdown", "scala", "sql", "vimdoc", "yaml"}
  local config = {ensure_installed = languages, highlight = {enable = true}, indent = {enable = true}}
  return ts.setup(config)
end
core_tools = {{"Olical/nfnl", ft = "fennel"}, {"nvim-treesitter/nvim-treesitter", event = {"BufReadPre", "BufNewFile"}, build = ":TSUpdate", config = _2_}}
local database_tools
local function _3_()
  local function _4_()
    return util["assoc-in"](vim.opt, {commentstring = "-- %s", omnifunc = "vim_dadbod_completion#omni"})
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = {"sql", "mysql"}, callback = _4_})
end
database_tools = {{"kristijanhusak/vim-dadbod-ui", cmd = {"DBUI", "DBUIToggle"}, config = _3_, dependencies = {{"tpope/vim-dadbod", lazy = true}, {"kristijanhusak/vim-dadbod-completion", lazy = true, ft = {"sql", "mysql"}}}}}
local dev_tools
local function _5_()
  return util["auto-setup"]("juice.lsp")
end
dev_tools = {{"neovim/nvim-lspconfig", ft = {"clojure", "java", "go", "scala"}, config = _5_}, {"scalameta/nvim-metals", cmd = "MetalsInit", dependencies = {"nvim-lua/plenary.nvim"}}}
local lisp_tools
do
  local languages = {"clojure", "fennel"}
  local function _6_()
    return util["assoc-in"](vim.g, {["conjure#result#register"] = "*", ["conjure#mapping#doc_word"] = "gk", ["conjure#log#botright"] = true})
  end
  lisp_tools = {{"Olical/conjure", ft = languages, config = _6_}, {"julienvincent/nvim-paredit", ft = languages, opts = {use_default_keys = true, indent = {enabled = true}}}}
end
local editing_tools
local function _7_()
  return util["assoc-in"](vim.g, {undotree_WindowLayout = 4, undotree_SetFocusWhenToggle = 1})
end
editing_tools = {{"kylechui/nvim-surround", keys = {"cs", "ds", "ys"}, config = true}, {"windwp/nvim-autopairs", event = "InsertEnter", opts = {enable_check_bracket_line = false}}, {"mbbill/undotree", cmd = "UndotreeToggle", config = _7_}}
local file_tools
local function _8_()
  local oil = autoload("oil")
  local opts = {default_file_explorer = true, delete_to_trash = true, skip_confirm_for_simple_edits = true, view_options = {show_hidden = true}}
  oil.setup(opts)
  return mappings["oil-maps"]()
end
local function _9_()
  local telescope = autoload("telescope")
  local actions = autoload("telescope.actions")
  local opts = {defaults = {layout_config = {prompt_position = "bottom", height = 0.4}, layout_strategy = "bottom_pane", mappings = {i = {["<esc>"] = actions.close, ["<C-u>"] = false}}, path_display = {"truncate"}, prompt_prefix = "/", prompt_title = "test", border = false, preview = false}}
  telescope.setup(opts)
  return mappings["telescope-maps"]()
end
file_tools = {{"stevearc/oil.nvim", cmd = "Oil", keys = "<leader>e", config = _8_}, {"nvim-telescope/telescope.nvim", tag = "0.1.6", keys = {"<leader>f", "<leader>p", "<leader>g", "<leader>k"}, cmd = "Telescope", dependencies = {"nvim-lua/plenary.nvim"}, config = _9_}}
local git_tools
local function _10_()
  local gitsigns = autoload("gitsigns")
  gitsigns.setup()
  return mappings["gitsigns-maps"]()
end
local function _11_()
  local neogit = autoload("neogit")
  neogit.setup()
  return mappings["neogit-maps"]()
end
git_tools = {{"lewis6991/gitsigns.nvim", event = {"BufReadPre", "BufNewFile"}, config = _10_}, {"NeogitOrg/neogit", cmd = "Neogit", keys = "<leader>og", dependencies = {{"nvim-lua/plenary.nvim"}, {"sindrets/diffview.nvim"}, {"nvim-telescope/telescope.nvim"}}, config = _11_}}
local function setup()
  local lazy = autoload("lazy")
  local plugins = core.concat(core_tools, database_tools, dev_tools, editing_tools, file_tools, git_tools, lisp_tools)
  local opts = {ui = {border = "rounded"}, performance = {rtp = {disabled_plugins = {"rplugin", "tohtml", "tutor", "vimball"}}}}
  return lazy.setup(plugins, opts)
end
return {setup = setup}
