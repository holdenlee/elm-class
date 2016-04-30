import Text exposing (..)
import Graphics.Element exposing (..)
import List as L

iflist : List (Bool, a) -> a -> a
iflist li def = case li of
                  (True, x)::_    -> x
                  (False, _)::li' -> iflist li' def 
                  []              -> def 
 

type Gender = Male | Female

type alias Student = {name : String, gender : Gender, grade : Int, scores : List Int}

bob : Student
bob = {name = "Bob", gender = Male, grade = 9, 
       scores = [100, 90, 80, 70, 60, 50]}

displayGrade : Student -> String
displayGrade s = s.name ++ " has grade " ++ (calculateGrade <| average s.scores)

average : List Int -> Int 
average li = 
  case li of 
    [] -> 100
    _  -> (L.sum li)//(L.length li)
    --(L.foldl (+) 0 li)//(L.length li)

calculateGrade : Int -> String
calculateGrade n = 
  iflist [(n>=90, "A"),
          (n>=80, "B"),
          (n>=70, "C"),
          (n>=60, "D")] "E"
{-
  if n >= 90
    then "A" --cf. return "A". Not "carry this out if n>=90," but "return this if n>=90."
    else if n >= 80
    then "B"
    else if n >= 70
    then "C"
    else if n >= 60
    then "D"
    else "E"-}

main = show (displayGrade bob)