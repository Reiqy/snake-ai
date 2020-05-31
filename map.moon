class Map
  new: (mapImageData) =>
    @width = nil
    @height = nil
    @map = @convert_map_image_data_to_map_data(mapImageData)

  convert_map_image_data_to_map_data: (mapImageData) =>
    mapData = {}

    @width, @height = mapImageData\getDimensions()

    for i = 0, (@width - 1)
      mapData[i + 1] = {}
      for j = 0, (@height - 1)
        r, g, b, _ = mapImageData\getPixel(i, j)

        if (r == 0) and (g == 0) and (b == 0)
          mapData[i + 1][j + 1] = 1
        else
          mapData[i + 1][j + 1] = 0

    return mapData

  get_map: =>
    return @map, @width, @height
