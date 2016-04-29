import Graphics.Element exposing (show)
import List exposing (..)

main = show (map fizzbuzz [1..15])

-- Show the numbers up to n as strings. However, any number divisible by three is replaced by the word `Fizz` and any divisible by five by the word `Buzz`. Numbers divisible by both become `FizzBuzz`.
-- For example, fizzbuzz 15 = [1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz]
-- Hint: ++ adds strings, "Fizz"++"Buzz" == "FizzBuzz"
-- `toString` turns anything into a string
fizzbuzz : Int -> String
fizzbuzz n = 
    let
        fizz = if (n%3==0) then "Fizz" else ""
        buzz = if (n%5==0) then "Buzz" else ""
        fb = fizz ++ buzz
    in
      if fb == "" then toString n else fb