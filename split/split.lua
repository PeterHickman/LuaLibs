-- Split string *s* on marker *m* returning a table of the
-- resulting elements. The marker can be anything except
-- the empty string.
--
-- split('1,2,3', ',') => { '1', '2', '3' }
--
-- Note that missing elements are returned as empty strings
--
-- split('1,,3', ',') => { '1', '', '3' }
-- split('1,2,', ',') => { '1', '2', '' }
-- split(',2,3', ',') => { '', '2', '3' }

function split(s, m)
  assert(m ~= '', "The marker cannot be an empty string")

  local start = 1
  local match_start, match_end = 1, 1
  local t = {}

  while match_start ~= nil do
    match_start, match_end = s:find(m, start, true)

    if match_start ~= nil then
      t[#t + 1] = s:sub(start, match_start - 1)
      start = match_end + 1
    end
  end

  t[#t + 1] = s:sub(start)

  return t
end
