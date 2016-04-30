import Graphics.Element exposing (show)
import List exposing (..)

-- NUMBERS

-- Assign a value
a : Int
a = 1

b = 2*a + 1

-- NOT ALLOWED
-- a = a + 1

c : Float
c = 5.5

b1 : Float
b1 = toFloat b

-- BOOLEANS
bool = (c < b1)
bool2 = True && not (True || False)

s1 : String
s1 = "Hello "

s2 = "World!"

hw = s1++s2

main = show (s1 ++ s2)

-- LISTS

-- b : Bool
-- li : List Int
li = [1,2,3,4]
li1 = [1..4]
li2 = 0::li
li3 = [1,2,3] ++ [5,6,7]

--FUNCTIONS

addOne : Int -> Int
addOne x = x + 1

--main = show (addOne 2)

addThree : Int -> Int
addThree x = 
  let
    y = x + 1
    z = y + 1
  in 
    z + 1

multiplyAndAddOne : Int -> Int -> Int
multiplyAndAddOne x y = 
  let
    p = x * y
  in
    p + 1

square : Int -> Int
square x = x^2
-- square = \x -> x^2
-- square = (^2)

-- function composition
m = 10
double x = 2*x
n = addOne (double m)
-- n = 21

--n = addOne <| double x
doubleAndAddOne x = addOne <| double x
--doubleAndAddOne = addOne << double

--higher-order functions
doThrice : (a -> a) -> a -> a
doThrice f x = f (f (f x))
-- doThrice f = f << f << f
-- doThrice f x = f <| f <| f x

p = doThrice double m

-- IF STATEMENTS
-- abs : Int -> Int
abs x = if x<0 
        then -x
        else x

-- chaining
admitRollerCoaster : Int -> String
admitRollerCoaster x = 
    if x <= 48 then
        "too short"
    else if x <= 72 then
        "have fun"
    else "too tall"

-- OTHER DATA TYPES

-- tuples
(.+) : (Int, Int) -> (Int, Int) -> (Int, Int)
(.+) (x,y) (z,w) = (x+z, y+w)

-- records
type alias Point = { x:Float, y:Float }

origin : Point
origin =
  { x = 0, y = 0 }

goUp : Point -> Point
goUp pt = {pt | x = pt.x + 1}

