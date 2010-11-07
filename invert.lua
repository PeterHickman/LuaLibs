------------------------------------------------------------------------------
-- Title:               invert.lua
-- Description:         Invert a table
-- Author:              Peter Hickman (peterhi@ntlworld.com)
-- Creation Date:       2009/02/14
-- Legal:               Under the terms of the MIT License
--                      http://www.opensource.org/licenses/mit-license.html
--
-- Yeah, like no ones thought of this one before
--------------------------------------------------------------------------------

function invert(t)
     local i = {}
     for _,v in pairs(t) do
         i[v] = true
     end
     return i
end
