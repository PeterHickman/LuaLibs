------------------------------------------------------------------------------
-- Title:               clone.lua
-- Description:         Prototype based object system
-- Author:              Kevin Baca
-- Legal:               Under the terms of the MIT License
--                      http://www.opensource.org/licenses/mit-license.html
--
-- Prototype-based programming is a style of object-oriented programming in which 
-- classes are not present, and behavior reuse (known as inheritance in class-based
-- languages) is performed via a process of cloning existing objects that serve as 
-- prototypes. This model can also be known as class-less, prototype-oriented or 
-- instance-based programming.
-- 
-- Most of the code is basically the same as inherit.lua, but reduced to only 
-- the essentials needed to make "Prototype based programming" work. More exactly 
-- it allows prototype programming using cloning and prototype delegation. Access 
-- to a property not set in an object is delegated to it's prototype. This code 
-- uses the table table as the very basic prototype, and object as a specialization 
-- of table. The function object.isa is not strictly needed for the prototype 
-- paradigm, but more of a convenience.
--------------------------------------------------------------------------------

function clone( base_object, clone_object )
    if type( base_object ) ~= "table" then
        return clone_object or base_object 
    end
    clone_object = clone_object or {}
    clone_object.__index = base_object
    return setmetatable(clone_object, clone_object)
end

function isa( clone_object, base_object )
    local clone_object_type = type(clone_object)
    local base_object_type = type(base_object)
    if clone_object_type ~= "table" and base_object_type ~= "table" then
        return clone_object_type == base_object_type
    end
    local index = clone_object.__index
    local _isa = index == base_object
    while not _isa and index ~= nil do
        index = index.__index
        _isa = index == base_object
    end
    return _isa
end

object = clone( table, { clone = clone, isa = isa } )

--[[
    Example usage

    -- testing "isa"
    foo = object:clone()
    bar = object:clone()
    baz = foo:clone()

    foo:isa(object) -- true
    bar:isa(foo)    -- false
    baz:isa(foo)    -- true

    --testing prototype delegation

    foo = object:clone()
    bar = foo:clone()

    function foo:speak()
          print(self.thoughts or "foo has no thoughts")
    end

    bar:speak() -- foo has no thoughts

    bar.thoughts = "I may be a clone, but I'm an individual!"
    bar:speak() --I may be a clone, but I'm an individual!
--]]