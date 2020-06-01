class Treat
  new: (map, snake) =>
    @map = map
    @width, @height = @map\get_dimensions()
    @snake = snake

    @treat = @generate_treat_position()

  generate_treat_position: =>
    possiblePositions = {}

    for i = 1, @width
      for j = 1, @height
        possiblePoint = {
          x: i
          y: j
        }
        if @map\is_free(possiblePoint) and @snake\is_not_part_of_body(possiblePoint)
          table.insert(possiblePositions, possiblePoint)

    return possiblePositions[love.math.random(1, #possiblePositions)]

  get_treat: =>
    return @treat

  update: (treatExists) =>
    if not treatExists
      @treat = @generate_treat_position()
      return @treat
    return nil

return Treat
