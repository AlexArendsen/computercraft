-- An example driver script

dofile("text-graphics.lua")
dofile("monitor-wrapper.lua")
dofile("reactor-wrapper.lua")
dofile("reactor.lua")
dofile("cbuffer.lua")


mon = MonitorWrapper:new{w = 3, h = 2}
wrxr = ReactorWrapper:new{selector = "BigReactors-Reactor_2"}
gfx = TextGraphics:new{mon = mon}
rxr = Reactor:new{mon = mon, gfx = gfx, rxr = wrxr}

while 1 do
  mon:clear()
  mon:setCursorPos(1,1)

  rxr:draw()

  sleep(1)
end
