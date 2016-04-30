

x = 2

-- Variables are immutable
-- NO
x = x + 1
-- YES
x' = x + 1

-- if-then-else
-- NO: statements do not go in bodies of `if` statements. Values do.
if x > 0
then string = "positive" 
else string = "not positive"
-- YES
string = if x > 0 
         then "positive" 
         else "not positive"




