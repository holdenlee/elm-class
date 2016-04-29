import Graphics.Element exposing (show)
import List exposing (..)
import Debug exposing (..)

-- Assign a value
-- x : Int
x = 1
y = x + 1
-- s1 : String
s1 = "Hello "
s2 = "World!"
hw = s1++s2
-- b : Bool
b = (y == 2)
c = (x == 1) && b

-- Define a function
-- square : Int -> Int
square x = x^2

-- abs : Int -> Int
abs x = if x<0 
        then -x
        else x

-- recursion
-- triangular numbers 1+2+...+n
triangle n = if n <= 0
             then 0
             else n + triangle (n-1)

-- Exercise: 
-- tetrahedral 1 = 1
-- tetrahedral 2 = 1 + (1 + 2)
-- tetrahedral 3 = 1 + (1 + 2) + (1 + 2 + 3) 
tetrahedral n = undefined


