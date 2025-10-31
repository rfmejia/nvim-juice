-- [nfnl] fnl/juice/plugins.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local util = autoload("juice.util")
local mappings = autoload("juice.mappings")
local core_tools
local function _2_()
  vim.g["conjure#client#fennel#aniseed#deprecation_warning"] = false
  return nil
end
local function _3_()
  local config = {highlight = {enable = true}, indent = {enable = true}}
  return util.call("nvim-treesitter.configs", "setup", config)
end
local function _4_()
  local opts = {default_file_explorer = true, delete_to_trash = true, skip_confirm_for_simple_edits = true, view_options = {show_hidden = true}}
  util.call("oil", "setup", opts)
  return util["set-keys"](mappings["oil-maps"])
end
core_tools = {{"Olical/nfnl", ft = "fennel", config = _2_}, {"nvim-treesitter/nvim-treesitter", event = {"BufReadPre", "BufNewFile"}, build = ":TSUpdate", config = _3_}, {"stevearc/oil.nvim", config = _4_}}
local database_tools
do
  local sql_filetypes = {"sql", "mysql", "pgsql"}
  local function _5_()
    local function _6_()
      return util["set-keys"](mappings["dadbod-maps"])
    end
    return vim.api.nvim_create_autocmd("FileType", {pattern = sql_filetypes, callback = _6_})
  end
  database_tools = {{"tpope/vim-dadbod", ft = sql_filetypes, config = _5_, dependencies = {{"kristijanhusak/vim-dadbod-completion", lazy = true}}}}
end
local dev_tools
do
  local lisp_languages = {"clojure", "fennel"}
  local function _7_()
    return core["merge!"](vim.g, {["conjure#result#register"] = "*", ["conjure#mapping#doc_word"] = "gk", ["conjure#log#botright"] = true})
  end
  dev_tools = {{"scalameta/nvim-metals", ft = "scala"}, {"Olical/conjure", branch = "main", ft = lisp_languages, config = _7_}, {"julienvincent/nvim-paredit", ft = lisp_languages, opts = {use_default_keys = true, indent = {enabled = true}}, dependencies = {{"nvim-treesitter/nvim-treesitter"}}}}
end
local editing_tools = {{"kylechui/nvim-surround", keys = {"cs", "ds", "ys"}, config = true}, {"windwp/nvim-autopairs", event = "InsertEnter", opts = {enable_check_bracket_line = false}}}
local git_tools
local function _8_()
  util["call-setup"]("gitsigns")
  util["set-keys"](mappings["gitsigns-maps"])
  return util.call("gitsigns", "toggle_signs")
end
git_tools = {{"lewis6991/gitsigns.nvim", keys = "<localleader>gt", config = _8_}}
--[[ let llm-tools [{1 "github/copilot.vim" :cmd "Copilot" :config (fn [] (util.set-keys mappings.copilot-maps) (set vim.g.copilot_workspace_folders (core.distinct (core.concat vim.g.copilot_workspace_folders [(vim.fn.getcwd)]))))} {1 "olimorris/codecompanion.nvim" :cmd ["CodeCompanion" "CodeCompanionCmd" "CodeCompanionChat" "CodeCompanionActions"] :config (hashfn (let [extensions {:mcphub {:callback "mcphub.extensions.codecompanion" :opts {:make_slash_commands true :make_vars true :show_result_in_chat true}}}] (util.call-setup "codecompanion") (util.call "codecompanion" "setup" {:extensions extensions}))) :dependencies ["nvim-lua/plenary.nvim" "nvim-treesitter/nvim-treesitter" {1 "ravitemer/mcphub.nvim" :build "npm install -g mcp-hub@latest" :config (hashfn (util.call-setup "mcphub"))}] :opts {}}] ]]
local function setup()
  local plugins = core.concat(core_tools, database_tools, dev_tools, editing_tools, git_tools)
  local opts = {ui = {border = "rounded"}, performance = {rtp = {disabled_plugins = {"rplugin", "tohtml", "tutor", "vimball"}}}}
  return util.call("lazy", "setup", plugins, opts)
end
return {setup = setup}
