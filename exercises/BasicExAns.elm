import Graphics.Element exposing (..)

-- EXERCISES

-- Write a `withdraw` function. 
withdraw : Int -> Int -> Int
withdraw amt total = 
  if amt < total then total - amt else 0

-- if the given string is not "", then add "Hello " to the front of the string.
-- if the string is "", return "You did not say your name!"
sayHello : String -> String
sayHello name = if name == "" then "Hello "++name else "You did not say your name!"
