require("time_now")

t = {}

for i = 1,10 do
	t[i] = time_now()
end

for k,v in pairs(t) do
	print(k,v)
end
