-- [nfnl] fnl/marksman/init.fnl
local _local_1_ = require("nfnl.module")
local autoload = _local_1_.autoload
local core = autoload("nfnl.core")
--[[ (let [id 1 group "marksman"] (vim.fn.sign_getdefined) (vim.fn.sign_getplaced) (vim.fn.sign_define "test" {:text ">" :texthl "WarningMsg"}) (vim.fn.sign_place 1 "" "test" 0 {:lnum 2}) (vim.fn.sign_unplace "" {:id 1})) ]]
local set_opfunc
do
  local viml_fn = ("\n" .. "func s:set_opfunc(val)" .. "let &opfunc = a:val" .. "endfunc" .. "echon get(function('s:set_opfunc'), 'name')")
  set_opfunc = vim.fn(vim.api.nvim_exec2(viml_fn, true))
end
local function toggle_mark(marker, line_num)
  return "  3. If marker does not exist, add marker+sign"
end
local function init_store()
  vim.g["marksman-marks"] = {}
  vim.g["marksman-opts"] = {}
  return nil
end
local function get_mark(mark)
  if (nil == mark) then
    _G.error("Missing argument mark on /home/rfmejia/.config/nvim/fnl/marksman/init.fnl:28", 2)
  else
  end
  local t_3_ = vim.g.marksman
  if (nil ~= t_3_) then
    t_3_ = t_3_.marks
  else
  end
  if (nil ~= t_3_) then
    t_3_ = t_3_[mark]
  else
  end
  return t_3_
end
local function set_mark(mark, lnum, buf_3f)
  if (nil == buf_3f) then
    _G.error("Missing argument buf? on /home/rfmejia/.config/nvim/fnl/marksman/init.fnl:31", 2)
  else
  end
  if (nil == lnum) then
    _G.error("Missing argument lnum on /home/rfmejia/.config/nvim/fnl/marksman/init.fnl:31", 2)
  else
  end
  if (nil == mark) then
    _G.error("Missing argument mark on /home/rfmejia/.config/nvim/fnl/marksman/init.fnl:31", 2)
  else
  end
  return "Add new or update existing mark at the specified line number and (optional) buffer"
end
local function del_mark(mark)
  if (nil == mark) then
    _G.error("Missing argument mark on /home/rfmejia/.config/nvim/fnl/marksman/init.fnl:34", 2)
  else
  end
  return "Delete a mark"
end
local function sync_vimmarks()
  local vimmarks = vim.fn.getmarklist()
  return vim.print(vimmarks)
end
local function define_signs()
  return vim.fn.sign_define({{name = "marksman-a", text = "a", texthl = "Comment"}, {name = "marksman-b", text = "b", texthl = "Comment"}, {name = "marksman-c", text = "c", texthl = "Comment"}, {name = "marksman-d", text = "d", texthl = "Comment"}, {name = "marksman-e", text = "e", texthl = "Comment"}, {name = "marksman-f", text = "f", texthl = "Comment"}, {name = "marksman-g", text = "g", texthl = "Comment"}, {name = "marksman-h", text = "h", texthl = "Comment"}, {name = "marksman-i", text = "i", texthl = "Comment"}, {name = "marksman-j", text = "j", texthl = "Comment"}, {name = "marksman-k", text = "k", texthl = "Comment"}, {name = "marksman-l", text = "l", texthl = "Comment"}, {name = "marksman-m", text = "m", texthl = "Comment"}, {name = "marksman-n", text = "n", texthl = "Comment"}, {name = "marksman-o", text = "o", texthl = "Comment"}, {name = "marksman-p", text = "p", texthl = "Comment"}, {name = "marksman-q", text = "q", texthl = "Comment"}, {name = "marksman-r", text = "r", texthl = "Comment"}, {name = "marksman-s", text = "s", texthl = "Comment"}, {name = "marksman-t", text = "t", texthl = "Comment"}, {name = "marksman-u", text = "u", texthl = "Comment"}, {name = "marksman-v", text = "v", texthl = "Comment"}, {name = "marksman-w", text = "w", texthl = "Comment"}, {name = "marksman-x", text = "x", texthl = "Comment"}, {name = "marksman-y", text = "y", texthl = "Comment"}, {name = "marksman-z", text = "z", texthl = "Comment"}})
end
--[[ (vim.fn.sign_getplaced 0) (vim.fn.sign_place 1 "marksman" "marksman-a" 4 {:lnum 21}) (vim.fn.sign_unplace "marksman" {:buffer 4 :id 1}) (vim.fn.sign_unplace "*") ]]
local function setup()
  vim.g["marksman-marks"]["a"] = {["sign-id"] = 1, ["buf-num"] = 1}
  print(vim.g.marksman.marks.a)
  init_store()
  local t_10_ = vim.g
  if (nil ~= t_10_) then
    t_10_ = t_10_["marksman-marks"]
  else
  end
  if (nil ~= t_10_) then
    t_10_ = t_10_.a
  else
  end
  return t_10_
end
local function test()
  core["assoc-in"](vim.g, {"marksman"}, {marks = {}})
  table.insert(vim.g.marksman.marks.a, "test")
  local function _14_()
    local t_13_ = vim.g
    if (nil ~= t_13_) then
      t_13_ = t_13_.marksman
    else
    end
    return t_13_
  end
  core["nil?"](_14_())
  local function _17_()
    local t_16_ = vim.g
    if (nil ~= t_16_) then
      t_16_ = t_16_.marksman
    else
    end
    if (nil ~= t_16_) then
      t_16_ = t_16_.marks
    else
    end
    return t_16_
  end
  core["nil?"](_17_())
  local function _21_()
    local t_20_ = vim.g
    if (nil ~= t_20_) then
      t_20_ = t_20_.marksman
    else
    end
    if (nil ~= t_20_) then
      t_20_ = t_20_.marks
    else
    end
    if (nil ~= t_20_) then
      t_20_ = t_20_.a
    else
    end
    return t_20_
  end
  core["nil?"](_21_())
  return core["assoc-in"](vim.g, {"marksman", "marks", "a"}, {["sign-id"] = 1, ["buf-num"] = 1})
end
return {["set-opfunc"] = set_opfunc}
