local Map
do
  local _class_0
  local _base_0 = {
    convert_map_image_data_to_map_data = function(self, mapImageData)
      local mapData = { }
      self.width, self.height = mapImageData:getDimensions()
      for i = 0, (self.width - 1) do
        mapData[i + 1] = { }
        for j = 0, (self.height - 1) do
          local r, g, b, _ = mapImageData:getPixel(i, j)
          if (r == 0) and (g == 0) and (b == 0) then
            mapData[i + 1][j + 1] = 1
          else
            mapData[i + 1][j + 1] = 0
          end
        end
      end
      return mapData
    end,
    get_map = function(self)
      return self.map, self.width, self.height
    end,
    get_dimensions = function(self)
      return self.width, self.height
    end,
    is_free = function(self, point)
      if self.map[point.x][point.y] == 1 then
        return false
      end
      return true
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, mapImageData)
      self.width = nil
      self.height = nil
      self.map = self:convert_map_image_data_to_map_data(mapImageData)
    end,
    __base = _base_0,
    __name = "Map"
  }, {
    __index = _base_0,
    __call = function(cls, ...)
      local _self_0 = setmetatable({}, _base_0)
      cls.__init(_self_0, ...)
      return _self_0
    end
  })
  _base_0.__class = _class_0
  Map = _class_0
  return _class_0
end
