class Renderer
  new: (scale) =>
    @map = nil
    @mapCanvas = nil
    @scale = scale

  set_map: (map) =>
    @map = map
    _, w, h = map\get_map()
    ww, wh, _ = love.window.getMode()
    if (w * @scale != ww) or (h * @scale != wh)
      love.window.setMode(w * @scale, h * @scale)

  predraw_map: (map) =>
    w, h, _ = love.window.getMode()
    @mapCanvas = love.graphics.newCanvas(w, h)

    love.graphics.setCanvas(@mapCanvas)

    love.graphics.clear()
    love.graphics.setBlendMode("alpha")
    @draw_map(map)

    love.graphics.setCanvas()

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

  draw_snake: (snake) =>
    snakeBody = snake\get_snake()

    love.graphics.setColor(0, 0, 0)

    for i, bodyPoint in ipairs(snakeBody)
      love.graphics.rectangle(
        "fill",
        (bodyPoint.x - 1) * @scale + 1,
        (bodyPoint.y - 1) * @scale + 1,
        @scale - 2,
        @scale - 2
      )

  draw_treat: (treat) =>
    love.graphics.setColor(0, 1, 0)

    love.graphics.rectangle(
      "fill",
      (treat.x - 1) * @scale + 1,
      (treat.y - 1) * @scale + 1,
      @scale - 2,
      @scale - 2
    )

  predraw: =>
    @predraw_map(@map)

  draw: (snake, treat) =>
    love.graphics.clear(1, 1, 1)
    love.graphics.setBlendMode("alpha", "premultiplied")
    love.graphics.draw(@mapCanvas, 0, 0)
    love.graphics.setBlendMode("alpha")

    @draw_treat(treat)
    @draw_snake(snake)

return Renderer
