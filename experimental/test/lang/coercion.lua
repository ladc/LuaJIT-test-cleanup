-- Test string to number coercion for arithmetic operations.
-- +string +number +arithmetic

--- string to number coercion on operand1
do
  local a, b = "39", 3
  assert(a+b == 42)
  assert(a-b == 36)
  assert(a*b == 117)
  assert(a/b == 13)
  assert(a%b == 0)
  assert(a^b == 59319)
  assert(-a == -39)
end

--- string to number coercion on operand2
do
  local a, b = 39, "3"
  assert(a+b == 42)
  assert(a-b == 36)
  assert(a*b == 117)
  assert(a/b == 13)
  assert(a%b == 0)
  assert(a^b == 59319)
  assert(-a == -39)
end

--- string to number coercion on operand1 and operand2
do
  local a, b = "39", "3"
  assert(a+b == 42)
  assert(a-b == 36)
  assert(a*b == 117)
  assert(a/b == 13)
  assert(a%b == 0)
  assert(a^b == 59319)
  assert(-a == -39)
end

--- string to number coercion on operand1 with literal number as operand2
do
  local a = "39"
  assert(a+3 == 42)
  assert(a-3 == 36)
  assert(a*3 == 117)
  assert(a/3 == 13)
  assert(a%3 == 0)
  assert(a^3 == 59319)
end

--- string to number coercion on operand2 with literal number as operand1
do
  local b = "3"
  assert(39+b == 42)
  assert(39-b == 36)
  assert(39*b == 117)
  assert(39/b == 13)
  assert(39%b == 0)
  assert(39^b == 59319)
end
