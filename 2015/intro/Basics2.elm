import Graphics.Element exposing (Element, show)


factorial : Int -> Int
factorial n =
    if n <= 1
      then 1
      else n * factorial (n-1)

main : Element
main =
  show (factorial 5)

length : List a -> Int
length list =
  case list of
    [] -> 0
    first :: rest ->
      1 + length rest

--main = show (length [1..9])

--main = show (List.map (\n -> n^2) [1..5])

--main = show (map2 (+) [1, 3, 5] [1, 2, 3])

--main = show (filter (\x -> x>5) [1, 5, 6, 3, 7, 8, 2]

