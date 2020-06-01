local DIRECTIONS = {
  {
    x = 1,
    y = 0
  },
  {
    x = 0,
    y = 1
  },
  {
    x = -1,
    y = 0
  },
  {
    x = 0,
    y = -1
  }
}
local Path
do
  local _class_0
  local _base_0 = {
    get_length = function(self)
      return self.length
    end,
    get_theoretical_length = function(self, fromPoint, toPoint)
      local endPoint = self:get_end_point(fromPoint)
      local theoreticalRemainingDistance = math.abs(endPoint.x - toPoint.x) + math.abs(endPoint.y + toPoint.y)
      return self.length + theoreticalRemainingDistance
    end,
    get_vector = function(self)
      return self.vector
    end,
    get_next = function(self)
      if self.length == 0 then
        return {
          x = 0,
          y = 0
        }
      end
      self.length = self.length - 1
      self.vector.x = self.vector.x - self.path[1].x
      self.vector.y = self.vector.y - self.path[1].y
      return table.remove(self.path, 1)
    end,
    get_end_point = function(self, fromPoint)
      local endPoint = {
        x = fromPoint.x + self.vector.x,
        y = fromPoint.y + self.vector.y
      }
      return endPoint
    end,
    add_direction = function(self, direction)
      table.insert(self.path, direction)
      self.length = self.length + 1
      self.vector.x = self.vector.x + direction.x
      self.vector.y = self.vector.y + direction.y
    end,
    is_not_point_of_path = function(self, fromPoint, point)
      local testPoint = {
        x = fromPoint.x,
        y = fromPoint.y
      }
      if (point.x == testPoint.x) and (point.y == testPoint.y) then
        return false
      end
      for i, direction in ipairs(self.path) do
        testPoint.x = testPoint.x + direction.x
        testPoint.y = testPoint.y + direction.y
        if (point.x == testPoint.x) and (point.y == testPoint.y) then
          return false
        end
      end
      return true
    end,
    copy = function(self)
      local path = Path()
      for i, direction in ipairs(self.path) do
        path:add_direction(direction)
      end
      return path
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self)
      self.path = { }
      self.length = 0
      self.vector = {
        x = 0,
        y = 0
      }
    end,
    __base = _base_0,
    __name = "Path"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Path = _class_0
end
local Astar
do
  local _class_0
  local _base_0 = {
    navigate = function(self, fromPoint, toPoint)
      local paths = {
        Path()
      }
      while next(paths) ~= nil do
        local shortestPathLength = nil
        local shortestPathIndex = nil
        for i, path in ipairs(paths) do
          if shortestPathLength then
            if path:get_theoretical_length(fromPoint, toPoint) < shortestPathLength then
              shortestPathIndex = i
            end
          else
            shortestPathIndex = i
            shortestPathLength = path:get_theoretical_length(fromPoint, toPoint)
          end
        end
        local shortestPath = table.remove(paths, shortestPathIndex)
        local shortestPathVector = shortestPath:get_vector()
        local shortestPathEndPoint = shortestPath:get_end_point(fromPoint)
        if (shortestPathEndPoint.x == toPoint.x) and (shortestPathEndPoint.y == toPoint.y) then
          return shortestPath
        end
        for i, direction in ipairs(DIRECTIONS) do
          local newEndPoint = {
            x = shortestPathEndPoint.x + direction.x,
            y = shortestPathEndPoint.y + direction.y
          }
          if self.map:is_free(newEndPoint) and self.snake:is_not_part_of_body(newEndPoint) and shortestPath:is_not_point_of_path(fromPoint, newEndPoint) then
            local newPath = shortestPath:copy()
            newPath:add_direction(direction)
            local addPath = true
            for i, path in ipairs(paths) do
              local pathEndPoint = path:get_end_point(fromPoint)
              if (pathEndPoint.x == newEndPoint.x) and (pathEndPoint.y == newEndPoint.y) then
                if newPath:get_length() < path:get_length() then
                  table.remove(paths, i)
                else
                  addPath = false
                  break
                end
              end
            end
            if addPath then
              table.insert(paths, newPath)
            end
          end
        end
      end
      return nil
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, map, snake)
      self.map = map
      self.snake = snake
    end,
    __base = _base_0,
    __name = "Astar"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Astar = _class_0
end
return Astar
