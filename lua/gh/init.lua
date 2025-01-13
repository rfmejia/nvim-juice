-- [nfnl] Compiled from fnl/gh/init.fnl by https://github.com/Olical/nfnl, do not edit.
local callback
local function _1_(output)
  return vim.print("output", output)
end
callback = _1_
local raw = vim.system({"gh", "issue", "list", "--json", "number,title,body"}, callback)
return vim.print("raw", raw)
