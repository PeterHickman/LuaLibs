-- Calculate the dice coefficient of two strings. Also called the Sorensen 
-- index. If the returned value is 1.0 then the strings identical, 0.0 is
-- when the strings are completely dissimilar.
-- 
-- The input strings are assumed to have been flattened (downcased and 
-- accented characters removed)
--
-- There is a Wikipedia page about it, probably

local function create_bigrams(string)
  -- Split a string like "the cat" into a list of bigrams such
  -- as { "th", "he", "ca", "at" } where any bigram that includes
  -- a space is ignored. These bigrams are then the keys to
  -- the table where the number of occurences is the value
  --
  -- It does assume that the string is at least 2 characters long!

	assert(string:len() >= 2, "String needs to be at least 2 characters")

	local t = {}

	local bigram
	local this_char = ''
	local next_char = string:sub(1,1)
	local total = 0

	for i = 2,#string do
		this_char = next_char
		next_char = string:sub(i,i)

		if this_char ~= ' ' and next_char ~= ' ' then
			total = total + 1
			bigram = this_char .. next_char
			if t[bigram] then
				t[bigram] = t[bigram] + 1
			else
				t[bigram] = 1
			end
		end
	end

	return t, total
end

function dice_coefficient(s1, s2)
	local s1b, s1t = create_bigrams(s1)
	local s2b, s2t = create_bigrams(s2)

	local total = s1t + s2t
	local same = 0

	for k,v1 in pairs(s1b) do
		v2 = s2b[k]
		if v2 ~= nil then
			same = same + (v1 < v2 and v1 or v2) * 2
		end
	end

	return same / total
end
