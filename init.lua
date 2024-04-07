-- [nfnl] Compiled from fnl/init.fnl by https://github.com/Olical/nfnl, do not edit.
vim.opt.hidden = true
vim.opt.autoread = true
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.foldenable = false
vim.opt.backspace = "indent,eol,start"
vim.opt.history = 10000
vim.opt.ttyfast = true
vim.opt.ttimeoutlen = 50
vim.opt.mouse = ""
vim.opt.shortmess = "filnxtToOF"
vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes:1"
vim.opt.cursorline = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.showcmd = true
vim.opt.laststatus = 3
vim.opt.switchbuf = "uselast"
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wrapscan = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.complete = ".,w,b,u,t,kspell"
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
vim.opt.path = ".,,"
vim.cmd("filetype plugin on")
vim.filetype.add({extension = {[{"sbt", "sc"}] = "scala", [{"text", "txt"}] = "text"}, filename = {Jenkinsfile = "groovy", ["tmux.conf"] = "tmux"}})
require("juice.plugins")
require("juice.mappings")
require("juice.autocmds")
do
  local u = require("juice.util")
  if u["has?"]("syntax") then
    vim.cmd("syntax enable")
  else
  end
  if u["has?"]("clipboard") then
    vim.opt.clipboard = "unnamedplus"
  else
  end
  if u["has?"]("persistent_undo") then
    vim.opt.undolevels = 5000
    vim.opt.undofile = true
  else
  end
  if u["has?"]("wildmenu") then
    vim.opt.wildmenu = true
    vim.opt.wildmode = "lastused,longest,full"
    vim.opt.wildignore = "*/.git/*,*/.ammonite/*,*/.bloop/*,*/.metals/*,*/node_modules/*,*/build/*,*/target/*,*.class"
    vim.opt.wildignorecase = true
    vim.opt.wildoptions = "pum"
  else
  end
  if u["executable?"]("rg") then
    vim.opt.grepprg = "rg\\ --smart-case\\ --hidden\\ --follow\\ --no-heading\\ --vimgrep"
    vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  else
  end
end
local sl = require("juice.statusline")
vim.opt.statusline = sl["build-statusline"]({})
return nil
