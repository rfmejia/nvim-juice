-- [nfnl] Compiled from fnl/init.fnl by https://github.com/Olical/nfnl, do not edit.
require("juice.bootstrap").setup()
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local core = autoload("nfnl.core")
local statusline = autoload("juice.statusline")
local util = autoload("juice.util")
--[[ "---- LEADER KEYS ----" ]]
util["assoc-in"](vim.g, {mapleader = " ", maplocalleader = ","})
local behavior = {clipboard = "unnamedplus", smartindent = true, shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true, mouse = "", shortmess = "filnxtToOF", undolevels = 5000, undofile = true, foldenable = false}
local visual = {number = true, relativenumber = true, signcolumn = "yes:1", cursorline = true, splitbelow = true, splitright = true, linebreak = true, laststatus = 3, statusline = statusline.build({}), wrap = false}
--[[ "---- SEARCH OPTIONS ----" ]]
local search = {hlsearch = true, incsearch = true, ignorecase = true, smartcase = true, wrapscan = false}
--[[ "---- COMPLETION ----" ]]
local completion = {complete = ".,w,b,u,t,kspell", completeopt = "menu,menuone,noselect,noinsert", path = ".,,", wildmode = "lastused,longest,full", wildignore = "*/.git/*,*/.ammonite/*,*/.bloop/*,*/.metals/*,*/node_modules/*,*/build/*,*/target/*,*.class", wildignorecase = true, wildoptions = "pum"}
util["assoc-in"](vim.opt, behavior, visual, search, completion)
--[[ "use ripgrep as grepprg if available" ]]
if util["executable?"]("rg") then
  util["assoc-in"](vim.opt, {grepprg = "rg --smart-case --hidden --follow --no-heading --vimgrep", grepformat = "%f:%l:%c:%m,%f:%l:%m"})
else
end
--[[ "---- FILETYPES ----" ]]
vim.filetype.add({extension = {edn = "clojure", sbt = "scala", sc = "scala", txt = "text"}, filename = {Jenkinsfile = "groovy", ["tmux.conf"] = "tmux"}})
--[[ "---- AUTOCMDS ----" ]]
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
vim.api.nvim_create_autocmd("TermOpen", {group = "terminal-group", pattern = "*", command = "set signcolumn=no"})
return util["auto-setup"]("juice.plugins", "juice.mappings", "juice.colorscheme", "juice.git", "juice.tmux-nav", "juice.whitespace")
