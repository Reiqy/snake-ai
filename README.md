# Snake AI

AStar based Snake AI agent running on Löve2D framework.

The code is written in [MoonScript](https://moonscript.org/) -- dynamic scripting language that compiles into Lua. It is highly recommended to read only *.moon files because exported *.lua files tend to be harder to read.

The main part of the project (pathfinding algorithm) is implemented in astar.moon file. Other files provide functionality necessary to display Snake.

After running the project, it chooses one of the maps from maps folder randomly and starts navigating the snake from one treat to another. If the snake blocks itself and the agent is unable to find path to next treat, the project resets automatically after a while and chooses a new map.

Snake only considers his own body in the moment of evaluation, that means he cannot move to unblock the path. While this could be implemented, the implications of this approach are quite complicated. For example you have to store number of previous moves in addition to the head position in the state space, which means that you navigate in 3 dimensional space. Also the shortest path is no longer the best path and heuristic might need to be adjusted.

## Running the Project

To run the project, Löve2D interpreter is required and can be downloaded from [the website](https://love2d.org/#download).

After installing the interpreter, the code can be run by calling
```
$ love .
```
in the project folder.

Keep in mind that love.exe usually needs to be added to PATH manually.
