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

iflist : List (Bool, a) -> a -> a
iflist li def = case li of
                  (True, x)::_    -> x
                  (False, _)::li' -> iflist li' def 
                  []              -> def 

--Constants
vmax = 10
xmax = 200
ymax = 200

--MODEL
type alias Ship = {loc:Vec, v:Vec}

start : Ship
start = {loc = {x=0,y=0}, v = {x=0,y=0}}

--UPDATE
(.%) : Float -> Float -> Float
x .% y = iflist [(x >= y, x - 2*y),
                 (x < -y, x + 2*y)] x

(.+) : Vec -> Vec -> Vec
v1 .+ v2 = {x = v1.x + v2.x, y = v1.y + v2.y}

(.+%) : Vec -> Vec -> Vec
v1 .+% v2 = {x = (v1.x + v2.x) .% xmax , y = (v1.y + v2.y) .% ymax}

limit : Float -> Float -> Float
limit m x = clamp (-m) m x

step : IVec -> Ship -> Ship
step inp' ship = 
    let 
        inp = toVec inp'
    in
      {loc = ship.loc .+% ship.v, v = {x = limit vmax (ship.v.x + inp.x), y = limit vmax (ship.v.y + inp.y)}}

--VIEW
render : Ship -> Element
render ship = 
    collage (2*xmax) (2*ymax) [(filled black <| circle 10) |> move (ship.loc.x, ship.loc.y)]

--SIGNAL
input = sampleOn (fps 20) arrows

main = map render (foldp step start input)

