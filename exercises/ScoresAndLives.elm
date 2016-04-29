import Graphics.Element exposing (show)
import List exposing (..)

type Event = GetScore Int | LoseLife

events : List Event
events = [GetScore 10, GetScore 20, LoseLife, LoseLife, GetScore 10, LoseLife, GetScore 10]

type alias Game = {score : Int, lives : Int}

update : Event -> Game -> Game
update u g = 
  if g.lives<=0
  then g
  else case u of
    GetScore x -> {g | score = g.score + x}
    LoseLife -> {g | lives = g.lives - 1}

gameStart : Game
gameStart = {score = 0, lives = 3}

playGame : List Event -> Game
playGame = foldl update gameStart

-- Exercise 1: Add a Restart event. When you restart, your score goes to 0, and your lives resets to 3.
-- Exercise 2: Add a hiscore field to Game. When score exceeds hiscore, replace hiscore by score.

