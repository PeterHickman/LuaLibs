package = "msleep"
version = "1.0-1"
source = {
   url = "..." -- We don't have one yet
}
description = {
   summary = "Add a sleep function to lua",
   detailed = [[
      Lua does not provide a sleep function so this module
	  gives access to the C sleep and msleep functions rather
	  than shelling out to call the shell command or executing
	  a big loop
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
      msleep = "msleep.c"
   }
}
