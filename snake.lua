local Snake
do
  local _class_0
  local _base_0 = {
    generate_snake_from_map_image_data = function(self, mapImageData)
      return snake, direction
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, mapImageData)
      self.snake = generate_snake_from_map_image_data(mapImageData)
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
