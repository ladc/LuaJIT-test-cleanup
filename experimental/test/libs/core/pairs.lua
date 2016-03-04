-- ipairs and pairs work for arrays
do
  local t = {}
  for i=1,10 do t[i] = i+100 end
  local a, b = 0, 0
  for j=1,100 do for k,v in ipairs(t) do a = a + k; b = b + v end end
  assert(a == 5500)
  assert(b == 105500)
  a, b = 0, 0
  for j=1,100 do for k,v in pairs(t) do a = a + k; b = b + v end end
  assert(a == 5500)
  assert(b == 105500)
end

-- ipairs and pairs work for arrays with empty metatable
do
  local t = setmetatable({}, {})
  for i=1,10 do t[i] = i+100 end
  local a, b = 0, 0
  for j=1,100 do for k,v in ipairs(t) do a = a + k; b = b + v end end
  assert(a == 5500)
  assert(b == 105500)
  a, b = 0, 0
  for j=1,100 do for k,v in pairs(t) do a = a + k; b = b + v end end
  assert(a == 5500)
  assert(b == 105500)
end