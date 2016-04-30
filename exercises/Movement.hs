import Graphics.Element exposing (show)
import List exposing (..)

--type Direction = Up | Down | Left | Right

type alias Model = {position : (Int, Int), facing : (Int, Int)}
--where facing (1,0) means facing right, (-1,0) means facing left, etc.

type alias Input = (Int, Int)

-- type alias Move = {x : Int, y : Int}

(.+) : (Int, Int) -> (Int, Int) -> (Int, Int)
(.+) (x,y) (z,w) = (x+z,y+w)

step : Input -> Model -> Model
step inp m = {position = m.position .+ inp, facing = inp}

