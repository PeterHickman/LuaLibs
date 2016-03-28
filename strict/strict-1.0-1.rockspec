package = "strict"
version = "1.0-1"
source = {
   url = "..." -- We don't have one yet
}
description = {
   summary = "Make sure that variables are declared before use",
   detailed = [[
      Make sure that variables are declared before use. This is
      a classic Lua module to the extent that the author has been
      lost in the mists of time
   ]],
   homepage = "https://github.com/PeterHickman/LuaLibs",
   license = "MIT/X11"
}
dependencies = {
   "lua ~> 5.1"
}
build = {
   type = "builtin",
   modules = {
      strict = "strict.lua"
   }
}
