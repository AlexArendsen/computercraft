-- Super lightweight circular buffer for Lua
-- by Alex Arendsen

CBuffer = {
  size = 0,
  write = 1,
  items = {}
}

-- Constructor
function CBuffer:new (o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

-- Adds an element to the buffer
function CBuffer:add (i)
  self.items[self.write] = i
  self.write = self.write + 1
  if self.write > self.size then
    self.write = 1
  end
end

-- Buffer iterator factory function.
function CBuffer:iter ()
  local i = self.write
  local stop = false
  return function()
           i = i - 1
           if i < 1 then
             i = self.size
           end
           if stop == true then
             return nil
           end
           if i == self.write then
             stop = true
           end
           return self.items[i]
         end
end
