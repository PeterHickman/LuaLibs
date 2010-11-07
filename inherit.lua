------------------------------------------------------------------------------
-- Title:               inherit.lua
-- Description:         Inheritance based object system
-- Author:              Kevin Baca
-- Legal:               Under the terms of the MIT License
--                      http://www.opensource.org/licenses/mit-license.html
--
-- The function inheritsFrom(baseClass) takes a single argument, the class 
-- declaration we want to inherit from. The function returns a class declaration 
-- which we can then tailor. new_class is the new class declaration to be 
-- returned. The nested function new_class:create() is part of the class 
-- declaration returned and will create new instances of the sub class we are 
-- creating. This function creates a newinst table which uses our new class 
-- table to hold it's methods. The new class table in turn looks in the baseClass
-- if it cannot find a method we require, and thus we inherit it's methods.
--------------------------------------------------------------------------------

function inheritsFrom( baseClass )
    local new_class = {}
    local class_mt = { __index = new_class }

    function new_class:create()
        local newinst = {}
        setmetatable( newinst, class_mt )
        return newinst
    end

    if nil ~= baseClass then
        setmetatable( new_class, { __index = baseClass } )
    end

    -- Implementation of additional OO properties starts here --

    -- Return the class object of the instance
    function new_class:class()
        return new_class
    end

    -- Return the super class object of the instance
    function new_class:superClass()
        return baseClass
    end

    -- Return true if the caller is an instance of theClass
    function new_class:isa( theClass )
        local b_isa = false

        local cur_class = new_class

        while ( nil ~= cur_class ) and ( false == b_isa ) do
            if cur_class == theClass then
                b_isa = true
            else
                cur_class = cur_class:superClass()
            end
        end

        return b_isa
    end

    return new_class
end

--[[
    Example usage

    Account = inheritsFrom( nil )

    Account.balance = 0

    function Account:deposit(v)
        self.balance = self.balance + v
    end

    a = Account:create()
    a:deposit(15)

    ATM = inheritsFrom( Account )

    function ATM:show()
        print("Your balance is " .. self.balance)
    end

    c = ATM:create()

    c:show()       -- Your balance is 0
    c:deposit(21)
    c:show()       -- Your balance is 21

    WithDraw = inheritsFrom( ATM )

    function WithDraw:withdraw(v)
        self.balance = self.balance - v
    end

    d = WithDraw:create()
    d:show()       -- Your balanace is 0
    d:deposit(10)
    d:withdraw(3)
    d:show()       -- Your balance is 7
--]]
