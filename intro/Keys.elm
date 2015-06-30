import Color exposing (..)
import Keyboard exposing (..)
import Text
import Window
import Graphics.Element exposing (..)
import Graphics.Collage exposing (..)
import Signal exposing (..)
import Set as S

--(!): List a -> Int -> a
--li ! i = head (drop i li)

-- input

--keysDown : Signal (List KeyCode)

-- Model

type State = Going | Paused

type alias Model = {keys : List Int}

-- Updates

stepModel : (S.Set KeyCode) -> Model -> Model
stepModel s m =  {m | keys <- S.toList s}

--Display

display : (Int, Int) -> Model -> Element
display (w,h) m = 
    let n : Element
        n = txt (Text.height 50) (toString m.keys)
    in container w h middle <| collage w h [toForm n |> move (0,0)]
--((w `div` 2) - 10, (h `div` 2) - 20)]
              
--Run

txt : (Text.Text -> Text.Text) -> String -> Element
txt f x = leftAligned <| f <| Text.monospace <| (Text.color black) <| Text.fromString x

startModel : Model
startModel = {keys = []}

--gameModel : Signal Model
gameModel = foldp stepModel startModel keysDown

main = map2 display Window.dimensions gameModel