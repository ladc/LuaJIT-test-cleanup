-- Test whether correct arithmetic metamethods are called when calling
-- multiple times (stress tests targeted to +jit).
-- +__add +__sub +__mul +__div +__mod +__pow +__unm

--- meta arith methods on operand2 in loop
-- Check if the correct arithmetic metamethods are called, and if they
-- are called on the correct operand2, inside a loop.
do
  local t = {}
  local mt = {
    __add = function(a, b) assert(b == t); return a+11 end,
    __sub = function(a, b) assert(b == t); return a+12 end,
    __mul = function(a, b) assert(b == t); return a+13 end,
    __div = function(a, b) assert(b == t); return a+14 end,
    __mod = function(a, b) assert(b == t); return a+15 end,
    __pow = function(a, b) assert(b == t); return a+16 end,
    __unm = function(a, b) assert(a == t and b == t); return 17 end,
  }
  t = setmetatable(t, mt)
  do local x = 0; for i=1,100 do x = x + t end; assert(x == 1100); end
  do local x = 0; for i=1,100 do x = x - t end; assert(x == 1200); end
  do local x = 0; for i=1,100 do x = x * t end; assert(x == 1300); end
  do local x = 0; for i=1,100 do x = x / t end; assert(x == 1400); end
  do local x = 0; for i=1,100 do x = x % t end; assert(x == 1500); end
  do local x = 0; for i=1,100 do x = x ^ t end; assert(x == 1600); end
  do local x = 0; for i=1,100 do x = x + (-t) end; assert(x == 1700); end
end

--- meta arith methods on operand1 in loop
-- Check if the correct arithmetic metamethods are called, and if they
-- are called on the correct operand1, inside a loop.
do
  local t = {}
  local mt = {
    __add = function(a, b) assert(a == t); return b+11 end,
    __sub = function(a, b) assert(a == t); return b+12 end,
    __mul = function(a, b) assert(a == t); return b+13 end,
    __div = function(a, b) assert(a == t); return b+14 end,
    __mod = function(a, b) assert(a == t); return b+15 end,
    __pow = function(a, b) assert(a == t); return b+16 end,
  }
  t = setmetatable(t, mt)
  do local x = 0; for i=1,100 do x = t + x end; assert(x == 1100); end
  do local x = 0; for i=1,100 do x = t - x end; assert(x == 1200); end
  do local x = 0; for i=1,100 do x = t * x end; assert(x == 1300); end
  do local x = 0; for i=1,100 do x = t / x end; assert(x == 1400); end
  do local x = 0; for i=1,100 do x = t % x end; assert(x == 1500); end
  do local x = 0; for i=1,100 do x = t ^ x end; assert(x == 1600); end
end

--- meta arith methods on operand1 or 2 in loop
-- Check if the correct arithmetic metamethods are called, and if both
-- operands are passed correctly, inside a loop.
do
  local t = {}
  local mt = {
    __add = function(a, b) assert(a == t and b == t); return 11 end,
    __sub = function(a, b) assert(a == t and b == t); return 12 end,
    __mul = function(a, b) assert(a == t and b == t); return 13 end,
    __div = function(a, b) assert(a == t and b == t); return 14 end,
    __mod = function(a, b) assert(a == t and b == t); return 15 end,
    __pow = function(a, b) assert(a == t and b == t); return 16 end,
  }
  t = setmetatable(t, mt)
  do local x = 0; for i=1,100 do x = t + t end; assert(x == 11); end
  do local x = 0; for i=1,100 do x = t - t end; assert(x == 12); end
  do local x = 0; for i=1,100 do x = t * t end; assert(x == 13); end
  do local x = 0; for i=1,100 do x = t / t end; assert(x == 14); end
  do local x = 0; for i=1,100 do x = t % t end; assert(x == 15); end
  do local x = 0; for i=1,100 do x = t ^ t end; assert(x == 16); end
end

--- meta arith returns nil
-- Check if the metamethod __add, if defined to return nil, actually
-- returns nil.  
do
  local t = {}
  local mt = { __add = function(a, b) end }
  t = setmetatable(t, mt)
  local x
  for i=1,100 do x = t+t end
  assert(x == nil)
end
