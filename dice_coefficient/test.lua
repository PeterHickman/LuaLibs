require 'dice_coefficient'

test_number = 0

function float_equal(lhs, rhs)
	local abs = math.abs
	local epsilon = 1E-12 * 0.5
	return abs(lhs - rhs) <= epsilon * (abs(lhs) + abs(rhs))
end

function test(s1, s2, e)
	local a = dice_coefficient(s1, s2)

	test_number = test_number + 1

	if float_equal(a, e) then
		print(test_number .. " Ok")
	else
		print(test_number .. " Failed. Expected " .. e .. ", actual " .. a)
	end
end

test("banana","banana", 1.0)
test("cat", "cap", 0.5)
test("xxx", "yyy", 0.0)
test("banana", "BANANA", 0.0)
test("banana", "bananana", 0.8333333333333)
test("aaa", "aaza", 0.4)
test("aaza", "aaa", 0.4)
