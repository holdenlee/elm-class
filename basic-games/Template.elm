import Color exposing (..)
import Keyboard exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Signal exposing (..)
import Time exposing (..)
import List as L
import Graphics.Input exposing (..)

--MODEL
type alias Model = {}

start : Model
start = {}

--UPDATE
step : Input -> Model -> Model
step inp m = m 

--VIEW
render : Model -> Element
render m = show m

--SIGNAL
type alias Input = {}

input : Signal Input
input = constant {}

main = map render (foldp step start input)

