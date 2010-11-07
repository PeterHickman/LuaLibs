------------------------------------------------------------------------------
-- Title:               test.lua
-- Description:         A simple test system
-- Author:              Peter Hickman (peterhi@ntlworld.com)
-- Creation Date:       2007/12/22
-- Legal:               Copyright (C) 2007 Peter Hickman
--                      Under the terms of the MIT License
--                      http://www.opensource.org/licenses/mit-license.html
--------------------------------------------------------------------------------

local print = print
local pcall = pcall
local error = error

module('test')

local counter = 0

-- Remove the program and line number from the front
-- of an error message to stop fails() being fragile

local function cleanerror( text )
    local pos = text:find(' ') + 1
    return text:sub(pos, -1)
end

-- Are two things equal

function assertEqual( source, expected )
    counter = counter + 1

    if (source == expected) then
        print('Ok..' .. counter)
    else
        print('Not Ok..' .. counter)
        print(' Expected: ' .. expected)
        print(' Received: ' .. source)
        error('Tests failed')
    end
end

-- Test that the code throws the expected error

function assertThrowsError( code, expected )
    counter = counter + 1

    local status, err = pcall(code)

    if(status == true) then
        print('Not Ok..' .. counter)
        print(' Code did not throw any error')
        error('Tests failed')
    else
        err = cleanerror( err )
        if(err == expected) then
            print('Ok..' .. counter)
        else
            print('Not Ok..' .. counter)
            print(' Expected: ' .. expected)
            print(' Received: ' .. err)
            error('Tests failed')
        end
    end
end
