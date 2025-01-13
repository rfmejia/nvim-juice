-- [nfnl] Compiled from fnl/marksman/init.fnl by https://github.com/Olical/nfnl, do not edit.
--[[ (let [id 1 group "marksman"] (vim.fn.sign_getdefined) (vim.fn.sign_getplaced) (vim.fn.sign_define "test" {:text ">" :texthl "WarningMsg"}) (vim.fn.sign_place 1 "" "test" 0 {:lnum 2}) (vim.fn.sign_unplace "" {:id 1})) ]]
local set_opfunc
do
  local viml_fn = mkstring("\n", "func s:set_opfunc(val)", "let &opfunc = a:val", "endfunc", "echon get(function('s:set_opfunc'), 'name')")
  set_opfunc = vim.fn(vim.api.nvim_exec2(viml_fn, true))
end
return {["set-opfunc"] = set_opfunc}
