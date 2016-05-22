-- Big Reactors Computercraft Wrapper, written by Alex Arendsen

ReactorWrapper = {
  selector = "",
  rxr = {}
}

function ReactorWrapper:new(o)
  o = o or {}
  setmetatable(o,self)
  self.__index = self
  o.rxr = peripheral.wrap(o.selector)
  return o
end

function ReactorWrapper:getConnected()
  return self.rxr.getConnected()
end

function ReactorWrapper:getActive()
  return self.rxr.getActive()
end

function ReactorWrapper:getNumberOfControlRods()
  return self.rxr.getNumberOfControlRods()
end

function ReactorWrapper:getFuelTemperature()
  return self.rxr.getFuelTemperature()
end

function ReactorWrapper:getCasingTemperature()
  return self.rxr.getCasingTemperature()
end

function ReactorWrapper:getFuelAmount()
  return self.rxr.getFuelAmount()
end

function ReactorWrapper:getWasteAmount()
  return self.rxr.getWasteAmount()
end

function ReactorWrapper:getFuelAmountMax()
  return self.rxr.getFuelAmountMax()
end

function ReactorWrapper:getControlRodName(idx)
  return self.rxr.getControlRodName()
end

function ReactorWrapper:getControlRodLevel(idx)
  return self.rxr.getControlRodLevel()
end

function ReactorWrapper:getEnergyStored()
  return self.rxr.getEnergyStored()
end

function ReactorWrapper:getEnergyProducedLastTick()
  return self.rxr.getEnergyProducedLastTick()
end

function ReactorWrapper:getHotFluidProducedLastTick()
  return self.rxr.getHotFluidProducedLastTick()
end

function ReactorWrapper:getCoolantType()
  return self.rxr.getCoolantType()
end

function ReactorWrapper:getCoolantAmount()
  return self.rxr.getCoolantAmount()
end

function ReactorWrapper:getCoolantAmountMax()
  return self.rxr.getCoolantAmountMax()
end

function ReactorWrapper:getHotFluidType()
  return self.rxr.getHotFluidType()
end

function ReactorWrapper:getHotFluidAmount()
  return self.rxr.getHotFluidAmount()
end

function ReactorWrapper:getHotFluidAmountMax()
  return self.rxr.getHotFluidAmountMax()
end

function ReactorWrapper:getFuelReactivity()
  return self.rxr.getFuelReactivity()
end

function ReactorWrapper:getFuelConsumedLastTick()
  return self.rxr.getFuelConsumedLastTick()
end

function ReactorWrapper:isActivelyCooled()
  return self.rxr.isActivelyCooled()
end

function ReactorWrapper:setActive(state)
  self.rxr.setActive(state)
end

function ReactorWrapper:setAllControlRodLevels(level)
  self.rxr.setAllControlRodLevels(level)
end

function ReactorWrapper:setControlRodLevel(idx, level)
  self.rxr.setControlRodLevel(idx, level)
end

function ReactorWrapper:doEjectWaste()
  self.rxr.doEjectWaste()
end

function ReactorWrapper:doEjectFuel()
  self.rxr.doEjectFuel()
end

function ReactorWrapper:getMinimumCoordinate()
  return self.rxr.getMinimumCoordinate()
end

function ReactorWrapper:getMaximumCoordinate()
  return self.rxr.getMaximumCoordinate()
end
