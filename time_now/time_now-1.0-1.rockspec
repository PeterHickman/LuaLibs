package = "time_now"
version = "1.0-1"
source = {
   url = "..." -- We don't have one yet
}
description = {
   summary = "A detailed textual timestamp",
   detailed = [[
	  For various reasons, such as detailed logging, I need the current
	  time down to milliseconds. This is not something the Lua os.time()
	  function can handle
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
      time_now = "time_now.c"
   }
}
