local h = { }
h.load_map_data = function(filename)
  return love.image.newImageData(filename)
end
return h
