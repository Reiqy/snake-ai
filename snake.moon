Astar = require("astar")

class Snake
  new: (mapImageData, tickTime, map, game) =>
    @snake, @direction = @generate_snake_from_map_image_data(mapImageData)
    @movementTickTimer = 0
    @tickTime = tickTime
    @astar = Astar(map, self)
    @treat = nil
    @path = nil

    @game = game

  generate_snake_from_map_image_data: (mapImageData) =>
    snake = {}
    direction = {}

    w, h = mapImageData\getDimensions()

    startingPoint = {}

    for i = 0, (w - 1)
      for j = 0, (h - 1)
        r, g, b, _ = mapImageData\getPixel(i, j)

        if (r == 0) and (g == 1) and (b == 0)
          startingPoint.x, startingPoint.y = i + 1, j + 1
          break

    usedPoints = {}
    usedPoints[startingPoint.x * w + startingPoint.y] = true

    headPoint = {}

    for i, point in ipairs(@get_neighbour_points(startingPoint))
      r, g, b, _ = mapImageData\getPixel(point.x - 1, point.y - 1)

      if (r == 1) and (g == 0) and (b == 0)
        headPoint.x, headPoint.y = point.x, point.y
        usedPoints[headPoint.x * w + headPoint.y] = true
        break

    direction.x = startingPoint.x - headPoint.x
    direction.y = startingPoint.y - headPoint.y

    table.insert(snake, headPoint)

    search = true
    actualPoint = headPoint
    while search
      for i, point in ipairs(@get_neighbour_points(actualPoint))
        if not (usedPoints[point.x * w + point.y])
          r, g, b, _ = mapImageData\getPixel(point.x - 1, point.y - 1)

          if (r == 0) and (g == 0) and (b == 1)
            table.insert(snake, point)
            usedPoints[point.x * w + point.y] = true
            actualPoint = point
            search = true
            break
          else
            search = false

    return snake, direction

  get_neighbour_points: (point) =>
    points = {
      {x: point.x + 1, y: point.y},
      {x: point.x - 1, y: point.y},
      {x: point.x, y: point.y + 1},
      {x: point.x, y: point.y - 1}
    }

    return points

  is_not_part_of_body: (point) =>
    for i, bodyPoint in ipairs(@snake)
      if (point.x == bodyPoint.x) and (point.y == bodyPoint.y)
        return false
    return true

  get_snake: =>
    return @snake

  update: (dt, newTreat) =>
    treatExists = true
    @movementTickTimer += dt

    if newTreat
      @set_treat(newTreat)

    if @movementTickTimer >= @tickTime
      if @path
        @move_along_path(@path)
        lastSnakePoint = @move(@direction)
        if (@snake[1].x == @treat.x) and (@snake[1].y == @treat.y)
          table.insert(@snake, lastSnakePoint)
          treatExists = false
      else
        print("There's no path from my point of view")
        if @game
          @game\restart()
      @movementTickTimer -= @tickTime

    return treatExists

  move: (direction) =>
    if (direction.x == 0) and (direction.y == 0)
      return nil

    point = {}
    point.x = @snake[1].x
    point.y = @snake[1].y
    @snake[1].x += direction.x
    @snake[1].y += direction.y

    for i, bodyPoint in ipairs(@snake)
      if i == 1
        continue
      savePoint = {}
      savePoint.x = bodyPoint.x
      savePoint.y = bodyPoint.y
      bodyPoint.x = point.x
      bodyPoint.y = point.y
      point.x = savePoint.x
      point.y = savePoint.y

    return point

  move_along_path: (path) =>
    @direction = path\get_next()

  set_treat: (treat) =>
    @treat = treat
    @path = @astar\navigate(@snake[1], @treat)

return Snake
