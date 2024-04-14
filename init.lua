-- [nfnl] Compiled from fnl/init.fnl by https://github.com/Olical/nfnl, do not edit.
local _local_1_ = require("nfnl.module")
local autoload = _local_1_["autoload"]
local _local_2_ = autoload("juice.statusline")
local build_statusline = _local_2_["build-statusline"]
local _local_3_ = autoload("juice.util")
local auto_setup = _local_3_["auto-setup"]
local executable_3f = _local_3_["executable?"]
local set_opts = _local_3_["set-opts"]
--[[ "---- LEADER KEYS ----" ]]
vim.g.mapleader = " "
vim.g.maplocalleader = ","
--[[ "---- BEHAVIOR ----" ]]
set_opts({clipboard = "unnamedplus", smartindent = true, shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true, mouse = "", shortmess = "filnxtToOF", undolevels = 5000, undofile = true, foldenable = false})
--[[ "---- VISUAL ----" ]]
set_opts({number = true, relativenumber = true, signcolumn = "yes:1", cursorline = true, splitbelow = true, splitright = true, linebreak = true, laststatus = 3, statusline = build_statusline({}), wrap = false})
--[[ "---- SEARCH OPTIONS ----" ]]
set_opts({hlsearch = true, incsearch = true, ignorecase = true, smartcase = true, wrapscan = false})
--[[ "---- FILETYPES ----" ]]
vim.filetype.add({extension = {sbt = "scala", sc = "scala", txt = "text"}, filename = {Jenkinsfile = "groovy", ["tmux.conf"] = "tmux"}})
--[[ "---- COMPLETION ----" ]]
set_opts({complete = ".,w,b,u,t,kspell", completeopt = "menu,menuone,noselect,noinsert", path = ".,,", wildmode = "lastused,longest,full", wildignore = "*/.git/*,*/.ammonite/*,*/.bloop/*,*/.metals/*,*/node_modules/*,*/build/*,*/target/*,*.class", wildignorecase = true, wildoptions = "pum"})
--[[ "use ripgrep if available" ]]
if executable_3f("rg") then
  set_opts({grepprg = "rg --smart-case --hidden --follow --no-heading --vimgrep", grepformat = "%f:%l:%c:%m,%f:%l:%m"})
else
end
auto_setup("juice.plugins")
auto_setup("juice.mappings")
return auto_setup("juice.autocmds")
