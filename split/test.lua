require 'split'

test_number = 0

--
-- The actual message will be something like:
-- "./split.lua:14: The marker cannot be an empty string"
-- however the prefix is OS specific and the tests will fail
-- if a new line is added to the file. So we remove the prefix
--

function clean_error(text)
  local s, e = text:find(": ")
  return text:sub(e+1)
end

function test(s, m, r)
  local x = split(s, m)
  local ok = true

  test_number = test_number + 1

  if #x == #r then
    for k,v in pairs(x) do
      if v ~= r[k] then
        print(test_number .. " Mismatched element " .. v .. " is not " .. r[k])
        ok = false
      end
    end
  else
    print(test_number .. " Size not matched " .. #x .. " and " .. #r)
    ok = false
  end

  if ok then
    print(test_number .. " Ok")
  end
end

function fail(s, m, e)
  test_number = test_number + 1

  local status, err = pcall(function () split(s,m) end)

  err = clean_error(err)

  if status then
    print(test_number .. " Error not raised")
  elseif err == e then
    print(test_number .. " Ok")
  else
    print(test_number .. " wrong error thrown. Expected=[" .. e .. "], actual=[" .. err .. "]")
  end
end

test("1x234x5556",'x', {'1', '234', '5556'})
test("1", 'x', {'1'})
test("1x2", 'x', {'1','2'})
test('x','x',{'',''})
test('ax', 'x', {'a',''})
test('xa','x',{'','a'})
test('axxb','x', {'a','','b'})
test('axx','x',{'a','',''})
test('xax','x',{'','a',''})
test('xxa','x',{'','','a'})
test('123zxc123','zxc',{'123','123'})
test('123zx123','zxc',{'123zx123'})
test("1\t2\t3","\t",{'1','2','3'})
test('1', '11', { '1' })
test('1xxx2', 'xx', { '1', 'x2'})
test('1xxxx2', 'xx', { '1', '', '2'})
test('1xxxxx2', 'xx', { '1', '', 'x2'})
fail('1,2,3','', 'The marker cannot be an empty string')
fail('1,2,3', nil, 'The marker cannot be an empty string')
test('1,2,3', 2, { '1,', ',3'})
test('1,,3', ',', { '1', '', '3' })
test('1,2,', ',', { '1', '2', '' })
test(',2,3', ',', { '', '2', '3' })
