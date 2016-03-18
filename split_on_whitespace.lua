function split_on_whitespace(string)
  t = {}

  for e in string:gmatch("%S+") do
    t[#t+1] = e
  end

  return t
end

--[[
function test(source, expected)
  local x = split_on_whitespace(source)

  if #x ~= #expected then
    print("Not Ok. Not the same length. Expected " .. #expected .. ", actual " .. #x)
    return
  end

  local ok = true
  local error_at = nil
  local error_e = nil
  local error_a = nil

  for i, e in ipairs(x) do
    if e ~= expected[i] then
      error_at = i
      error_e  = expected[i]
      error_a  = e
      ok = false
      break
    end
  end

  if ok == true then
    print("Ok")
  else
    print("Not Ok. Elements mismatch at [" .. error_at .. "] expected [" .. error_e .. "], actual [" .. error_a .. "]")
  end
end

test("a", {"a"})
test(" a ", {"a"})
test("    a   ", {"a"})

test("a b", {"a","b"})
test("a   b", {"a","b"})
test("  a b  ", {"a","b"})

-- These tests will fail

test("a b", {"a","x"})
test("a b",{"ab"})
test("a b c", {"x","y","z"})

--]]
