------------------------------------------------------------------------------
-- Title:               memoize.lua
-- Description:         A simple memoize function
-- Author:              Roberto Ierusalimschy
-- Creation Date:       2008/11
-- Legal:               Under the terms of the MIT License
--                      http://www.opensource.org/licenses/mit-license.html
--
-- Usage:
-- f = memoize(f)
--
--------------------------------------------------------------------------------

function memoize(f)
    local mem = {}
    setmetatable(mem, {__mode = "kv"})
    return function (x)
        local r = mem[x]
        if nil == r then
            r = f(x)
            mem[x] = r
        end
        return r
    end
end
