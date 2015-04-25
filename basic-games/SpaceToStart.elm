import Color exposing (..)
import Keyboard exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Signal exposing (..)
import Time exposing (..)
import List as L
import Graphics.Input exposing (..)
import Text exposing (fromString)

--MODEL
type alias Game = {}
type Model = Waiting | Ingame Game

startModel : Model
startModel = Waiting

startGame : Game
startGame = {}

--UPDATE
stepGame : Input -> Game -> Game
stepGame inp game = game

step : Input -> Model -> Model
step ((x,b) as inp) m = 
    case m of
      Waiting -> 
        if b then Ingame startGame else Waiting
      Ingame game -> Ingame (stepGame inp game)

--VIEW
xmax = 200
ymax = 200

render : Model -> Element
render m = 
    case m of 
      Waiting -> renderWaiting
      Ingame game -> renderGame game

renderWaiting : Element
renderWaiting = 
    collage (2*xmax) (2*ymax) [(fromString "Press SPACE to begin." |> Text.color white) |> centered |> toForm] |> color black

renderGame : Game -> Element
renderGame game = empty

--SIGNAL
type alias Input = ({},Bool)

input : Signal Input
input = sampleOn (fps 20) (map2 (,) (constant {}) space)

main = map render (foldp step Waiting input)

