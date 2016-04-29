import List as L
import Random exposing (..)
import Color exposing (..)
import Keyboard exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Signal exposing (..)
import Time exposing (..)
import Text exposing (fromString)
import Debug

--UTILITY
(+.): (Int, Int) -> (Int, Int) -> (Int, Int)
(+.) (x0,y0) (x1,y1) = (x0 + x1, y0 + y1) 

genUntil : (a -> Bool) -> Generator a -> Seed -> (a, Seed)
genUntil f g s = 
  let
    (x, s') = generate g s
  in
    if f x 
    then (x, s')
    else genUntil f g s'

body : List a -> List a
body li = L.take (L.length li - 1) li

head' : List (Int,Int) -> (Int, Int)
head' li = 
    case L.head li of
      Just x -> x 
      _      -> (0,0)

{-| Usage: 
    place' a b (x,y) form
moves the bottom left corner of the form to (x,y) as measured from the lower-left of the canvas. 
Here a and b are the width and height of the canvas. 
Suggested usage: in the "view" function, define place as follows.
    let
        place = place' w h
    in
      collage w h [square 20 |> place (20,40),...]
In this example, a square of side 20 is placed with lower left corner at (20,40).
-}
place' : Int -> Int -> (Int, Int) -> Form -> Form
place' a b (x,y) = move ((toFloat (-a))/2 + toFloat x,(toFloat -b)/2 + toFloat y)

recti : Int -> Int -> Shape
recti x y = rect (toFloat x) (toFloat y)

squari : Int -> Shape
squari x = square (toFloat x)

--Control
ifs: List (Bool, a) -> a -> a
ifs li z = case li of
             (b, y)::tl -> if b then y else ifs tl z
             []         -> z 

--PARAMETERS

size = 10
xmax = 25
ymax = 25

--MODEL

--A snake is a list
type alias Snake = List (Int, Int)

type alias Game = {xd : Int, yd : Int, size : Int, mouse: (Int,Int), snake : Snake, dir : (Int,Int), alive : Bool, seed : Seed}

startGame = init 0

init : Int -> Game
init i = 
    let
        s = initialSeed i
        (ms, s') = generate (pair (int 1 xmax) (int 1 ymax)) s
    in
        {xd = xmax, yd = ymax, size = size, mouse = ms, snake = [(1,1)], dir = (1,0), alive = True, seed = s}

--UPDATE

--The form of the "step" or "update" function should be Input -> Model -> Model
--where Input encapsulates all that the program needs to know from the outside world.

--Move the snake
stepGame : Input -> Game -> Game
stepGame (dir, b) m = 
 (let
      --if no direction was received, then keep the original direction, else use the new direction.
      d = if dir == (0,0)
          then m.dir
          else dir
      s = m.snake
      --the new location of the head
      hd = (head' s +. d)
  in
    --if the head does not hit a wall or itself
    if checkOK hd m
    then 
        --if the head hits the mouse
        if (hd == m.mouse) 
        then 
            let 
                --genUntil : (a -> Bool) -> Generator a -> Seed -> (a, Seed)
                --generate a new mouse. keep generating random locations until the location is not inside the snake.
                (pt, s') = genUntil (\pt -> not (pt `L.member` s || pt == hd)) (pair (int 1 m.xd) (int 1 m.yd)) m.seed
            in 
              --make the snake longer, update the seed, update the mouse, update the direction.
              {m | snake = hd::s
                 , seed = s'
                 , mouse = pt
                 , dir = d}
        else 
            --move the head, delete the tail
            {m | snake = hd::(body s), dir = d}
    else
        --the snake hits the wall or itself, and dies
        {m | alive = False}) |> Debug.watchSummary "Snake" .snake

inBounds : (Int, Int) -> Game -> Bool
inBounds (x,y) m = 
  (x > 0) && (y > 0) && (x <= m.xd) && (y <= m.yd)

--the snake is alive, and has not hit the wall or itself. Pt is the new location of the head.
checkOK: (Int,Int) -> Game -> Bool
checkOK pt m = 
  let
    s = m.snake
  in
    m.alive && (inBounds pt m) && not (pt `L.member` s)

--VIEW
renderGame : Game -> Element
renderGame m = 
  let 
      place = place' ((m.xd + 2) * m.size) ((m.yd + 2) * m.size)
      (xm, ym) = m.mouse
      mainPanel = collage ((m.xd + 2) * m.size) ((m.yd + 2) * m.size)
                  ((L.append 
                    --a black rectangle that fills the canvas
                        [recti ((m.xd + 2) * m.size) ((m.yd + 2) * m.size)
                             |> filled (rgb 0 0 0),
                         --a white rectangle that fills the play area
                         recti (m.xd * m.size) (m.yd * m.size)
                             |> filled (rgb 255 255 255),
                         --a purple square for the mouse. Note // for integer division
                         squari m.size 
                             |> filled (rgb 128 0 128) 
                             |> place (xm*m.size + m.size//2,ym*m.size + m.size//2)]
                   --for each point of the snake, make a square
                   (L.map (\(x,y) -> squari m.size
                                         |> filled (rgb 255 0 0)
                                         |> place (x*m.size + m.size//2,y*m.size + m.size//2)) m.snake))
                    ++[if m.alive then toForm empty else fromString "Game Over, Press SPACE" |> centered |> toForm])
  in
    flow right [mainPanel, flow down [(fromString "Length:" |> centered), (fromString (toString (L.length m.snake)) |> centered)]]


--SIGNALS
--look at which arrow keys are down, and return a direction
inputDir : Signal (Int,Int)
inputDir = 
  Signal.map4 (\l u d r -> ifs [(l, (-1,0)), (u, (0,1)), (d, (0,-1)), (r, (1,0))] (0,0)) (isDown 37) (isDown 38) (isDown 40) (isDown 39)

type alias Input = ((Int, Int), Bool)

--get the input direction 20 times a second
input : Signal Input
input = sampleOn (fps 20) (Signal.map2 (,) inputDir space)

--Toplevel game

--MODEL
type Model = Waiting | Ingame Game

startModel : Model
startModel = Waiting

--UPDATE
step : Input -> Model -> Model
step ((x,b) as inp) m = 
    case m of
      Waiting -> 
        if b then Ingame startGame else Waiting
      Ingame game -> 
        if not game.alive && b then Waiting else Ingame (stepGame inp game)

--VIEW
render : Model -> Element
render m = 
    case m of 
      Waiting -> renderWaiting
      Ingame game -> renderGame game

renderWaiting : Element
renderWaiting = 
    collage ((xmax + 2) * size) ((ymax + 2) * size) [(fromString "Press SPACE to begin." |> Text.color white) |> centered |> toForm] |> color black

--SIGNAL
main = Signal.map render (foldp step Waiting input)


--Ideas:
{-
1) Random mouse: mouse moves. 
1b) Devil mouse: mouse learns from how you move to avoid you.
2) Jumps
3) Wormholes
4) You are the mouse trying to avoid the snake
5) TRON!
-}