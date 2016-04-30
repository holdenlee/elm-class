import Color exposing (..)
import Keyboard exposing (..)
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Signal as S
import Time exposing (..)
import List exposing (..) 
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
input = S.constant {}

main = S.map render (S.foldp step start input)

