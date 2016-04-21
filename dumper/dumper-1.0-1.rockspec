package = "dumper"
version = "1.0-1"
source = {
   url = "..." -- We don't have one yet
}
description = {
   summary = "Dump data in a human readable way",
   detailed = [[Dump data in a human readable way]],
   homepage = "https://github.com/PeterHickman/LuaLibs",
   license = "MIT/X11"
}
dependencies = {
   "lua ~> 5.1"
}
build = {
   type = "builtin",
   modules = {
      dumper = "dumper.lua"
   }
}
