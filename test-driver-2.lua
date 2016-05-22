-- An example driver script

dofile("text-graphics.lua")
dofile("dummy-monitor.lua")  -- Replace with monitor-wrapper for in-game use
dofile("dummy-reactor.lua")  -- Replace with reactor-wraper for in-game use
dofile("reactor.lua")
dofile("cbuffer.lua")


mon = MonitorWrapper:new{w = 3, h = 2}
wrxr = ReactorWrapper:new()
gfx = TextGraphics:new{mon = mon}

rxr = Reactor:new{mon = mon, gfx = gfx, rxr = wrxr}
frame = 0

while frame < 30 do
  mon:clear()
  mon:setCursorPos(1,1)

  rxr:draw()

  mon:draw()
  frame = frame + 1
  -- sleep(1)

end
