-- [nfnl] fnl/plugin/treesitter.fnl
vim.pack.add({"https://github.com/nvim-treesitter/nvim-treesitter"})
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local nvim_treesitter = autoload("nvim-treesitter")
local ts_languages = {"clojure", "fennel", "java", "json", "lua", "markdown", "scala", "yaml"}
local function setup()
  nvim_treesitter.install(ts_languages)
  vim.treesitter.start()
  vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  return nil
end
vim.api.nvim_create_autocmd("FileType", {pattern = ts_languages, callback = setup})
local function on_update(ev)
  if (((ev.data.kind == "install") or (ev.data.kind == "update")) and (ev.data.spec.name == "nvim-treesitter")) then
    return vim.cmd("TSUpdate")
  else
    return nil
  end
end
return vim.api.nvim_create_autocmd("PackChanged", {desc = "Call TSUpdate upon treesitter update", callback = on_update})
