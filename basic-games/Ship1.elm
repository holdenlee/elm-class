import Color exposing (..)
import Keyboard exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Signal exposing (..)
import Time exposing (..)
import List as L
import Graphics.Input exposing (..)

--UTILITIES

type alias Vec = {x:Float, y:Float}
type alias IVec= {x:Int  , y:Int  }

toVec : IVec -> Vec
toVec {x,y} = {x = toFloat x, y = toFloat y}

xmax = 200
ymax = 200

--MODEL
type alias Model = {loc:Vec, v:Vec}

start : Model
start = {loc = {x=0,y=0}, v = {x=0,y=0}}

--UPDATE
(.+) : Vec -> Vec -> Vec
(.+) v1 v2 = {x = v1.x + v2.x, y = v1.y + v2.y}

step : Input -> Model -> Model
step inp ship = 
    {loc = ship.loc .+ ship.v, 
     v = ship.v .+ inp}

--VIEW
render : Model -> Element
render ship = 
    collage (2*xmax) (2*ymax) [(filled white <| circle 10) |> move (ship.loc.x, ship.loc.y)] |> color black

--SIGNAL
type alias Input = {x:Float, y:Float}

input : Signal Input
input = map toVec <| sampleOn (fps 20) arrows

main = map render (foldp step start input)

