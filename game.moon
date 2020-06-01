MAPS = love.filesystem.getDirectoryItems("maps")

print("Found maps:")
for i, map in ipairs(MAPS)
  print(map)

Map = require("map")
Renderer = require("renderer")
Snake = require("snake")
Treat = require("treat")

helper = require("helper")

class Game
  new: (tickTime) =>
    @renderer = Renderer(40)

    @map = nil
    @snake = nil
    @treat = nil

    @tickTime = tickTime

    @newTreat = nil

    @restartTimer = nil
    @restartK = nil

  load_random_map: =>
    randomNumber = love.math.random(#MAPS)
    print("Next map: " .. MAPS[randomNumber])
    return helper.load_map_data("maps/" .. MAPS[randomNumber])

  start: (first) =>
    if not first
      print("RESTART!")

    @mapImageData = @load_random_map()

    @map = Map(@mapImageData)
    @snake = Snake(@mapImageData, @tickTime, @map, self)
    @treat = Treat(@map, @snake)
    @snake\set_treat(@treat\get_treat())

    @renderer\set_map(@map)

    @renderer\predraw()

  restart: =>
    @restartTimer = 3
    @restartK = 3

  update: (dt) =>
    if not @restartTimer
      treatExists = @snake\update(dt, @newTreat)
      @newTreat = @treat\update(treatExists)
    else
      @restartTimer -= dt
      if (@restartTimer <= @restartK) and (@restartK != 0)
        print("Time to restart: " .. tostring(math.floor(@restartTimer + 0.5)))
        @restartK -= 1
      if @restartTimer <= 0
        @start(false)
        @restartTimer = nil

  draw: =>
    @renderer\draw(@snake, @treat\get_treat())
    love.graphics.setColor(1, 0, 0)
    love.graphics.print("FPS: " .. tostring(love.timer.getFPS()), 0, 0)
