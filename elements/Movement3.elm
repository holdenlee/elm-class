import Char exposing (..)
import Color exposing (..)
import Keyboard exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Signal as S
import Time exposing (..)
import List exposing (..) 
import Graphics.Input exposing (..)

--MODEL
type alias Model = {position : Vector, facing : Vector}
--where facing (1,0) means facing right, (-1,0) means facing left, etc.

start : Model
start = {position = {x=0,y=0}, facing = {x=1,y=0}}

type alias Vector = {x : Int, y : Int}

h = 11
w = 11
unit = 30

--UPDATE
update : Input -> Model -> Model
update inp m = {position = m.position .+ inp, facing = if inp=={x=0,y=0} then m.facing else inp}

(.+) : Vector -> Vector -> Vector
(.+) v1 v2 = {x=clamp -5 5 <| v1.x + v2.x, y=clamp -5 5 <| v1.y + v2.y}

--VIEW
render : Model -> Element
render m = 
    let 
        pic = case (m.facing.x, m.facing.y) of
                (0,1) ->  peteUp
                (-1,0) -> peteLeft
                (0,-1) -> peteDown
                _ -> peteRight
    in
      collage (w*unit) (h*unit) 
        [rect (toFloat (w*unit)) (toFloat (h*unit)) |> filled black,
         pic |> toForm |> move (toFloat <| m.position.x*unit, toFloat <| m.position.y*unit)]

--SIGNAL

type alias Input = {x : Int, y : Int}

input : Signal Input
input = arrows

main = S.map render (S.foldp update start input)

pics = "https://dl.dropboxusercontent.com/u/27883775/code/imgs/iceblox.gif"

peteUp = croppedImage (150,0) 30 30 pics
peteLeft = croppedImage (210,0) 30 30 pics
peteDown = croppedImage (60,0) 30 30 pics
peteRight = croppedImage (120,30) 30 30 pics