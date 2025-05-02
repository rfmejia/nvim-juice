-- [nfnl] fnl/juice/options.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local statusline = autoload("juice.statusline")
local util = autoload("juice.util")
local core = autoload("nfnl.core")
--[[ "---- GENERAL OPTIONS ----" ]]
local map_leaders = {mapleader = " ", maplocalleader = ","}
local behavior = {clipboard = "unnamedplus", smartindent = true, shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true, mouse = "", shortmess = "filnxtToOF", undolevels = 5000, undofile = true, foldenable = false}
local visual = {signcolumn = "yes:1", cursorline = true, splitbelow = true, splitright = true, linebreak = true, laststatus = 3, statusline = statusline.build({}), number = false, relativenumber = false, wrap = false}
--[[ "---- SEARCH OPTIONS ----" ]]
local search = {hlsearch = true, incsearch = true, ignorecase = true, smartcase = true, wrapscan = false}
--[[ "---- COMPLETION ----" ]]
local completion = {complete = {".", "w", "b", "u", "t", "kspell"}, completeopt = {"menuone", "popup", "noinsert"}, path = {".", "", "**"}, wildmode = {"lastused", "full"}, wildignorecase = true, wildoptions = {"fuzzy", "pum"}}
--[[ "use ripgrep as grepprg if available" ]]
local grep_options
if util["executable?"]("rg") then
  grep_options = {grepprg = "rg --smart-case --hidden --follow --no-heading --vimgrep", grepformat = "%f:%l:%c:%m,%f:%l:%m"}
else
  grep_options = nil
end
--[[ "---- FILETYPES ----" ]]
local filetypes = {extension = {edn = "clojure", mill = "scala", mysql = "sql", pgsql = "sql", sbt = "scala", sc = "scala", txt = "text"}, filename = {[".envrc"] = "bash", Jenkinsfile = "groovy", ["tmux.conf"] = "tmux"}}
--[[ "---- AUTOCMDS ----" ]]
local function set_autocmds()
  --[[ "Remember the cursor position of the last editing" ]]
  vim.api.nvim_create_autocmd("BufReadPost", {pattern = "*", command = "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})
  vim.api.nvim_create_augroup("highlight-group", {})
  --[[ "highlight yanked text" ]]
  local function _3_()
    return vim.highlight.on_yank({timeout = 200, on_visual = false})
  end
  vim.api.nvim_create_autocmd("TextYankPost", {group = "highlight-group", pattern = "*", callback = _3_})
  --[[ "highlight TODO, FIXME and Note: keywords" ]]
  vim.api.nvim_create_autocmd({"WinEnter", "VimEnter"}, {group = "highlight-group", pattern = "*", command = ":silent! call matchadd('Todo','TODO\\|FIXME\\|Note:', -1)"})
  vim.api.nvim_create_augroup("terminal-group", {})
  --[[ "remove signcolumn in terminal mode" ]]
  return vim.api.nvim_create_autocmd("TermOpen", {group = "terminal-group", pattern = "*", command = "set signcolumn=no"})
end
local function setup()
  core["merge!"](vim.g, map_leaders)
  core["merge!"](vim.opt, behavior, visual, search, completion, grep_options)
  vim.filetype.add(filetypes)
  return set_autocmds()
end
return {setup = setup}
