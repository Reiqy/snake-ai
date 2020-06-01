local Astar = require("astar")
local Snake
do
  local _class_0
  local _base_0 = {
    generate_snake_from_map_image_data = function(self, mapImageData)
      local snake = { }
      local direction = { }
      local w, h = mapImageData:getDimensions()
      local startingPoint = { }
      for i = 0, (w - 1) do
        for j = 0, (h - 1) do
          local r, g, b, _ = mapImageData:getPixel(i, j)
          if (r == 0) and (g == 1) and (b == 0) then
            startingPoint.x, startingPoint.y = i + 1, j + 1
            break
          end
        end
      end
      local usedPoints = { }
      usedPoints[startingPoint.x * w + startingPoint.y] = true
      local headPoint = { }
      for i, point in ipairs(self:get_neighbour_points(startingPoint)) do
        local r, g, b, _ = mapImageData:getPixel(point.x - 1, point.y - 1)
        if (r == 1) and (g == 0) and (b == 0) then
          headPoint.x, headPoint.y = point.x, point.y
          usedPoints[headPoint.x * w + headPoint.y] = true
          break
        end
      end
      direction.x = startingPoint.x - headPoint.x
      direction.y = startingPoint.y - headPoint.y
      table.insert(snake, headPoint)
      local search = true
      local actualPoint = headPoint
      while search do
        for i, point in ipairs(self:get_neighbour_points(actualPoint)) do
          if not (usedPoints[point.x * w + point.y]) then
            local r, g, b, _ = mapImageData:getPixel(point.x - 1, point.y - 1)
            if (r == 0) and (g == 0) and (b == 1) then
              table.insert(snake, point)
              usedPoints[point.x * w + point.y] = true
              actualPoint = point
              search = true
              break
            else
              search = false
            end
          end
        end
      end
      return snake, direction
    end,
    get_neighbour_points = function(self, point)
      local points = {
        {
          x = point.x + 1,
          y = point.y
        },
        {
          x = point.x - 1,
          y = point.y
        },
        {
          x = point.x,
          y = point.y + 1
        },
        {
          x = point.x,
          y = point.y - 1
        }
      }
      return points
    end,
    is_not_part_of_body = function(self, point)
      for i, bodyPoint in ipairs(self.snake) do
        if (point.x == bodyPoint.x) and (point.y == bodyPoint.y) then
          return false
        end
      end
      return true
    end,
    get_snake = function(self)
      return self.snake
    end,
    update = function(self, dt, newTreat)
      local treatExists = true
      self.movementTickTimer = self.movementTickTimer + dt
      if newTreat then
        self:set_treat(newTreat)
      end
      if self.movementTickTimer >= self.tickTime then
        if self.path then
          self:move_along_path(self.path)
          local lastSnakePoint = self:move(self.direction)
          if (self.snake[1].x == self.treat.x) and (self.snake[1].y == self.treat.y) then
            table.insert(self.snake, lastSnakePoint)
            treatExists = false
          end
        else
          print("There's no path from my point of view")
          if self.game then
            self.game:restart()
          end
        end
        self.movementTickTimer = self.movementTickTimer - self.tickTime
      end
      return treatExists
    end,
    move = function(self, direction)
      if (direction.x == 0) and (direction.y == 0) then
        return nil
      end
      local point = { }
      point.x = self.snake[1].x
      point.y = self.snake[1].y
      self.snake[1].x = self.snake[1].x + direction.x
      self.snake[1].y = self.snake[1].y + direction.y
      for i, bodyPoint in ipairs(self.snake) do
        local _continue_0 = false
        repeat
          if i == 1 then
            _continue_0 = true
            break
          end
          local savePoint = { }
          savePoint.x = bodyPoint.x
          savePoint.y = bodyPoint.y
          bodyPoint.x = point.x
          bodyPoint.y = point.y
          point.x = savePoint.x
          point.y = savePoint.y
          _continue_0 = true
        until true
        if not _continue_0 then
          break
        end
      end
      return point
    end,
    move_along_path = function(self, path)
      self.direction = path:get_next()
    end,
    set_treat = function(self, treat)
      self.treat = treat
      self.path = self.astar:navigate(self.snake[1], self.treat)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, mapImageData, tickTime, map, game)
      self.snake, self.direction = self:generate_snake_from_map_image_data(mapImageData)
      self.movementTickTimer = 0
      self.tickTime = tickTime
      self.astar = Astar(map, self)
      self.treat = nil
      self.path = nil
      self.game = game
    end,
    __base = _base_0,
    __name = "Snake"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Snake = _class_0
end
return Snake
