import Color (..)
import Keyboard (..)
import Text
import Window
import Graphics.Element (..)
import Graphics.Collage (..)
import Graphics.Input (..)
import Signal (..)
import Time (..)
import List as L
import Array as A
import Maybe as M

--MODEL

type alias Settings = {level : Int, speed : Int}

type State = Setup | Ingame

type alias Model = {state: State, settings: Settings}

startModel : Model
startModel = {state = Setup, settings = {level = 1, speed = 1}}

--UPDATE

type Update 
    = UpdateLevel Int 
    | UpdateSpeed Int 
    | Start 
    | End

ulevel : Int -> Settings -> Settings
ulevel i s = {s | level <- i}

uspeed : Int -> Settings -> Settings
uspeed i s = {s | speed <- i}

update : Update -> Model -> Model
update u m = case u of
               UpdateLevel i -> {m | settings <- ulevel i m.settings}
               UpdateSpeed i -> {m | settings <- uspeed i m.settings}
{-               UpdateLevel i -> {m | settings <- ({m.settings | level <- i})}
               UpdateSpeed i -> {m | settings <- ({m.settings | speed <- i})}
-}
               Start -> {m | state <- Ingame}
               End -> {m | state <- Setup}

updateChannel : Channel Update
updateChannel = channel (UpdateLevel 1)

levelList : List (String, Int)
levelList = 
    [ "1" := 1
    , "2" := 2
    , "3" := 3]

speedList : List (String, Int)
speedList = 
    [ "Slow"   := 1
    , "Medium" := 2
    , "Fast"   := 3]

(:=) x y =
    (x, y)

--VIEW

view : Model -> Element
view m = case m.state of
               Setup -> flow down 
                        [flow right [Text.leftAligned <| Text.fromString "Level", dropDown (\x -> send updateChannel (UpdateLevel x)) levelList],
                         flow right [Text.leftAligned <| Text.fromString "Speed", dropDown (\x -> send updateChannel (UpdateSpeed x)) speedList],
                         button (send updateChannel (Start)) "Start game"]
               Ingame -> flow down
                         [Text.leftAligned <| Text.fromString "In game", 
                          Text.leftAligned <| Text.fromString ("Level "++(toString m.settings.level)),
                          Text.leftAligned <| Text.fromString ("Speed "++(toString m.settings.speed)),
                          button (send updateChannel (End)) "End game"]
                          

--SIGNALS

main : Signal Element
main = 
    map view model

model : Signal Model
model = subscribe updateChannel |> foldp update startModel

updateSignal : Signal Update
updateSignal = subscribe updateChannel                          
                                     