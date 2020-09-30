import Data.Char

f1 l = if length l < 3
        then l
        else take 3 l



f1' (x1 : x2 : x3 : x) = [x1, x2, x3]
f1' x = x


fibonacci 0 = 0
fibonacci 1 = 1
fibonacci x = fibonacci (x - 1) + fibonacci (x - 2)


scalarProduct (v1 : v) (u1 : u) = v1 * u1 + scalarProduct v u
scalarProduct v u = 0


toUpperString (x1 : x) = toUpper x1 : toUpperString x
toUpperString x = []


countVowel (x1 : x) = (isVowel x1) + (countVowel x)
    where isVowel c = if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' || c == 'y'
                        then 1
                        else 0
countVowel x = 0

analyseStrings (x1 : x) = tupleLength x1 : analyseStrings x
    where tupleLength x1 = (x1, length x1)
analyseStrings x = []

analyseString2 ( x1 : x ) = tupleLengthVowel x1 : analyseString2 x
    where tupleLengthVowel x1 = (x1, length x1, countVowel x1)
analyseString2 x = []


main :: IO ()
main = print (f1 [4,8,2,7,9,3])