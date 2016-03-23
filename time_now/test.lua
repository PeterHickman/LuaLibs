require("time_now")

print("A simple test")
t = {}

for i = 1,10 do
	t[i] = time_now()
end

for k,v in pairs(t) do
	print(k,v)
end
print("")

print("Hammer the garbage collector")
function build()
	local t = {}
	for i = 1,100000 do
		t[i] = time_now()
	end
end

for i = 1,10 do
	print("Iteration " .. i)
	build()
end
