--[[
from	Luiz Henrique de Figueiredo <lhf@tecgraf.puc-rio.br>
reply-to	Lua list <lua@bazar2.conectiva.com.br>
to	Lua list <lua@bazar2.conectiva.com.br>
date	15 July 2010 13:29
subject	Re: Colored text?

BTW, here is a simple ANSI terminal module that you may find useful.
--]]

term={
       output=io.write,
       clear = function () term.output("\027[2J") end,
       cleareol = function () term.output("\027[K") end,
       goto = function (l,c) term.output("\027[",l,";",c,"H") end,
       goup = function (n) term.output("\027[",n or 1,";","A") end,
       godown = function (n) term.output("\027[",n or 1,";","B") end,
       goright = function (n) term.output("\027[",n or 1,";","C") end,
       goleft = function (n) term.output("\027[",n or 1,";","D") end,
       color = function (f,b) term.output("\027[",f,";",b,"m") end,
       save = function () term.output("\027[s") end,
       restore = function () term.output("\027[u") end,
}

--[[
term.clear()
term.goto(10,1)
term.cleareol()
term.goto(10,10)
term.output("hello!")
term.color(31,42)
term.output("bye!")
term.color(43,31)
term.output("tchau mesmo!")
term.color(0,0)
term.output("ok!")
term.goup(4)
term.goleft(8)
term.output("here")
term.save()
term.goto(2,3)
term.output("HERE")
term.restore()
term.output("DONE")
--]]

