import Graphics.Element exposing (show)
import List exposing (..)
import Debug exposing (..)
import Maybe as M

sum' : List Int -> Int
sum' li = case li of
            x::rest -> x + sum' rest
            [] -> 0

head' : List a -> Maybe a
head' li = case li of
             x::rest -> Just x
             [] -> Nothing

foldl' : (a -> b -> b) -> b -> List a -> b
foldl' f start li = case li of
                      x::rest -> foldl' f (f x start) rest
                      [] -> start

-- Exercise: write a function for the length of a list.
-- length' : List a -> Int

-- Exercise: write a function for the min of a list.
-- min' : List a -> Maybe Int
-- (An empty list has no minimum, so return Nothing.)

