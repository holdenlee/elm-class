import Graphics.Element exposing (..)

a : Int 
a = 3

b = 2 * a + 1

--main = show b

--NOT ALLOWED 
--a = a + 1

c : Float
c = 5.5

d : Bool 
d = c < toFloat b 
--toFloat b

--main = show d

e : Bool 
e = (2 < 1) && (2 > 1)

s1 : String
s1 = "Hello "

s2 : String
s2 = "World!"

--main = show (s1 ++ s2)

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

--main = show (addThree 2)

multiplyAndAddOne : Int -> Int -> Int
multiplyAndAddOne x y = 
  let
    p = x * y
  in
    p + 1
--main = show (multiplyAndAddOne 2 3)

--Higher-order functions
doThrice : (a -> a) -> a -> a
doThrice f x = f (f (f a))

addThree' = doThrice addOne 

stutter = doThrice (\x -> "Hello "++x) "world!"
