local Treat
do
  local _class_0
  local _base_0 = {
    generate_treat_position = function(self)
      local possiblePositions = { }
      for i = 1, self.width do
        for j = 1, self.height do
          local possiblePoint = {
            x = i,
            y = j
          }
          if self.map:is_free(possiblePoint) and self.snake:is_not_part_of_body(possiblePoint) then
            table.insert(possiblePositions, possiblePoint)
          end
        end
      end
      return possiblePositions[love.math.random(1, #possiblePositions)]
    end,
    get_treat = function(self)
      return self.treat
    end,
    update = function(self, treatExists)
      if not treatExists then
        self.treat = self:generate_treat_position()
        return self.treat
      end
      return nil
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, map, snake)
      self.map = map
      self.width, self.height = self.map:get_dimensions()
      self.snake = snake
      self.treat = self:generate_treat_position()
    end,
    __base = _base_0,
    __name = "Treat"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Treat = _class_0
end
return Treat
