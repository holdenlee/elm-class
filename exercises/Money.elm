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




