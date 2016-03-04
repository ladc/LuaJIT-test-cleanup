-- Test whether correct arithmetic metamethods are called.
-- +arith +setmetatable +meta
-- +__add +__sub +__mul +__div +__mod +__pow +__unm

local function create(arith, v1, v2)
  local meta = {
    __add=function(a,b) return arith("add", a, b) end,
    __sub=function(a,b) return arith("sub", a, b) end,
    __mul=function(a,b) return arith("mul", a, b) end,
    __div=function(a,b) return arith("div", a, b) end,
    __mod=function(a,b) return arith("mod", a, b) end,
    __pow=function(a,b) return arith("pow", a, b) end,
    __unm=function(a,b) return arith("unm", a, b) end,
  }
  return setmetatable({v1}, meta), setmetatable({v2}, meta)
end

--- meta arith methods
-- Check if correct arithmetic metamethods are called
do
  local a, b = create(function(op,a,b) return op end)
  assert(a+b == "add")
  assert(a-b == "sub")
  assert(a*b == "mul")
  assert(a/b == "div")
  assert(a%b == "mod")
  assert(a^b == "pow")
  assert(-a == "unm")
end

--- meta arith arg1
-- Check if first argument is correctly passed
do
  local a, b = create(function(op,a,b) return a[1] end, "foo", 42)
  assert(a+b == "foo")
  assert(a-b == "foo")
  assert(a*b == "foo")
  assert(a/b == "foo")
  assert(a%b == "foo")
  assert(a^b == "foo")
  assert(-a == "foo")
end

--- meta arith arg2 
-- Check if second argument is correctly passed where applicable
do
  local a, b = create(function(op,a,b) return b[1] end, 42, "foo")
  assert(a+b == "foo")
  assert(a-b == "foo")
  assert(a*b == "foo")
  assert(a/b == "foo")
  assert(a%b == "foo")
  assert(a^b == "foo")
  assert(-a == 42)
end

--- meta arith operand1
-- Check if metamethod of operand1 is called if operand2 is a number
do
  local a, b = create(function(op,a,b) return a[1]+b end, 39), 3
  assert(a+b == 42)
  assert(a-b == 42)
  assert(a*b == 42)
  assert(a/b == 42)
  assert(a%b == 42)
  assert(a^b == 42)
end

--- meta arith operand2
-- Check if metamethod of operand2 is called if operand1 is a number
do
  local a, b = 39, create(function(op,a,b) return a+b[1] end, 3)
  assert(a+b == 42)
  assert(a-b == 42)
  assert(a*b == 42)
  assert(a/b == 42)
  assert(a%b == 42)
  assert(a^b == 42)
end
