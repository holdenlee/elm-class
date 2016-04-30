import Graphics.Element exposing (..)
import Mouse
import Keyboard exposing (..)
import Signal exposing (..)


--main : Signal Element
--main =
--  Signal.map show countClick


--countClick : Signal Int
--countClick =
--  Signal.foldp (\clk count -> count + 1) 0 Mouse.clicks

--part 2

type Input = Space | MousePos (Int, Int)

inputs : Signal Input
inputs =
    merge
        (map MousePos Mouse.position)
        (map (always Space) (space))
        
render : Input -> Element
render u = 
  case u of 
    Space -> show "You pressed SPACE."
    MousePos coord -> flow down [show "Mouse moved to", show coord]

update : Input -> Input -> Input
update x y = x

main : Signal Element
main = map render (foldp update (MousePos (0,0)) inputs)
