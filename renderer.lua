local Renderer
do
  local _class_0
  local _base_0 = {
    set_map = function(self, map)
      self.map = map
    end,
    draw_map = function(self, map)
      local mapData, width, height = map:get_map()
      love.graphics.setColor(0, 0, 0)
      for i = 1, width do
        for j = 1, height do
          if (mapData[i][j] == 1) then
            love.graphics.rectangle("fill", (i - 1) * self.scale, (j - 1) * self.scale, self.scale, self.scale)
          end
        end
      end
    end,
    draw = function(self)
      love.graphics.clear(1, 1, 1)
      return self:draw_map(self.map)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, scale)
      self.map = nil
      self.scale = scale
    end,
    __base = _base_0,
    __name = "Renderer"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Renderer = _class_0
end
return Renderer
