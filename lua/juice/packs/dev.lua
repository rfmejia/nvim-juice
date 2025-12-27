-- [nfnl] fnl/juice/packs/dev.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local pack = autoload("pack")
local util = autoload("juice.util")
local dadbod_maps = {{"n", "<localleader>d;", ":DB g:db ", {desc = "[dadbod] run an sql statement in command mode", noremap = true, buffer = true}}, {"n", "<localleader>dd", ":.DB g:db<cr>", {desc = "[dadbod] run line as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>dp", "vip:DB g:db<cr>", {desc = "[dadbod] run paragraph as an sql statement", noremap = true, buffer = true}}, {"n", "<localleader>db", ":%DB g:db<cr>", {desc = "[dadbod] run buffer as sql statements", noremap = true, buffer = true}}}
local gitsigns_maps
do
  local nav
  local function _2_()
    return util.call("gitsigns", "nav_hunk", "next", {preview = true, wrap = false})
  end
  local function _3_()
    return util.call("gitsigns", "nav_hunk", "prev", {preview = true, wrap = false})
  end
  nav = {{"n", "]g", _2_, {desc = "[gitsigns] jump to next git hunk"}}, {"n", "[g", _3_, {desc = "[gitsigns] jump to previous git hunk"}}}
  local staging
  local function _4_()
    return util.call("gitsigns", "stage_hunk")
  end
  local function _5_()
    return util.call("gitsigns", "reset_hunk")
  end
  local function _6_()
    return util.call("gitsigns", "stage_buffer")
  end
  local function _7_()
    return util.call("gitsigns", "reset_buffer")
  end
  local function _8_()
    local function _9_()
      return util.call("gitsigns", "stage_hunk", {[vim.fn.line(".")] = vim.fn.line("v")})
    end
    return _9_()
  end
  local function _10_()
    return util.call("gitsigns", "reset_hunk", {[vim.fn.line(".")] = vim.fn.line("v")})
  end
  staging = {{"n", "<localleader>gs", _4_, {desc = "[gitsigns] (g)it (s)tage hunk"}}, {"n", "<localleader>gr", _5_, {desc = "(g)it (r)eset hunk"}}, {"n", "<localleader>gS", _6_, {desc = "[gitsigns] (g)it (S)tage buffer"}}, {"n", "<localleader>gR", _7_, {desc = "[gitsigns] (g)it (R)eset buffer"}}, {"v", "<localleader>gs", _8_, {desc = "[gitsigns] (g)it (s)tage hunk"}}, {"v", "<localleader>gr", _10_, {desc = "[gitsigns] (g)it (r)eset hunk"}}}
  local blame
  local function _11_()
    return util.call("gitsigns", "blame_line", {full = true})
  end
  local function _12_()
    return util.call("gitsigns", "toggle_current_line_blame")
  end
  blame = {{"n", "<localleader>gb", _11_, {desc = "[gitsigns] (g)it show line (b)lame"}}, {"n", "<localleader>gB", _12_, {desc = "[gitsigns] (g)it toggle current line (B)lame"}}}
  local view
  local function _13_()
    return util.call("gitsigns", "toggle_signs")
  end
  local function _14_()
    return util.call("gitsigns", "preview_hunk")
  end
  local function _15_()
    return util.call("gitsigns", "preview_hunk_inline")
  end
  local function _16_()
    return util.call("gitsigns", "diffthis")
  end
  view = {{"n", "<localleader>gt", _13_, {desc = "[gitsigns] toggle sign visibility"}}, {"n", "<localleader>gp", _14_, {desc = "[gitsigns] (g)it (p)review hunk"}}, {"n", "<localleader>gi", _15_, {desc = "[gitsigns] (g)it toggle (D)eleted hunks"}}, {"n", "<localleader>gd", _16_, {desc = "[gitsigns] (g)it show (d)iff"}}}
  local list
  local function _17_()
    return util.call("gitsigns", "setloclist")
  end
  local function _18_()
    return util.call("gitsigns", "setqflist", "all")
  end
  list = {{"n", "<localleader>gl", _17_, {desc = "[gitsigns] show buffer (g)it hunks in (l)oclist"}}, {"n", "<localleader>gc", _18_, {desc = "[gitsigns] show all (g)it hunks in qui(c)kfix list"}}}
  gitsigns_maps = core.concat(nav, staging, blame, view, list)
end
local function _19_()
  pack.add({"https://github.com/tpope/vim-dadbod", "https://github.com/kristijanhusak/vim-dadbod-completion", "https://github.com/lewis6991/gitsigns.nvim"})
  local function _20_()
    return util["set-keys"](dadbod_maps)
  end
  pack["load-on-event"]({"vim-dadbod", "vim-dadbod-completion"}, "FileType", {pattern = {"sql", "mysql", "pgsql"}, callback = _20_})
  local function _21_()
    util["call-setup"]("gitsigns")
    util["set-keys"](gitsigns_maps)
    return util.call("gitsigns", "toggle_signs")
  end
  return pack["load-on-keymap"]("gitsigns.nvim", "<localleader>gt", _21_)
end
return {setup = _19_}
