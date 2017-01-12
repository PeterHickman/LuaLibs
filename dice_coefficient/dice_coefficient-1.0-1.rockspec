package = "dice_coefficient"
version = "1.0-1"
source = {
   url = "..." -- We don't have one yet
}
description = {
   summary = "Calculate the dice coeffient of two strings",
   detailed = [[
      Calculate the similarity of two strings with the dice coefficient
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
      dice_coefficient = "dice_coefficient.lua"
   }
}
