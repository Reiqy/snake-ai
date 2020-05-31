class Renderer
  new: (scale) =>
    @map = nil
    @scale = scale

  set_map: (map) =>
    @map = map

  draw_map: (map) =>

    mapData, width, height = map\get_map()

    love.graphics.setColor(0, 0, 0)

    for i = 1, width
      for j = 1, height
        if (mapData[i][j] == 1)
          love.graphics.rectangle(
            "fill",
            (i - 1) * @scale,
            (j - 1) * @scale,
            @scale,
            @scale
          )

  draw: =>
    love.graphics.clear(1, 1, 1)
    @draw_map(@map)

return Renderer
