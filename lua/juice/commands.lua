-- [nfnl] fnl/juice/commands.fnl
local function _1_()
  return vim.api.nvim_create_user_command("ClipFilename", "let @+ = getreg('%')", {desc = "copy current file path to clipboard"})
end
return {setup = _1_}
