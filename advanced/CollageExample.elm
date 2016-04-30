import Graphics.Collage exposing (..)
import Color exposing (..)
import Graphics.Element exposing (..)
import Text exposing (fromString)

main = collage 400 350 [ circle 20 |> filled black |> move (30, 40), 
                    square 100 |> filled green |> move (-100, -70) |> rotate (degrees 30),
                    segment (30, 40) (-100, -70) |> traced (dashed red),
                    toForm (image 35 35 ("http://elm-lang.org/imgs/mario/walk/right.gif  ")),
                    fromString "Hello world!" |> Text.color blue |> centered |> toForm |> move (0,-30)]
--  in
--    flow right [mainPanel, fromString "Yay!" |> centered]
