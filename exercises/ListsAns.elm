import Graphics.Element exposing (show)
import List exposing (..)
import Debug exposing (..)

main =
  show li
-- edit this line to show the answer to whatever you're working on.

li = [1,2,3,4]
li1 = [2,4,6,8]
  
-- 1. Add 1 to every element of li
f1 : List Int -> List Int
f1 li = map (\x -> x + 1) li
-- As a shortcut you can write `f1 = map (\x -> x+1)`. This is called *partial application*.

-- 2. Add 2 lists (li and li1)
-- Hint: 
-- map2 : (a -> b -> c) -> List a -> List b -> List c 
f2 : List Int -> List Int -> List Int
f2 xs ys = map2 (+) xs ys
-- Alternatively, `f2 = map2 (+)`

-- Now let ans2 be the sums of entries in the two lists
ans2 = f2 li li1

-- 3. Write a function to sum every element in the list
sum' : List Int -> Int
sum' xs = foldl (+) 0 xs
-- Alternatively, `sum' = foldl (+) 0`

-- 4. Write a function to compute the square of every element in the list
squares : List Int -> List Int
squares = map (^2)

-- 5. Write a function to compute the sum of squares of every element in the list
sumSquares : List Int -> Int
sumSquares = sum << squares

bs = [True, False, False, True, True, True]

-- 6. Write a function that counts the number of "True"s in a list
countTrues : List Bool -> Int
countTrues = foldl (\x y -> if y then x+1 else x) 0
--countTrues = length << filter identity

-- 7. Write a function that tracks combos. 
-- Example: [True, False, True, True, True, True] should return 4 because there are 4 True's at the end.
countCombo : List Bool -> Int
countCombo = foldl (\x y -> if y then x+1 else 0) 0
--foldr is better here

-- 8. Write a function that adds even numbers in a list.
-- Hint: 
sumEvens : List Int -> Int
sumEvens = foldl (\x y -> if y%2==0 then x+y else x) 0
--sumEvens = sum << filter (\x -> x&2==0) 

-- 9. Write a function that doubles each string and then appends them together
-- Ex. echoes ["hello", "world"] = "hellohelloworldworld"
-- Hint: ++ adds strings, "hello"++"world" == "helloworld"
echoes : List String -> String
echoes = foldl (++) "" << map (\x -> x++x)
--echoes = concat << map (\x -> x++x)
