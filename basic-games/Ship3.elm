import Color exposing (..)
import Keyboard exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Signal exposing (..)
import Time exposing (..)
import List as L
import Graphics.Input exposing (..)

--UTILITIES

iflist : List (Bool, a) -> a -> a
iflist li def = case li of
                  (True, x)::_    -> x
                  (False, _)::li' -> iflist li' def 
                  []              -> def 

type alias Vec = {x:Float, y:Float}
type alias IVec= {x:Int  , y:Int  }

toVec : IVec -> Vec
toVec {x,y} = {x = toFloat x, y = toFloat y}

xmax = 200
ymax = 200
vmax = 20

--MODEL
type alias Ship = {loc:Vec, v:Vec, dir:Float}

start : Ship
start = {loc = {x=0,y=0}, v = {x=0,y=0}, dir = 0}

--UPDATE
(.+) : Vec -> Vec -> Vec
v1 .+ v2 = {x = v1.x + v2.x, y = v1.y + v2.y}

(.%) : Float -> Float -> Float
x .% y = iflist [(x >= y, x - 2*y),
                 (x < -y, x + 2*y)] x

(.+%) : Vec -> Vec -> Vec
v1 .+% v2 = {x = (v1.x + v2.x) .% xmax , y = (v1.y + v2.y) .% ymax}

(.*) : Float -> Vec -> Vec
a .* v = {x = a*v.x, y = a*v.y}

limit : Float -> Float -> Float
limit m x = clamp (-m) m x

limitV : Float -> Vec -> Vec
limitV x v = 
    let
        mag = sqrt (v.x^2 + v.y^2) 
    in
      if mag > x
         then (x/mag) .* v
         else v

step : Input -> Ship -> Ship
step (delta, {x, y}) {loc, v, dir} = 
    {loc = loc .+% v, 
     dir = dir - delta/10 * (degrees (toFloat x)),
     v = limitV vmax (v .+ (((toFloat y) * delta/100) .* {x = cos dir, y = sin dir}))}

--VIEW
render : Ship -> Element
render {loc, v, dir} = 
    collage (2*xmax) (2*ymax) [toForm (image 32 32 "ss.gif") |> move (loc.x, loc.y) |> rotate (dir - degrees 90)] |> color black

--SIGNAL
type alias Input = (Time, IVec)

input : Signal (Time, IVec) 
input = sampleOn (fps 20) (map2 (,) (fps 20) arrows)

main = map render (foldp step start input)

