DIRECTIONS = {
  {x: 1, y: 0}
  {x: 0, y: 1}
  {x: -1, y: 0}
  {x: 0, y: -1}
}

class Path
  new: =>
    @path = {}
    @length = 0
    @vector = {x: 0, y: 0}

  get_length: =>
    return @length

  get_theoretical_length: (fromPoint, toPoint) =>
    endPoint = @get_end_point(fromPoint)
    theoreticalRemainingDistance = math.abs(endPoint.x - toPoint.x) + math.abs(endPoint.y + toPoint.y)

    return @length + theoreticalRemainingDistance

  get_vector: =>
    return @vector

  get_next: =>
    if @length == 0
      return {x: 0, y: 0}
    @length -= 1
    @vector.x -= @path[1].x
    @vector.y -= @path[1].y
    return table.remove(@path, 1)

  get_end_point: (fromPoint) =>
    endPoint = {
      x: fromPoint.x + @vector.x,
      y: fromPoint.y + @vector.y
    }

    return endPoint

  add_direction: (direction) =>
    table.insert(@path, direction)
    @length += 1
    @vector.x += direction.x
    @vector.y += direction.y

  is_not_point_of_path: (fromPoint, point) =>
    testPoint = {
      x: fromPoint.x
      y: fromPoint.y
    }

    if (point.x == testPoint.x) and (point.y == testPoint.y)
      return false

    for i, direction in ipairs(@path)
      testPoint.x += direction.x
      testPoint.y += direction.y

      if (point.x == testPoint.x) and (point.y == testPoint.y)
        return false

    return true

  copy: =>
    path = Path()
    for i, direction in ipairs(@path)
      path\add_direction(direction)

    return path

class Astar
  new: (map, snake) =>
    @map = map
    @snake = snake

  navigate: (fromPoint, toPoint) =>

    paths = {Path()}

    while next(paths) != nil
      shortestPathLength = nil
      shortestPathIndex = nil
      for i, path in ipairs(paths)
        if shortestPathLength
          if path\get_theoretical_length(fromPoint, toPoint) < shortestPathLength
            shortestPathIndex = i
        else
          shortestPathIndex = i
          shortestPathLength = path\get_theoretical_length(fromPoint, toPoint)

      shortestPath = table.remove(paths, shortestPathIndex)

      shortestPathVector = shortestPath\get_vector()
      shortestPathEndPoint = shortestPath\get_end_point(fromPoint)

      if (shortestPathEndPoint.x == toPoint.x) and (shortestPathEndPoint.y == toPoint.y)
        return shortestPath

      for i, direction in ipairs(DIRECTIONS)
        newEndPoint = {
          x: shortestPathEndPoint.x + direction.x,
          y: shortestPathEndPoint.y + direction.y
        }

        if @map\is_free(newEndPoint) and @snake\is_not_part_of_body(newEndPoint) and shortestPath\is_not_point_of_path(fromPoint, newEndPoint)
          newPath = shortestPath\copy()
          newPath\add_direction(direction)

          addPath = true
          for i, path in ipairs(paths)
            pathEndPoint = path\get_end_point(fromPoint)
            if (pathEndPoint.x == newEndPoint.x) and (pathEndPoint.y == newEndPoint.y)
              if newPath\get_length() < path\get_length()
                table.remove(paths, i)
              else
                addPath = false
                break

          if addPath
            table.insert(paths, newPath)

    return nil

return Astar
