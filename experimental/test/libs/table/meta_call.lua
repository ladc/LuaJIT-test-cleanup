-- Tests for the +__call metamethod
-- +setmetatable +meta

local function callmeta(o, a, b)
  return o, a, b
end

local meta = { __call = callmeta }

--- call metamethod on tables correctly passes arguments
do
  local t = setmetatable({}, meta)
  local o,a,b = t()
  assert(o == t and a == nil and b == nil)
  local o,a,b = t("foo")
  assert(o == t and a == "foo" and b == nil)
  local o,a,b = t("foo", "bar")
  assert(o == t and a == "foo" and b == "bar")
end

--- call metamethod on newproxy object correctly passes arguments
-- +newproxy
do
  local u = newproxy(true)
  getmetatable(u).__call = callmeta

  local o,a,b = u()
  assert(o == u and a == nil and b == nil)
  local o,a,b = u("foo")
  assert(o == u and a == "foo" and b == nil)
  local o,a,b = u("foo", "bar")
  assert(o == u and a == "foo" and b == "bar")
end

--- call metamethod on number correctly passes arguments
-- +debug
do
  debug.setmetatable(0, meta)
  local o,a,b = (42)()
  assert(o == 42 and a == nil and b == nil)
  local o,a,b = (42)("foo")
  assert(o == 42 and a == "foo" and b == nil)
  local o,a,b = (42)("foo", "bar")
  assert(o == 42 and a == "foo" and b == "bar")
  debug.setmetatable(0, nil)
end

--- __call in __add metamethod propagation
-- Check if the metamethod __call is correctly propagated when its table is
-- defined as the __add metamethod for another table.
do
  local tc = setmetatable({}, { __call = function(o,a,b) return o end})
  local ta = setmetatable({}, { __add = tc})
  local o,a = ta + ta
  assert(o == tc and a == nil)

  getmetatable(tc).__call = function(o,a,b) return a end
  local o,a = ta + ta
  assert(o == ta and a == nil)
  
  getmetatable(tc).__call = function(o,a,b) return b end
  local o,a = ta + ta
  assert(o == ta and a == nil)
end

--- call metamethod arithmetic in loop
do
  local t = setmetatable({}, { __call = function(t, a) return 100-a end })
  for i=1,100 do assert(t(i) == 100-i) end
end

--- if call metamethod is rawget, find index behaviour
do
  local t = setmetatable({}, { __call = rawget })
  for i=1,100 do t[i] = 100-i end
  for i=1,100 do assert(t(i) == 100-i) end
end

--- call metamethod on number metatable passes number value as argument
-- +debug
do
  debug.setmetatable(0, { __call = function(n) return 100-n end })
  for i=1,100 do assert((i)() == 100-i) end
  debug.setmetatable(0, nil)
end

--- if call is rawset and newindex is pcall, find newindex assignment behaviour
do
  local t = setmetatable({}, { __newindex = pcall, __call = rawset })
  for i=1,100 do t[i] = 100-i end
  for i=1,100 do assert(t[i] == 100-i) end
end

--- if call fills table entry and index is pcall, indexing table sets values
do
  local t = setmetatable({}, {
    __index = pcall, __newindex = rawset,
    __call = function(t, i) t[i] = 100-i end,
  })
  for i=1,100 do assert(t[i] == true and rawget(t, i) == 100-i) end
end

