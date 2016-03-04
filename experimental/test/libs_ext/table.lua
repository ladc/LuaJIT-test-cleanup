--- table.new
do
  local tnew = require("table.new")
  local x, y
  for i=1,100 do
    x = tnew(100, 30)
    if i == 90 then y = x end
  end
  assert(x ~= y)
end

--- table.pack()
-- +lua52
do
  if os.getenv("LUA52") then
    local t = table.pack()
    assert(t.n == 0 and t[0] == nil and t[1] == nil)
  end
end

--- table.pack(99)
-- +lua52
do
  if os.getenv("LUA52") then
    local t = table.pack(99)
    assert(t.n == 1 and t[0] == nil and t[1] == 99 and t[2] == nil)
  end
end

--- table.pack(nils)
-- +lua52
do
  if os.getenv("LUA52") then
    local t = table.pack(nil, nil, nil)
    assert(t.n == 3 and t[0] == nil and t[1] == nil and t[2] == nil and t[3] == nil and t[4] == nil)
  end
end

--- ipairs and pairs metamethods
-- pairs and ipairs work as expected when the corresponding metamethods
-- are set to the stateless iterators with the original behaviour.
-- +lua52 +__ipairs +__pairs
do
  if os.getenv("LUA52") then
    local function iter(t, i)
      i = i + 1
      if t[i] then return i, t[i]+2 end
    end
    local function itergen(t)
      return iter, t, 0
    end
    local t = setmetatable({}, { __pairs = itergen, __ipairs = itergen })
    for i=1,10 do t[i] = i+100 end
    local a, b = 0, 0
    for j=1,100 do for k,v in ipairs(t) do a = a + k; b = b + v end end
    assert(a == 5500)
    assert(b == 107500)
    a, b = 0, 0
    for j=1,100 do for k,v in pairs(t) do a = a + k; b = b + v end end
    assert(a == 5500)
    assert(b == 107500)
  end
end

