Game = require("game")

local game

love.load = (args) ->
  game = Game(0.1)
  game\start(true)

love.update = (dt) ->
  game\update(dt)

love.draw = ->
  game\draw()
