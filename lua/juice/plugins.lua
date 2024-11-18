-- [nfnl] Compiled from fnl/juice/plugins.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local util = autoload("juice.util")
local mappings = autoload("juice.mappings")
local core_tools
local function _2_()
  vim.g["conjure#client#fennel#aniseed#deprecation_warning"] = false
  return nil
end
local function _3_()
  local languages = {"bash", "clojure", "fennel", "gitcommit", "go", "hocon", "java", "json", "lua", "markdown", "scala", "sql", "vimdoc", "yaml"}
  local config = {ensure_installed = languages, highlight = {enable = true}, indent = {enable = true}}
  return util.call("nvim-treesitter.configs", "setup", config)
end
core_tools = {{"Olical/nfnl", ft = "fennel", config = _2_}, {"nvim-treesitter/nvim-treesitter", event = {"BufReadPre", "BufNewFile"}, build = ":TSUpdate", config = _3_}}
local database_tools
local function _4_()
  local function _5_()
    return util["set-keys"](mappings["dadbod-maps"])
  end
  return vim.api.nvim_create_autocmd("FileType", {pattern = {"sql", "mysql"}, callback = _5_})
end
database_tools = {{"tpope/vim-dadbod", ft = {"sql", "mysql"}, config = _4_, dependencies = {{"kristijanhusak/vim-dadbod-completion", lazy = true}}}}
local dev_tools
local function _6_()
  return util["call-setup"]("juice.lsp")
end
dev_tools = {{"neovim/nvim-lspconfig", ft = {"clojure", "java", "go", "scala"}, config = _6_}, {"scalameta/nvim-metals", cmd = "MetalsInit", dependencies = {"nvim-lua/plenary.nvim"}}}
local lisp_tools
do
  local languages = {"clojure", "fennel"}
  local function _7_()
    return util["assoc-in"](vim.g, {["conjure#result#register"] = "*", ["conjure#mapping#doc_word"] = "gk", ["conjure#log#botright"] = true})
  end
  lisp_tools = {{"Olical/conjure", branch = "main", ft = languages, config = _7_}, {"julienvincent/nvim-paredit", ft = languages, opts = {use_default_keys = true, indent = {enabled = true}}}}
end
local editing_tools = {{"kylechui/nvim-surround", keys = {"cs", "ds", "ys"}, config = true}, {"windwp/nvim-autopairs", event = "InsertEnter", opts = {enable_check_bracket_line = false}}}
local file_tools
local function _8_()
  local opts = {default_file_explorer = true, delete_to_trash = true, skip_confirm_for_simple_edits = true, view_options = {show_hidden = true}}
  util.call("oil", "setup", opts)
  return util["set-keys"](mappings["oil-maps"])
end
file_tools = {{"stevearc/oil.nvim", cmd = "Oil", keys = "<leader>e", config = _8_}}
local git_tools
local function _9_()
  util["call-setup"]("gitsigns")
  return util["set-keys"](mappings["gitsigns-maps"])
end
git_tools = {{"lewis6991/gitsigns.nvim", event = {"BufReadPre", "BufNewFile"}, config = _9_}}
local function setup()
  local plugins = core.concat(core_tools, database_tools, dev_tools, editing_tools, file_tools, git_tools, lisp_tools)
  local opts = {ui = {border = "rounded"}, performance = {rtp = {disabled_plugins = {"rplugin", "tohtml", "tutor", "vimball"}}}}
  return util.call("lazy", "setup", plugins, opts)
end
return {setup = setup}
