import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Text exposing (..)
import Time exposing (..)
import Signal exposing (..)

--SIGNAL
type alias Input = Time

--MODEL
type alias Model = Time

--UPDATE
update : Input -> Model -> Time
update delta t = t + (delta)

--VIEW
view : Model -> Element
view t =
  collage 400 200 [toForm <| flow down 
    [fromString "Hello, World!" |> italic |> centered,
     fromString ("I have been alive for "++(toString t)++" milliseconds.") |> centered ]]
     
main : Signal Element
main = map view (foldp update 0 (fps 20))