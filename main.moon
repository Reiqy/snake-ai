Map = require("map")
Renderer = require("renderer")
Snake = require("snake")

helper = require("helper")

local map, renderer, snake

love.load = (args) ->
  renderer = Renderer(30)

  mapImageData = helper.load_map_data("maps/basic_map.png")

  map = Map(mapImageData)

  renderer\set_map(map)

love.update = (dt) ->

love.draw = ->
  renderer\draw()
