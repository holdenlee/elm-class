import Text exposing (..)
import Graphics.Element exposing (..)
import List as L

answer = L.foldl (\x y -> if x then y + 1 else y) 0 
  [True, True, False, False, True]

--answer = L.filter (\x -> x>=5) [1,6,4,7,2]

main = show answer