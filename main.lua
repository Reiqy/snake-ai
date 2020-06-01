local Game = require("game")
local game
love.load = function(args)
  game = Game(0.1)
  return game:start(true)
end
love.update = function(dt)
  return game:update(dt)
end
love.draw = function()
  return game:draw()
end
