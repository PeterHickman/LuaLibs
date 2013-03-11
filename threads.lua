--[[

Note that this file is quite old; it is for Lua 5.0 and for the first
edition of the Lua book. Lua socket changed a while since then. The
attached version should work OK with Lua 5.1 and the current version
of Lua socket.

-- Roberto

host = "www.w3.org"

get(host, "/TR/html401/html40.txt")
get(host, "/TR/2002/REC-xhtml1-20020801/xhtml1.pdf")
get(host, "/TR/REC-html32.html")
get(host, "/TR/2000/REC-DOM-Level-2-Core-20001113/DOM2-Core.txt")

dispatch()   -- main loop

--]]

local socket = require "socket"

function receive (connection)
  connection:settimeout(0)      -- do not block
  local s, status, partial = connection:receive(2^10)
  if status == "timeout" then
    coroutine.yield(connection)
  end
  return s or partial, status
end

function download (host, file)
  local c = assert(socket.connect(host, 80))
  local count = 0    -- counts number of bytes read
  c:send("GET " .. file .. " HTTP/1.0\r\n\r\n")
  while true do
    local s, status = receive(c)
    count = count + #s
    if status == "closed" then break end
  end
  c:close()
  print(file, count)
end

threads = {}    -- list of all live threads

function get (host, file)
  -- create coroutine
  local co = coroutine.create(function ()
    download(host, file)
  end)
  -- insert it in the list
  table.insert(threads, co)
end

function dispatch ()
  local i = 1
  local timedout = {}
  while true do
    if threads[i] == nil then   -- no more threads?
      if threads[1] == nil then break end
      i = 1                     -- restart the loop
      timedout = {}
    end
    local status, res = coroutine.resume(threads[i])
    if not res then    -- thread finished its task?
      table.remove(threads, i)
    else               -- time out
      i = i + 1
      timedout[#timedout + 1] = res
      if #timedout == #threads then    -- all threads blocked?
        socket.select(timedout)
      end
    end
  end
end
