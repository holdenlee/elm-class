import Graphics.Element exposing (show)
import List exposing (..)

--type Direction = Up | Down | Left | Right

type alias State = {position : (Int, Int), facing : (Int, Int)}
--where facing (1,0) means facing right, (-1,0) means facing left, etc.

type alias Move = (Int, Int)

-- type alias Move = {x : Int, y : Int}

(.+) : (Int, Int) -> (Int, Int) -> (Int, Int)
(.+) (x,y) (z,w) = (x+z,y+w)

update : Move -> State -> State
update m s = {position = s.position .+ m, facing = m}
-- {x = s.x + m.x, y = s.x + m.y, facing = 
-- {s | x = s.x + m.x, y = s.x + m.y, facing = }
