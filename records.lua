--[[

spir denis.spir@gmail.com
10:39 (13 minutes ago)

to lua 
Hello,

It came to my mind that it is easy in Lua to have kinds of structs, objects with predefined field structure that they thus do not need to hold themselves, instead they just hold data. like C structs, Pascal records, Python namedtuples (actually unnamed). Is there any common or known implementation of such things in Lua? I have no idea whether it can be useful in practice. Below an example realisation with 2 usage examples. It basically trades direct field access for space.

My method is a kind of mixture of object type with proxy table. The diff beeing that the proxy here in fact holds data and just misses field names. This implementation also raised a question that can probably be relevant in other cases of abstraction via metatables: When looking up a field (for get or set), we need to jump twice from the record (table of field data) to its "kind"/metatable: first to check there is an index/newindex metafield on the metatable, second in the actual get/set func to search for field name on the "kind". What do you think? Is there a way to avoid that double access?

Another question I take the opportunity to ask is about the '%q' format tag: I initially used to to print field data when they are strings (since the output is here programmer feedback) but realised that newlines are not escaped. Tabs and other control chars are ascaped, but newline are just preceded by a _literal_ backslash \. I find this extremely annoying. (Even more because when trying to "repair" that "default" I realised I cannot even reuse '%q' either before of after a gsub('\n', '\\10') because the original newline or replacement escape is itself processed by '%q'; so that '%q' must be replaced alltogether. Or I miss a point.)

Denis

PS: After reflexion I realised that with strings interned repetition of field names on "object-like tables" in Lua is just adding a load of refs, not of string data. Still isn't it a bit wasteful? And tere are tons of cases where objects a given kind have a constant, predefined structure (well, we could even say it's the norm).
Also, I learned "small" string are interned: is there a known or even official order of magnitude of size in bytes?

=======================================================

-- examples

local RGB = Record{'r','g','b'}
local rgb = RGB{2,1,3}

print(rgb)    -- (r:2 g:1 b:3)
print(rgb.g)  -- 1
rgb.g = 9
print(rgb.g)  -- 9
print(rgb)    -- (r:2 g:9 b:3)

local Contact = Record{"phone","email","address"}
local foobar = Contact{"12.34.56.78.90", "foo@bar.org", "blah,blah,blah"}
print(foobar)        -- (phone:12.34.56.78.90 email:foo@bar.org address:blah,blah,blah)
foobar.email = "bar@foo.net"
print(foobar.email)  -- bar@foo.net
print(foobar)        -- (phone:12.34.56.78.90 email:bar@foo.net address:blah,blah,blah)

--]]

-- Record "type"

local putit = table.insert    -- put it (item) in array ;-)

Record = {
   mt = {} ,
}

Record.new_kind = function (Record, kind)
   -- reverse map field-name --> index
   kind.field_indexes = {}
   for i,field_name in ipairs(kind) do
      kind.field_indexes[field_name] = i
   end
   -- metafields
   kind.__tostring   = Record.tostring
   kind.__index      = Record.get
   kind.__newindex   = Record.set
   setmetatable(kind, Record)
   return kind
end

Record.new = function (kind, rec)
   setmetatable(rec, kind)
   return rec
end

Record.get = function(rec, field_name)
   local kind = getmetatable(rec)
   local i = kind.field_indexes[field_name]
   return rec[i]
end

Record.set = function(rec, field_name, val)
   local kind = getmetatable(rec)
   local i = kind.field_indexes[field_name]
   rec[i] = val
end

Record.tostring = function (rec)
   local field_names = getmetatable(rec)
   local strings = {}
   for i,item in ipairs(rec) do
      putit(strings, field_names[i] .. ":" .. tostring(item))
   end
   local string = table.concat(strings, ' ')
   return '(' .. string .. ')'
end

Record.__call     = Record.new
Record.mt.__call  = Record.new_kind
setmetatable(Record, Record.mt)
