-- My personal reactor display class. It uses the reactor wrapper
-- as a model, as well as my text-graphics library to accomplish
-- most of the output formatting

Reactor = {
  mon = {},
  gfx = {},
  rxr = {},
  ecurrent = 0,
  eprevious = 0,
  edifferene= 0,
  ebuffer = {},
  maxdelta = 500,
  mindelta = -500,
  mwidth = 0,
  mheight = 0
}

function Reactor:new(o)
  o = o or {}
  setmetatable(o, self)
  self.__index = self
  if CBuffer == nil then
    dofile("disk/cbuffer")
  end
  o:init()
  return o
end

function Reactor:init()
  self.mwidth, self.mheight = self.mon:getSize()
  self.ebuffer = CBuffer:new{size = 29}
end

function Reactor:draw()
  self:updateAmounts()

  leftWidth = 24

  -- General Box
  self.gfx:box(1,1,leftWidth,1,"General")
  local stat = "Offline"
  if self.rxr:getActive() then
    stat = "ONLINE"
  end
  self.gfx:label(2,2,"Status", stat, leftWidth)

  -- Fuel and Waste Box
  self.gfx:box(1,6,leftWidth,5,"Fuel and Waste")
  self.gfx:label(2,7,"Temp:", self.rxr:getFuelTemperature(),leftWidth)
  self.gfx:labeledHBar(2,8,"Fuel Amount:", self.rxr:getFuelAmount(), self.rxr:getFuelAmountMax(), leftWidth)
  self.gfx:label(2,10,"Waste Amount:", self.rxr:getWasteAmount(), leftWidth)

  -- Energy Box
  leftMargin = leftWidth + 3
  centerWidth = self.mwidth - leftWidth - 4
  title = "Energy ("..(self.mon:repr(self:getEnergyPercentage())).."%)"

  self.gfx:box(leftMargin,1,centerWidth,16,title)
  self.gfx:labeledHBar(leftMargin+1,2,"In Buffer:", self.ecurrent, 10000000, centerWidth)

  self.gfx:label(leftMargin+1, 4, "Delta: ", self.edifference, centerWidth)

  self.ebuffer:add(self.edifference)
  self.gfx:timeline(leftMargin+1, 5, self.ebuffer, self.maxdelta, self.mindelta, 11)
  self.gfx:label(leftMargin+1, 17, "Max: ", self.maxdelta, 13)
  self.gfx:label(leftMargin+16, 17, "Min: ", self.mindelta, 14)


end

function Reactor:updateAmounts()
  self.eprevious = self.ecurrent
  self.ecurrent = self.rxr:getEnergyStored()
  self.edifference = self.ecurrent - self.eprevious

  if self.edifference > self.maxdelta then
    self.maxdelta = self.edifference
  end

  if self.edifference < self.mindelta then
    self.mindelta = self.edifference
  end
end

function Reactor:updateStatus()
  state = self.rxr:getActive()
  if state == false and self:getEnergyPercentage() < 20 then
    self.rxr:setActive(true)
  elseif state == true and self:getEnergyPercentage() > 80 then
    self.rxr:setActive(false)
  end
end

function Reactor:getEnergyPercentage()
  return math.floor(100*(self.ecurrent/10000000))
end
