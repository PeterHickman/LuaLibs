/*
 * This is an unusual case. I need the current time, down to microseconds,
 * as a string for things like logs. Not something that Lua is good at.
 */

#define LUA_LIB
#include "lua.h"
#include "lauxlib.h"

#include <stdio.h>
#include <sys/time.h>

#define BUFFER_SIZE 64
#define LENGTH_OF_DATE_TIME 19
#define LENGTH_OF_MS 8

static int time_now (lua_State *L) {
  char buffer[BUFFER_SIZE];
  struct tm* tm_info;
  struct timeval tv;
  long int ms;

  gettimeofday(&tv, NULL);

  tm_info = localtime(&tv.tv_sec);

  strftime(buffer, BUFFER_SIZE, "%Y-%m-%dT%H:%M:%S", tm_info);

  ms = (long int)tv.tv_usec % 1000000;

  snprintf(buffer + LENGTH_OF_DATE_TIME, LENGTH_OF_MS, ".%06ld", ms);

  lua_pushstring(L, buffer);

  return 1;
}

int luaopen_time_now(lua_State *L){
  lua_register(L, "time_now", time_now);
  return 0;
}
