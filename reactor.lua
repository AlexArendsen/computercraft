-- My personal reactor display class. It uses the reactor wrapper
-- as a model, as well as my text-graphics library to accomplish
-- most of the output formatting

Reactor = {
  mon = {},
  gfx = {},
  rxr = {},
  ecurrent = 0,
  eprevious = 0,
  edifference= 0,
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
  self.ebuffer = CBuffer:new{size = 55}
  self.ecurrent = self.rxr:getEnergyStored()
  self.eprevious = self.ecurrent
end

function Reactor:draw()
  self:updateAmounts()

  --  Title
  self.mon:setCursorPos(8,1)
  self.mon:write("[REACTOR]")

  -- General Box
  self.gfx:box(1,3,20,2,"General")
  local stat = (self.rxr:getActive() and "ONLINE") or "Offline"
  self.gfx:label(2,4,"Status", stat, 20)
  self.gfx:label(2,5,"Casing", self.rxr:getCasingTemperature(), 20)

  -- Fuel and Waste Box
  self.gfx:box(23,1,33,4,"Fuel and Waste")
  self.gfx:label(24,2,"Temp", self.rxr:getFuelTemperature(),33)
  self.gfx:labeledHBar(24,3,"Fuel Amount", self.rxr:getFuelAmount(), self.rxr:getFuelAmountMax(), 33)
  self.gfx:label(24,5,"Waste Amount", self.rxr:getWasteAmount(), 33)

  -- Energy Box
  local title = "Energy ("..(self.mon:repr(self:getEnergyPercentage())).."%)"
  self.gfx:box(1,7,55,self.mheight-8,title)
  self.gfx:labeledHBar(2,8,"Amount Stored", self.ecurrent, 10000000, 55)

  self.ebuffer:add(self.edifference)
  self.gfx:timeline(2, 10, self.ebuffer, self.maxdelta, self.mindelta, 11)
  self.gfx:label(2, 21, "Delta", self.edifference, 55)
  self.gfx:label(2, 22, "Max Delta", self.maxdelta, 55)
  self.gfx:label(2, 23, "Min Delta", self.mindelta, 55)

  -- Update Reactor Status
  self:updateStatus()

end

function Reactor:updateAmounts()
  self.eprevious = self.ecurrent
  self.ecurrent = self.rxr:getEnergyStored()
  self.edifference = self.ecurrent - self.eprevious

  if self.edifference > self.maxdelta then
    self.maxdelta = math.max(self.edifference, 500)
  end

  if self.edifference < self.mindelta then
    self.mindelta = math.min(self.edifference, -500)
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
