class Snake
  new: (mapImageData) =>
    @snake = generate_snake_from_map_image_data(mapImageData)

  generate_snake_from_map_image_data: (mapImageData) =>
    return snake, direction

return Snake
