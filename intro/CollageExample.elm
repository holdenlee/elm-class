import Graphics.Collage exposing (..)
import Color exposing (..)

main = 
  collage 400 300 [ circle 20 |> filled black |> move (30, 40), 
                    square 100 |> filled green |> move (-100, -120),
                    segment (30, 40) (-100, -120) |> traced (dashed red)]
