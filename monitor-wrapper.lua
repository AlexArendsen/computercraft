-- Computercraft Monitor Wrapper, written by Alex Arendsen

MonitorWrapper = {
  selector = "top"
}

function MonitorWrapper:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  o.mon = peripheral.wrap(o.selector)
  return o
end

function MonitorWrapper:write (str)
  self.mon.write(str)
end

function MonitorWrapper:blit (str, colors, background)
  self.mon.blit(str,color,background)
end

function MonitorWrapper:clear()
  self.mon.clear()
end

function MonitorWrapper:clearLine()
  self.mon.clearLine()
end

function MonitorWrapper:getCursorPos()
  return self.mon.getCursorPos()
end

function MonitorWrapper:setCursorPos(x,y)
  self.mon.setCursorPos(x,y)
end

function MonitorWrapper:setCursorBlink(state)
  self.mon.setCursorBlink(state)
end

function MonitorWrapper:isColor()
  return self.mon.isColor()
end

function MonitorWrapper:getSize()
  return self.mon.getSize()
end

function MonitorWrapper:scroll(amount)
  self.mon.scroll(amount)
end

function MonitorWrapper:redirect(target)
  self.mon.redirect(target)
end

function MonitorWrapper:current()
  return self.mon.current()
end

function MonitorWrapper:native()
  return self.mon.native()
end

function MonitorWrapper:setTextColor(color)
  self.mon.setTextColor(color)
end

function MonitorWrapper:getTextColor()
  return self.mon.getTextColor()
end

function MonitorWrapper:setBackgroundColor(color)
  self.mon.setBackgroundColor(color)
end

function MonitorWrapper:getBackgroundColor()
  return self.mon.getBackgroundColor()
end

function MonitorWrapper:setTextScale(scale)
  self.mon.setTextScale(scale)
end

-- Wrapper-specific methods

function MonitorWrapper:draw()
  -- Leaving in for fewer bugs
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
