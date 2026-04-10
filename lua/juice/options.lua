-- [nfnl] fnl/juice/options.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local statusline = autoload("juice.statusline")
local util = autoload("juice.util")
local core = autoload("nfnl.core")
--[[ "---- GENERAL OPTIONS ----" ]]
local map_leaders = {mapleader = " ", maplocalleader = ","}
local behavior = {clipboard = "unnamedplus", smartindent = true, shiftwidth = 2, tabstop = 2, softtabstop = 2, expandtab = true, mouse = "", shortmess = "filnxtToOF", undolevels = 5000, undofile = true, virtualedit = "block", foldenable = false}
local visual = {signcolumn = "no", cursorline = true, splitbelow = true, splitright = true, linebreak = true, laststatus = 3, statusline = statusline.build({}), number = false, relativenumber = false, wrap = false}
--[[ "---- SEARCH OPTIONS ----" ]]
local search = {hlsearch = true, incsearch = true, ignorecase = true, smartcase = true, wrapscan = false}
--[[ "---- COMPLETION ----" ]]
local completion = {autocomplete = true, autocompletedelay = 500, complete = {".", "o", "w", "b", "u", "t", "kspell"}, completeopt = {"menuone", "popup", "fuzzy", "noselect", "preview"}, path = {".", "", "**"}, wildmode = {"lastused", "full"}, wildignorecase = true, wildoptions = {"fuzzy", "pum"}, winborder = "rounded", pumborder = "rounded"}
--[[ "use ripgrep as grepprg if available" ]]
local grep_options
if util["executable?"]("rg") then
  grep_options = {grepprg = "rg --smart-case --hidden --follow --no-heading --vimgrep", grepformat = "%f:%l:%c:%m,%f:%l:%m"}
else
  grep_options = nil
end
local function _3_()
  autoload("vim._core.ui2").enable()
  core["merge!"](vim.g, map_leaders)
  return core["merge!"](vim.opt, behavior, visual, search, completion, grep_options)
end
return {setup = _3_}
