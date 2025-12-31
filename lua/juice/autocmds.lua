-- [nfnl] fnl/juice/autocmds.fnl
local function _1_()
  --[[ "Remember the cursor position of the last editing" ]]
  vim.api.nvim_create_autocmd("BufReadPost", {pattern = "*", command = "if line(\"'\\\"\") | exe \"'\\\"\" | endif"})
  vim.api.nvim_create_augroup("highlight-group", {})
  --[[ "highlight yanked text" ]]
  local function _2_()
    return vim.hl.on_yank({timeout = 200, on_visual = false})
  end
  vim.api.nvim_create_autocmd("TextYankPost", {group = "highlight-group", pattern = "*", callback = _2_})
  --[[ "highlight TODO, FIXME and Note: keywords" ]]
  vim.api.nvim_create_autocmd({"WinEnter", "VimEnter"}, {group = "highlight-group", pattern = "*", command = ":silent! call matchadd('Todo','TODO\\|FIXME\\|Note:', -1)"})
  vim.api.nvim_create_augroup("terminal-group", {})
  --[[ "remove signcolumn in terminal mode" ]]
  return vim.api.nvim_create_autocmd("TermOpen", {group = "terminal-group", pattern = "*", command = "set signcolumn=no"})
end
return {setup = _1_}
