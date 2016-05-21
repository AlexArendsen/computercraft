-- Dummy Computercraft Monitor, written by Alex Arendsen
-- Provides an identical interface to the in-game monitor
-- device, allowing for richer out-of-game development
-- and testing.
--
-- When you want to use your code in the game, simply
-- use the MonitorWrapper defined in monitor-wrapper
-- instead.

MonitorWrapper = {
  w  = 1,  -- Width in Minecraft blocks
  h  = 1,  -- Height in Minecraft blocks
  cw = 1,  -- Width in characters
  ch = 1,  -- Height in characters
  cx = 1,  -- Cursor X position
  cy = 1,  -- Cursor Y position
  buffer = {},    -- Character display buffer
  blink = false,  -- Cursor blink state (not implemented)
  isColor = false
}

function MonitorWrapper:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o:_initialize()
  return o
end

function MonitorWrapper:_initialize()
  self:setTextScale(0.5)
  self:clear()
end

function MonitorWrapper:write (str)
  str = self:repr(str)
  local l = str:len()
  if self.buffer[self.cy] == nil then
    self.buffer[self.cy] = {}
  end
  for c in str:gmatch"." do
    self.buffer[self.cy][self.cx] = c
    self.cx = self.cx + 1
  end
end

function MonitorWrapper:blit (str, colors, background)
  -- Colors not yet supported
  self:write(str)
end

function MonitorWrapper:clear()
  for i=1,self.ch do
    self.buffer[i] = {}
    for j=1,self.cw do
      self.buffer[i][j] = " "
    end
  end
end

function MonitorWrapper:clearLine()
  self.buffer[self.cy] = {}
  for j=1,self.cw do
    self.buffer[self.cy][j] = " "
  end
end

function MonitorWrapper:getCursorPos()
  return self.cx, self.cy
end

function MonitorWrapper:setCursorPos(x,y)
  self.cx = x
  self.cy = y
end

function MonitorWrapper:setCursorBlink(state)
  self.blink = state
end

function MonitorWrapper:isColor()
  return self.iSColor
end

function MonitorWrapper:getSize()
  return self.cw, self.ch
end

function MonitorWrapper:scroll(amount)
  -- Not implemented yet
end

function MonitorWrapper:redirect(target)
  -- (Not applicable)
end

function MonitorWrapper:current()
  -- (Not realistic to implement here)
  -- (May do it later if I'm wrong about that)
  return {}
end

function MonitorWrapper:native()
  -- (Same as current)
  return {}
end

function MonitorWrapper:setTextColor(color)
  -- Colors not supported right now
end

function MonitorWrapper:getTextColor()
  -- Colors not supported right now
  return -1
end

function MonitorWrapper:setBackgroundColor(color)
  -- Colors not supported right now
end

function MonitorWrapper:getBackgroundColor()
  -- Colors not supported right now
  return -1
end

-- Approximate character-per-block scaling:
-- SCALE  X    Y
--   0.5  19   12
--   1.0  9    6
--   1.5  6    4
--   2.0  4.5  3
--   2.5  3.5  2.5
--   3.0  3    2
--   3.5  2.5  1.5
--   4.0  2.25 1.5
--   4.5  2    1.5
--   5.0  2    1
function MonitorWrapper:setTextScale(scale)
  ref = {19,9,6,4.5,3.5,3,2.5,2.25,2,2}
  self.cw = math.floor(ref[scale*2])
  self.ch = math.floor(self.cw * 0.75 * self.h)
  self.cw = self.cw * self.w
end

-- Wrapper-specific methods

function MonitorWrapper:draw()
  for i=1,self.ch do
    line = ""
    for j=1,self.cw do
      c = self.buffer[i][j]
      if c == nil then
        line = line.." "
      else
        line = line..c
      end
    end
    print(line)
  end
end

-- Get string prepresentation of some input
function MonitorWrapper:repr(value)
  t = type(value)
  if t == "string" then
    return value
  elseif t == "number" then
    suf = ""
    if value % 1 == 0 then
      suf = ".0"
    end
    return tostring(value)..suf
  end
  return tostring(value)
end
