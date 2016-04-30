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
squares = always []

-- 5. Write a function to compute the sum of squares of every element in the list
sumSquares : List Int -> Int
sumSquares = always 0

bs = [True, False, False, True, True, True]

-- 6. Write a function that counts the number of "True"s in a list
countTrues : List Bool -> Int
countTrues = always 0

-- 7. Write a function that tracks combos. 
-- Example: [True, False, True, True, True, True] should return 4 because there are 4 True's at the end.
countCombo : List Bool -> Int
countCombo = always 0

-- 8. Write a function that adds even numbers in a list.
-- Hint: 
sumEvens : List Int -> Int
sumEvens = always 0

-- 9. Write a function that maps every even number to 'even' and every odd number to "odd".
-- Hint: % is the mod operator. x % 2 == 1 if x is odd and x % 2 == 0 if x is even.
mapEvenOdd : List Int -> Int
mapEvenOdd = always 0

-- 10. Fizzbuzz
-- Show the numbers up to n as strings. However, any number divisible by three is replaced by the word `Fizz` and any divisible by five by the word `Buzz`. Numbers divisible by both become `FizzBuzz`.
-- For example, fizzbuzz 15 = [1, 2, Fizz, 4, Buzz, Fizz, 7, 8, Fizz, Buzz, 11, Fizz, 13, 14, FizzBuzz]
-- Hint: ++ adds strings, "Fizz"++"Buzz" == "FizzBuzz"
fizzbuzz : Int -> List String
fizzbuzz = always 0
