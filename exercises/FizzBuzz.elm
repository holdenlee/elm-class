import Graphics.Element exposing (show)
import List exposing (..)

main = show (map fizzbuzz [1..15])

fizzbuzz : Int -> String
fizzbuzz n = 
    let
        fizz = if (n%3==0) then "Fizz" else ""
        buzz = if (n%5==0) then "Buzz" else ""
        fb = fizz ++ buzz
    in
      if fb == "" then toString n else fb