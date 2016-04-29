import Color exposing (..)
import Keyboard exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Signal exposing (..)
import Time exposing (..)
import List as L
import Graphics.Input exposing (..)
import Text exposing (fromString)

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
type alias Game = {ship : Object, asteroids : List Object}
type Model = Waiting | Ingame Game

type alias Object = {loc:Vec, v:Vec, dir:Float, r:Float}

startShip : Object
startShip = {loc = {x=0,y=0}, v = {x=0,y=0}, dir = 0, r=16}

startAst : Object
startAst = {loc = {x=150,y=150}, v = {x=2,y=2}, dir = degrees 45, r=100}

startGame : Model
startGame = Ingame {ship = startShip, asteroids = [startAst]}

--UPDATE
(.+) : Vec -> Vec -> Vec
(.+) v1 v2 = {x = v1.x + v2.x, y = v1.y + v2.y}

(.%) : Float -> Float -> Float
(.%) x y = iflist [(x >= y, x - 2*y),
                 (x < -y, x + 2*y)] x

(.+%) : Vec -> Vec -> Vec
(.+%) v1 v2 = {x = (v1.x + v2.x) .% xmax , y = (v1.y + v2.y) .% ymax}

(.*) : Float -> Vec -> Vec
(.*) a v = {x = a*v.x, y = a*v.y}

dist : Vec -> Vec -> Float
dist {x,y} v1 = sqrt ((x-v1.x)^2 + (y-v1.y)^2)

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

stepObject : Input -> Object -> Object
stepObject (delta, {x, y}, b) ({loc, v, dir, r} as obj)= 
    {obj | loc = loc .+% v} 
{-     dir = dir - delta/10 * (degrees (toFloat x)),
     v = limitV vmax (v .+ (((toFloat y) * delta/100) .* {x = cos dir, y = sin dir})),
     r = r}-}

checkOK : Object -> List Object -> Bool
checkOK obj li = 
    let
        fli : List Object
        fli = L.filter (\x -> dist (x.loc) (obj.loc) < obj.r + x.r) li
    in
      L.length fli < 1

stepObj : Time -> Object -> Object
stepObj delta ({loc, v, dir, r} as obj) = 
    {obj | loc = loc .+% v}

step : Input -> Model -> Model
step (delta,{x,y},b)  m = 
    case m of
      Waiting -> if not b then Waiting else startGame
--{{loc, v, dir} as ship, asteroids}
      Ingame {ship, asteroids} ->
        let {loc, v, dir, r} = ship in
          if checkOK ship asteroids
             then
                 let 
                     newShip = 
                         {ship | loc = loc .+% v, 
                          dir = dir - delta/10 * (degrees (toFloat x)),
                          v = limitV vmax (v .+ (((toFloat y) * delta/100) .* {x = cos dir, y = sin dir}))}
                     newAsts = L.map (stepObj delta) asteroids
                 in
                   Ingame {ship = newShip, asteroids = newAsts}
             else 
                 Waiting
          

--VIEW
render : Model -> Element
render m = 
    case m of 
      Waiting -> renderStart
      Ingame game -> renderGame game

renderStart : Element
renderStart = 
    collage (2*xmax) (2*ymax) [(fromString "Press SPACE to begin." |> Text.color white) |> centered |> toForm] |> color black

renderGame : Game -> Element
renderGame {ship, asteroids}  = 
  let {loc, v, dir, r} = ship in 
    collage (2*xmax) (2*ymax) 
                ((toForm (image 32 32 "ss.gif") |> move (loc.x, loc.y) |> rotate (dir - degrees 90))::
                (L.map (\ast -> (circle ast.r) |> filled gray |> move (ast.loc.x, ast.loc.y)) asteroids)) |> color black

--SIGNAL
type alias Input = (Time, IVec, Bool)

input : Signal (Time, IVec, Bool) 
input = sampleOn (fps 20) (map3 (,,) (fps 20) arrows space)

main = map render (foldp step Waiting input)

