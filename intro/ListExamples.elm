import Text exposing (..)
import Graphics.Element exposing (..)
import List as L


factorial : Int -> Int
factorial n =
    if n <= 1
      then 1
      else n * factorial (n-1)
{-
main : Element
main =
  show (factorial 5)
-}
sum : List number -> number
sum li = 
  case li of
    [] -> 0
    first :: rest -> first + sum rest

--main = show (sum [1,2,3])

length : List a -> Int
length list =
  case list of
    [] -> 0
    first :: rest ->
      1 + length rest
      
--main = show (length [1..9])
      
countPositive : List Int -> Int
countPositive li = 
  case li of
    [] -> 0
    first :: rest ->
      if first > 0 then 1 + countPositive rest else countPositive rest

--main = show (countPositive [-3, 5, 7, 1, -2])

--MAP

--main = show (L.map (\n -> n^2) [1..5])

--main = show (L.map2 (,) [1..5] [6,9,3,4,1])

--main = show (L.map2 (+) [1, 3, 5] [1, 2, 3])

--main = show (L.filter (\x -> x>5) [1, 5, 6, 3, 7, 8, 2])

--main = show (L.foldl (+) 0 [1,2,3,4])

answer = L.foldl (\x y -> if x>0 then y + x else y) 0 
          [-3, 5, 7, 1, -2]
         
main = show answer

--main = show (L.filter (\x -> x>0) [-3, 5, 7, 1, -2])

--main = show (L.length (L.filter (\x -> x>0) [-3, 5, 7, 1, -2]))

--answer = L.foldl (\x y -> if x then y + 1 else y) 0 
--  [True, True, False, False, True]

--answer = L.filter (\x -> x>=5) [1,6,4,7,2]

--main = show answer
