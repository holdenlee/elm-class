import Graphics.Element exposing (show)
import List exposing (..)

--type Direction = Up | Down | Left | Right

type alias Model = {position : Vector, facing : Vector}
--where facing (1,0) means facing right, (-1,0) means facing left, etc.

type alias Vector = {x : Int, y : Int}

type alias Input = {x : Int, y : Int}

(.+) : Vector -> Vector -> Vector
(.+) v1 v2 = {x=v1.x + v2.x, y=v1.y + v2.y}

update : Input -> Model -> Model
update inp m = {position = m.position .+ inp, facing = inp}

finalPos : List Input -> Model
finalPos = foldl update {position = {x=0,y=0}, facing = {x=1,y=0}}

main = show (finalPos [{x=1,y=0},{x=1,y=0},{x=0,y=1}])
