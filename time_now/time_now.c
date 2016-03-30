/*
 * This is an unusual case. I need the current time, down to microseconds,
 * as a string for things like logs. Not something that Lua is good at.
 */

#define LUA_LIB
#include "lua.h"
#include "lauxlib.h"

#include <stdio.h>
#include <string.h>
#include <time.h>
#include <sys/time.h>

#define BUFFER_SIZE 64
#define LENGTH_OF_DATE_TIME 19
#define LENGTH_OF_MS 8

static int time_now (lua_State *L) {
  char buffer1[BUFFER_SIZE];
  char buffer2[BUFFER_SIZE];
  struct tm* tm_info;
  struct timeval tv;

  gettimeofday(&tv, NULL);

  tm_info = localtime(&tv.tv_sec);

  /*
   * The time with a placeholder for the microseconds
   */
  strftime(buffer1, BUFFER_SIZE, "%Y-%m-%dT%H:%M:%S.XXXXXX %z", tm_info);

  /*
   * Get the microseconds
   */
  snprintf(buffer2, LENGTH_OF_MS, ".%06ld", (long int)tv.tv_usec % 1000000);

  /*
   * Assemble the final string
   */
  strncpy(buffer1 + LENGTH_OF_DATE_TIME, buffer2, LENGTH_OF_MS - 1);

  lua_pushstring(L, buffer1);

  return 1;
}

int luaopen_time_now(lua_State *L){
  lua_register(L, "time_now", time_now);
  return 0;
}
