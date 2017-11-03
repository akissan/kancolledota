-- This is the entry-point to your game mode and should be used primarily to precache models/particles/sounds/etc



require('internal/util')
require('gamemode')


function Activate()
  GameRules.GameMode = GameMode()
  GameRules.GameMode:_InitGameMode()
end