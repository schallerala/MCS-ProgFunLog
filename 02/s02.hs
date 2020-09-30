module S02 where

import Data.Char

-- #############################################################
-- Ex 1
-- without pattern
f11 (a:b:c:d) = [a,b,c]
f11 l = l

-- with pattern
f12 l =
  if (length l) < 3
    then l
    else take 3 l

fibonacci 0 = 0
fibonacci 1 = 1
fibonacci n = (fibonacci (n-1)) + (fibonacci (n-2))

--f1' (x1 : x2 : x3 : x) = [x1, x2, x3]
--f1' x = x


--fibonacci 0 = 0
--fibonacci 1 = 1
--fibonacci x = fibonacci (x - 1) + fibonacci (x - 2)

-- #############################################################
-- Ex 2
myLast [] = 0
myLast (x:y) =
  if (length y) == 0
    then x
  else
    myLast y

myDelete _ [] = []
myDelete e (x:y) =
  if (e == x)
    then y
    else x:(myDelete e y)

myMaximum [x] = x
myMaximum (x:y)
  | max < x = x
  | otherwise = max
  where max = myMaximum y

myLength [] = 0
myLength [x] = 1
myLength (x:y) = 1 + (myLength y)

myDeleteAll _ [] = []
myDeleteAll e (x:y) =
  if (e == x)
    then myDeleteAll e y
    else x:(myDeleteAll e y)

f1 l = if length l < 3
        then l
        else take 3 l

-- #############################################################
-- Ex 3

scalarProduct (v1 : v) (u1 : u) = v1 * u1 + scalarProduct v u
scalarProduct v u = 0


toUpperString (x1 : x) = toUpper x1 : toUpperString x
toUpperString x = []

-- #############################################################
-- Ex 4

countVowel (x1 : x) = (isVowel x1) + (countVowel x)
    where isVowel c = if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' || c == 'y'
                        then 1
                        else 0
countVowel x = 0

analyseStrings (x1 : x) = tupleLength x1 : analyseStrings x
    where tupleLength x1 = (x1, length x1)
analyseStrings x = []

analyseStrings2 ( x1 : x ) = tupleLengthVowel x1 : analyseStrings2 x
    where tupleLengthVowel x1 = (x1, length x1, countVowel x1)
analyseStrings2 x = []
