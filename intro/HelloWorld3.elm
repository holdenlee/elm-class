import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Text exposing (fromString, italic)
import Time exposing (..)
import Signal exposing (..)
import Keyboard exposing (..)

--SIGNAL
type Input = TimeDelta Time | Pause | Reset

whenPress : Signal Bool -> Signal Bool
whenPress k = filter identity False <| dropRepeats k

input : Signal Input
input = mergeMany [(map TimeDelta (fps 20)),
                   (map (always Pause) (whenPress space)),
                   (map (always Reset) (whenPress enter))]
--fps : Signal Time

--MODEL
--Time
type alias Model = {t : Time, running : Bool}

model : Time -> Bool -> Model
model t b = {t=t, running = b}

defaultModel : Model
defaultModel = model 0 True

--UPDATE
update : Input -> Model -> Model
update inp ({t, running} as m) = 
  case inp of
    TimeDelta delta -> 
      if running
        then {m | t <- t + delta}
        else m
    Pause -> { m | running <- not running}
    Reset -> { m | t <- 0}

--VIEW
view : Model -> Element
view {t, running} =
  flow down 
    [fromString "Hello, World!" |> italic |> centered,
     fromString ("I have been alive for "++(toString t)++" milliseconds.") |> centered,
     if running then empty else fromString "Life paused." |> centered]
     
main : Signal Element
main = map view (foldp update defaultModel input)