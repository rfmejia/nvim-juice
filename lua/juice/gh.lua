-- [nfnl] Compiled from fnl/juice/gh.fnl by https://github.com/Olical/nfnl, do not edit.
local raw = vim.fn.system({"gh", "issue", "list", "--json", "number,title,body"})
vim.print(issues)
return vim.api.nvim_echo({{"test 1\ntest 2\ntest 3\n"}}, false, {})
