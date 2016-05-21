-- My textual graphics library for Computer Craft

TextGraphics = {
  mon = {}
}

function TextGraphics:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  return o
end

-- Prints out a label and a corresponding value
-- with in the given width
function TextGraphics:label (x,y,label, value, width)
  ox,oy = self.mon:getCursorPos()
  value = self.mon:repr(value)
  label = self.mon:repr(label)

  self.mon:setCursorPos(x,y)
  self.mon:write(label)
  self.mon:setCursorPos((x+width)-(value:len()), y)
  self.mon:write(value)

  self.mon:setCursorPos(ox,oy)
end

-- Makes a box out of underscores, pipes, and dashes,
-- and write a title along the top
function TextGraphics:box (x,y, width,height,title)
  ox,oy = self.mon:getCursorPos()
  width = width + 1
  height = height + 1

  for i=x+1,x+width-1 do
    self.mon:setCursorPos(i,y)
    self.mon:write("_")
    self.mon:setCursorPos(i,y+height)
    self.mon:write("-")
  end

  for i=y+1,y+height-1 do
    self.mon:setCursorPos(x,i)
    self.mon:write("|")
    self.mon:setCursorPos(x+width,i)
    self.mon:write("|")
  end

  self.mon:setCursorPos(x+2, y)
  self.mon:write(title)

  self.mon:setCursorPos(x,y)
end

-- Equivalent to writing a label on top of an hbar
function TextGraphics:labeledHBar(x, y, label, value, max, width)
  self.mon:setCursorPos(x,y)
  self:label(x,y,label, value, width)
  self.mon:setCursorPos(x,y+1)
  self:hbar(value, max, width)
  
end

-- Prints a horizontal "progress" bar, no label
function TextGraphics:hbar(value, max, width)
  step = max / width
  i = step
  while(i < value) do
    self.mon:write("|")
    i = i + step
  end
  while(i < max) do
    self.mon:write("_")
    i = i + step
  end
  end

-- Prints a vertical "progress" bar, no label
function TextGraphics:vbar(value, max, min, height)
  step = (max-min) / height
  ox,oy = self.mon:getCursorPos()
  i = max
  line = 0
  while(i > min) do
    self.mon:setCursorPos(ox,oy+line)
    if ((i > 0) == (i > value)) then
      self.mon:write(".")
    else
      self.mon:write("#")
    end
    line = line + 1
    i = i - step
  end
  self.mon:setCursorPos(ox,oy)
end

-- Uses a ciruclar buffer to create one frame of
-- a scrolling sequence of vertical bars.
function TextGraphics:timeline(x, y, cbuffer, max, min, height)
  ox,oy = self.mon:getCursorPos()
  self.mon:setCursorPos(x,y)
  for n in cbuffer:iter() do
    self:vbar(n, max, min, height)
    x = x + 1
    self.mon:setCursorPos(x,y)
  end
  self.mon:setCursorPos(ox,oy)
end
