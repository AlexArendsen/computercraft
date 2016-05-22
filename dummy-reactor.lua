-- Dummy Big Reactors Reactor, written by Alex Arendsen
-- Provides an identical interface to the in-game reactor
-- device, allowing for richer out-of-game development
-- and testing.
--
-- When you want to use your code in the game, simply
-- use the ReactorWrapper defined in reactor-wrapper
-- instead.

ReactorWrapper = {
  active = true,
  activelyCooled = false,
  rodLevels = {},
  rodNames = {},
  nRods = 1,
  tempFuel = 20,
  tempCasing = 20,
  amtEnergy = 810000,
  amtFuel = 63000,
  amtWaste = 1000,
  amtCoolant = 50000,
  maxFuel = 64000,
  maxWaste = 64000,
  maxCoolant = 100000,
  coolantType = "Liquid Ponies"
}

function ReactorWrapper:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  o:_addRod("Roddy McRoddington", 50)
  return o
end

function ReactorWrapper:getConnected()
  return true
end

function ReactorWrapper:getActive()
  return self.active
end

function ReactorWrapper:getNumberOfControlRods()
  return self.nrods
end

function ReactorWrapper:getFuelTemperature()
  self:_tickTemp()
  return self.tempFuel
end

function ReactorWrapper:getCasingTemperature()
  self:_tickTemp()
  return self.tempCasing
end

function ReactorWrapper:getFuelAmount()
  self:_tickFuel()
  return self.amtFuel
end

function ReactorWrapper:getWasteAmount()
  self:_tickFuel()
  return self.amtWaste
end

function ReactorWrapper:getFuelAmountMax()
  return self.maxFuel
end

function ReactorWrapper:getControlRodName(idx)
  return self.rodNames[idx]
end

function ReactorWrapper:getControlRodLevel(idx)
  return self.rodLevels[idx]
end

function ReactorWrapper:getEnergyStored()
  self:_tickEnergy()
  return self.amtEnergy
end

function ReactorWrapper:getEnergyProducedLastTick()
  amt = 0
  if self:getActive() == true then
    amt = 800
  end
  self.amtEnergy = self.amtEnergy + amt
  return amt
end

function ReactorWrapper:getHotFluidProducedLastTick()
  if self:isActivelyCooled() == false then
    return 0
  else
    return 500
  end
end

function ReactorWrapper:getCoolantType()
  return "Liquid Ponies"
end

function ReactorWrapper:getCoolantAmount()
  return 50000
end

function ReactorWrapper:getCoolantAmountMax()
  return 100000
end

function ReactorWrapper:getHotFluidType()
  return "Pressurized Rainbows"
end

function ReactorWrapper:getHotFluidAmount()
  return 50000
end

function ReactorWrapper:getHotFluidAmountMax()
  return 100000
end

function ReactorWrapper:getFuelReactivity()
  return 80
end

function ReactorWrapper:getFuelConsumedLastTick()
  return 500
end

function ReactorWrapper:isActivelyCooled()
  return self.activelyCooled
end

function ReactorWrapper:setActive(state)
  self.active = true
end

function ReactorWrapper:setAllControlRodLevels(level)
  for i=1,self.nRods do
    self.rodLevels[i] = level
  end
end

function ReactorWrapper:setControlRodLevel(idx, level)
  if idx > 0 and idx <= self.nRods then
    self.rodLevels[idx] = level
  end
end

function ReactorWrapper:doEjectWaste()
  self.amtWaste = 0
end

function ReactorWrapper:doEjectFuel()
  self.amtFuel = 0
end

function ReactorWrapper:getMinimumCoordinate()
  return 64, 64, 64
end

function ReactorWrapper:getMaximumCoordinate()
  return 69, 69, 69
end

function ReactorWrapper:_rand(lower, upper)
  return math.floor(math.random()*(upper-lower)) + lower
end

function ReactorWrapper:_addRod(name, level)
  self.rodLevels[self.nRods] = level
  self.rodNames[self.nRods] = name
  self.nRods = self.nRods + 1
end

function ReactorWrapper:_tickFuel()
  r = (self:_rand(1,10) / 20)
  if (self.amtFuel - r) > 0 then
    self.amtFuel = self.amtFuel - r
    self.amtWaste = self.amtWaste + r
  end
end

function ReactorWrapper:_tickTemp()
  if self:getActive() then
    if self.tempFuel < 8100 then
      self.tempFuel = self.tempFuel + 50
    end
    if self.tempCasing < 8100 then
      self.tempCasing = self.tempCasing + 50
    end
  else
    if self.tempFuel > 0 then
      self.tempFuel = self.tempFuel - 240
    else
      self.tempFuel = 0
    end
    if self.tempCasing > 0 then
      self.tempCasing = self.tempCasing - 240
    else
      self.tempCasing = 0
    end
  end
end

function ReactorWrapper:_tickEnergy()
  if self:getActive() then
    self.amtEnergy = self.amtEnergy + 800
  end
  self.amtEnergy = self.amtEnergy - (self:_rand(1,4) * 400)
  if self.amtEnergy < 0 then
    self.amtEnergy = 0
  end
end
