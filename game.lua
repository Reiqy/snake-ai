local MAPS = love.filesystem.getDirectoryItems("maps")
print("Found maps:")
for i, map in ipairs(MAPS) do
  print(map)
end
local Map = require("map")
local Renderer = require("renderer")
local Snake = require("snake")
local Treat = require("treat")
local helper = require("helper")
local Game
do
  local _class_0
  local _base_0 = {
    load_random_map = function(self)
      local randomNumber = love.math.random(#MAPS)
      print("Next map: " .. MAPS[randomNumber])
      return helper.load_map_data("maps/" .. MAPS[randomNumber])
    end,
    start = function(self, first)
      if not first then
        print("RESTART!")
      end
      self.mapImageData = self:load_random_map()
      self.map = Map(self.mapImageData)
      self.snake = Snake(self.mapImageData, self.tickTime, self.map, self)
      self.treat = Treat(self.map, self.snake)
      self.snake:set_treat(self.treat:get_treat())
      self.renderer:set_map(self.map)
      return self.renderer:predraw()
    end,
    restart = function(self)
      self.restartTimer = 3
      self.restartK = 3
    end,
    update = function(self, dt)
      if not self.restartTimer then
        local treatExists = self.snake:update(dt, self.newTreat)
        self.newTreat = self.treat:update(treatExists)
      else
        self.restartTimer = self.restartTimer - dt
        if (self.restartTimer <= self.restartK) and (self.restartK ~= 0) then
          print("Time to restart: " .. tostring(math.floor(self.restartTimer + 0.5)))
          self.restartK = self.restartK - 1
        end
        if self.restartTimer <= 0 then
          self:start(false)
          self.restartTimer = nil
        end
      end
    end,
    draw = function(self)
      self.renderer:draw(self.snake, self.treat:get_treat())
      love.graphics.setColor(1, 0, 0)
      return love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 0, 0)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, tickTime)
      self.renderer = Renderer(40)
      self.map = nil
      self.snake = nil
      self.treat = nil
      self.tickTime = tickTime
      self.newTreat = nil
      self.restartTimer = nil
      self.restartK = nil
    end,
    __base = _base_0,
    __name = "Game"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Game = _class_0
  return _class_0
end
