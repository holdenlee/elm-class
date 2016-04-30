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
type alias Model = {position : (Int, Int), facing : (Int, Int)}

start : Model
start = {position = (0,0), facing = (1, 0)}

h = 10
w = 10
unit = 30

--UPDATE
update : Input -> Model -> Model
update inp m = {position = m.position .+ inp, facing = inp}

(.+) : (Int, Int) -> (Int, Int) -> (Int, Int)
(.+) (x,y) (z,w) = (x+z,y+w)

--VIEW
render : Model -> Element
render m = container (w*unit) (h*unit) 
           (bottomLeftAt (absolute <| m.position*unit) (absolute <| m.position*unit))
           (image 30 30 "https://dl.dropboxusercontent.com/u/27883775/code/imgs/pete.gif")

-- show m

--SIGNAL
type alias Input = (Int, Int)

--Up/left/down/right is 38, 37, 40, 39
--K.presses : Signal KeyCode
keyCodeToInput : KeyCode -> Input
keyCodeToInput k = if k/= 0 then (1,1) else (0,0)
{-
    if k==38 then (0,1)
    else if k==37 then (-1,0)
    else if k==40 then (0,-1)
    else (1,0)
-}
input : Signal Input
input = S.map keyCodeToInput presses

main = S.map render (S.foldp update start input)

