import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Text exposing (..)
import Time exposing (..)
import Signal exposing (..)

--SIGNAL
--fps : Signal Time

--MODEL
--Time

--UPDATE
update : Time -> Time -> Time
update delta t = t + (delta)

--VIEW
view : Time -> Element
view t =
  collage 400 200 [toForm <| flow down 
    [fromString "Hello, World!" |> italic |> centered,
     fromString ("I have been alive for "++(toString t)++" milliseconds.") |> centered ]]
     
main : Signal Element
main = map view (foldp update 0 (fps 20))