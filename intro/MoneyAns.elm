import Graphics.Element exposing (show)
import List exposing (..)

type alias Status = HasMoney Float | Bankrupt

-- Exercise: Write a function that takes a Float (dollar amount gained or lost) and a Status.
-- If your status is Bankrupt, you remain Bankrupt (nothing saves you from bankruptcy). Ex. 
--   update 1000 Bankrupt = Bankrupt
-- If you have money, then add the incoming money. (It many be negative.) If your money falls below 0, you become bankrupt.
--   update 10 (HasMoney 3) = 13
--   update (-10) (HasMoney 10) = HasMoney 0
--   update (-11) (HasMoney 10) = Bankrupt
update : Float -> Status -> Status
update x s = case s of
               HasMoney y -> 
                   if x + y >= 0 then HasMoney (x+y) else Bankrupt
               Bankrupt -> Bankrupt

-- Exercise 2: Given a starting status and a list of numbers, show the status after those transactions.
-- ex. finalStatus (HasMoney 10) [-9, -1, 15, -3] = HasMoney 12
-- ex. finalStatus (HasMoney 10) [-9, -2, 15, -3] = Bankrupt
finalStatus : Status -> List Float -> Status
finalStatus = foldl update


