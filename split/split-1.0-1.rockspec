package = "split"
version = "1.0-1"
source = {
   url = "..." -- We don't have one yet
}
description = {
   summary = "Split a string on a given marker returning a table",
   detailed = [[
      Split a string into its parts best on a marker and return a table
      containing those elements
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
      split = "split.lua"
   }
}
