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
type alias Ship = {loc:Vec, v:Vec, dir:Float}

start : Ship
start = {loc = {x=0,y=0}, v = {x=0,y=0}, dir = 0}

--UPDATE
(.+) : Vec -> Vec -> Vec
(.+) v1 v2 = {x = v1.x + v2.x, y = v1.y + v2.y}

(.*) : Float -> Vec -> Vec
(.*) a v = {x = a*v.x, y = a*v.y}

step : Input -> Ship -> Ship
step (delta, {x, y}) {loc, v, dir} = 
    {loc = loc .+ v, 
     dir = dir - delta/10 * (degrees (toFloat x)),
     v = v .+ (((toFloat y) * delta/100) .* {x = cos dir, y = sin dir})}

--VIEW
render : Ship -> Element
render {loc, v, dir} = 
    collage (2*xmax) (2*ymax) [toForm (image 32 32 "ss.gif") |> move (loc.x, loc.y) |> rotate (dir - degrees 90)] |> color black

--SIGNAL
type alias Input = (Time, IVec)

input : Signal (Time, IVec) 
input = sampleOn (fps 20) (map2 (,) (fps 20) arrows)

main = map render (foldp step start input)

