import Graphics.Element exposing (show)
import List exposing (..)

-- Write a function that, given two players' hands, will give the scores of both players 
type Hand = Rock | Paper | Scissors

p1 = [Rock, Rock, Paper, Scissors]
p2 = [Paper, Scissors, Scissors, Rock]

winner : Hand -> Hand -> (Int, Int)
winner x y = 
  if x==y 
    then (0,0)
  else if x==Rock && y==Scissors
    then (1,0)
  else if x==Scissors && y==Paper
    then (1,0)
  else if x==Paper && y==Rock
    then (1,0)
  else (0,1)

(.+) : (Int, Int) -> (Int, Int) -> (Int, Int)
(.+) (x,y) (z,w) = (x+z,y+w)

scores : List Hand -> List Hand -> (Int, Int)
scores h1 h2 = foldl (.+) (0,0) <| map2 winner h1 h2