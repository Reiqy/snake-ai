local Renderer
do
  local _class_0
  local _base_0 = {
    set_map = function(self, map)
      self.map = map
      local _, w, h = map:get_map()
      local ww, wh
      ww, wh, _ = love.window.getMode()
      if (w * self.scale ~= ww) or (h * self.scale ~= wh) then
        return love.window.setMode(w * self.scale, h * self.scale)
      end
    end,
    predraw_map = function(self, map)
      local w, h, _ = love.window.getMode()
      self.mapCanvas = love.graphics.newCanvas(w, h)
      love.graphics.setCanvas(self.mapCanvas)
      love.graphics.clear()
      love.graphics.setBlendMode("alpha")
      self:draw_map(map)
      return love.graphics.setCanvas()
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
    draw_snake = function(self, snake)
      local snakeBody = snake:get_snake()
      love.graphics.setColor(0, 0, 0)
      for i, bodyPoint in ipairs(snakeBody) do
        love.graphics.rectangle("fill", (bodyPoint.x - 1) * self.scale + 1, (bodyPoint.y - 1) * self.scale + 1, self.scale - 2, self.scale - 2)
      end
    end,
    draw_treat = function(self, treat)
      love.graphics.setColor(0, 1, 0)
      return love.graphics.rectangle("fill", (treat.x - 1) * self.scale + 1, (treat.y - 1) * self.scale + 1, self.scale - 2, self.scale - 2)
    end,
    predraw = function(self)
      return self:predraw_map(self.map)
    end,
    draw = function(self, snake, treat)
      love.graphics.clear(1, 1, 1)
      love.graphics.setBlendMode("alpha", "premultiplied")
      love.graphics.draw(self.mapCanvas, 0, 0)
      love.graphics.setBlendMode("alpha")
      self:draw_treat(treat)
      return self:draw_snake(snake)
    end
  }
  _base_0.__index = _base_0
  _class_0 = setmetatable({
    __init = function(self, scale)
      self.map = nil
      self.mapCanvas = nil
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
