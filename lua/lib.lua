-- [nfnl] Compiled from fnl/lib.fnl by https://github.com/Olical/nfnl, do not edit.
local function nil_3f(elem)
  return (nil == elem)
end
local function number_3f(elem)
  return ("number" == type(elem))
end
local function boolean_3f(elem)
  return ("boolean" == type(elem))
end
local function string_3f(elem)
  return ("string" == type(elem))
end
local function function_3f(elem)
  return ("function" == type(elem))
end
local function table_3f(elem)
  return ("table" == type(elem))
end
local function empty_3f(seq)
  return (nil_3f(seq) or nil_3f(next(seq)))
end
local function non_empty_3f(seq)
  return not empty_3f(seq)
end
local function sequence_3f(elem)
  return (table_3f(elem) and (empty_3f(elem) or (nil ~= elem[1])))
end
sequence_3f({"a", "b", "c"})
sequence_3f({a = 1, b = 2, c = 3})
local function head(seq)
  if non_empty_3f(seq) then
    return seq[1]
  else
    return nil
  end
end
local function tail(seq)
  if non_empty_3f(seq) then
    local acc = {}
    for i = 2, #seq do
      acc[(#acc + 1)] = seq[i]
    end
    return acc
  else
    return nil
  end
end
local function keys(tbl)
  if (empty_3f(tbl) or not table_3f(tbl)) then
    return {}
  else
    local tbl_109_auto = {}
    local i_110_auto = 0
    for k, _ in pairs(tbl) do
      local val_111_auto = k
      if (nil ~= val_111_auto) then
        i_110_auto = (i_110_auto + 1)
        tbl_109_auto[i_110_auto] = val_111_auto
      else
      end
    end
    return tbl_109_auto
  end
end
local function _3dtable(...)
end
local function _3ditable(...)
end
--[[ "use =table and =itable to check" (assert (= [] (keys nil) (keys []) (keys {}))) (assert (= ["a" "b" "c"] (keys {:a 1 :b 2 :c 3}))) ]]
local function fold_left(reduce_fn, zero, seq)
  if empty_3f(seq) then
    return zero
  else
    return fold_left(reduce_fn, reduce_fn(zero, head(seq)), tail(seq))
  end
end
local function _6_(_241, _242)
  return (_241 + _242)
end
local function _7_(_241, _242)
  return (_241 * _242)
end
local function _8_(_241, _242)
  return (_241 and ((_242 % 2) == 0))
end
assert(assert((6 == fold_left(_6_, 0, {1, 2, 3}))), assert((125 == fold_left(_7_, 1, {5, 5, 5}))), assert((false == fold_left(_8_, true, {2, 4, 6, 7}))))
--[[ "use =table and =itable to check" (assert (assert (= [2 3] (tail [1 2 3]))) (assert (= nil (tail nil)) (tail []))) ]]
local function map(col)
end
local function filter(col)
end
local function min(seq)
  local function _9_(_241, _242)
    if (_241 <= _242) then
      return _241
    else
      return _242
    end
  end
  return fold_left(_9_, head(seq), tail(seq))
end
local function max(seq)
  local function _11_(_241, _242)
    if (_241 > _242) then
      return _241
    else
      return _242
    end
  end
  return fold_left(_11_, head(seq), tail(seq))
end
local function mkstring(delimiter, ...)
  local strings = {...}
  local function _13_(_241, _242)
    if delimiter then
      return (_241 .. delimiter .. _242)
    else
      return (_241 .. _242)
    end
  end
  return fold_left(_13_, (head(strings) or ""), tail(strings))
end
local _15_ = min(nil)
assert(assert((1 == min({5, 19, 4, 1, 94}))), assert(((nil == _15_) and (_15_ == min({})))))
local _16_ = mkstring()
local _17_ = mkstring(nil, 1, 2, 3)
assert(assert((("" == _16_) and (_16_ == mkstring(nil)))), assert((("123" == _17_) and (_17_ == mkstring("", 1, 2, 3)))), assert(("a-b-c" == mkstring("-", "a", "b", "c"))))
local function merge_21(...)
  return "merge one or more tables by mutating the first table"
end
local function merge(...)
  return "merge one or more tables into a new table"
end
local function concat(...)
  return "concatenate one or more sequences"
end
return concat
