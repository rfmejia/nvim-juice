-- [nfnl] fnl/gh/init.fnl
local callback
local function _1_(output)
  return vim.print("output", output)
end
callback = _1_
local raw = vim.system({"gh", "issue", "list", "--json", "number,title,body"}, callback)
return vim.print("raw", raw)
