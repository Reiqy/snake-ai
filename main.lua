local Map = require("map")
local Renderer = require("renderer")
local Snake = require("snake")
local helper = require("helper")
local map, renderer, snake
love.load = function(args)
  renderer = Renderer(30)
  local mapImageData = helper.load_map_data("maps/basic_map.png")
  map = Map(mapImageData)
  return renderer:set_map(map)
end
love.update = function(dt) end
love.draw = function()
  return renderer:draw()
end
