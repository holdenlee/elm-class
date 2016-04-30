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

h = 10
w = 10
unit = 30

--UPDATE
update : Input -> Model -> Model
update inp m = {position = m.position .+ inp, facing = inp}

(.+) : Vector -> Vector -> Vector
(.+) v1 v2 = {x=clamp 0 9 <| v1.x + v2.x, y=clamp 0 9 <| v1.y + v2.y}

--VIEW
render : Model -> Element
render m = container (w*unit) (h*unit) 
           (bottomLeftAt (absolute <| m.position.x*unit) (absolute <| m.position.y*unit))
           (image 30 30 "https://dl.dropboxusercontent.com/u/27883775/code/imgs/pete.gif")

-- show m

--SIGNAL

type alias Input = {x : Int, y : Int}

input : Signal Input
input = arrows
-- S.map keyCodeToInput presses

main = S.map render (S.foldp update start input)

-- Exercise 3. Make it so that Pete faces the direction he just moved in. Use these.

pics = "https://dl.dropboxusercontent.com/u/27883775/code/imgs/iceblox.gif"

peteUp = croppedImage (150,0) 30 30 pics
peteLeft = croppedImage (60,0) 30 30 pics
peteDown = croppedImage (210,0) 30 30 pics
peteRight = croppedImage (120,0) 30 30 pics