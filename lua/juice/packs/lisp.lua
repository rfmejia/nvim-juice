-- [nfnl] fnl/juice/packs/lisp.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
local pack = autoload("pack")
local util = autoload("juice.util")
local function _2_()
  pack.add({{src = "https://github.com/Olical/conjure"}, {src = "https://github.com/julienvincent/nvim-paredit"}})
  local function _3_()
    util.call("nvim-paredit", "setup", {use_default_keys = true, indent = {enabled = true}})
    return core["merge!"](vim.g, {["conjure#result#register"] = "*", ["conjure#mapping#doc_word"] = "gk", ["conjure#log#botright"] = true})
  end
  return pack["load-on-event"]({"conjure", "nvim-paredit"}, "FileType", {pattern = {"clojure", "fennel"}, callback = _3_})
end
return {setup = _2_}
