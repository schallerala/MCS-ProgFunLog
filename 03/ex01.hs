module EX01 where

import Data.Char

{-
cette fonction prend en paramètre une liste et retourne en résultat la taille
de la liste

Exemple:
* [1,2,3] retourne 3
-}
myLength :: Num a => [t] -> a
myLength l = sum [1 | _ <- l]

{-
cette fonction prend en paramètre un élément (comparable) et une liste
et retourne en résultat la même liste mais sans l'élément indiqué

Exemple:
* 2 [1,2,3] retourne [[1,3]]
-}
myDeleteAll :: Eq a => a -> [a] -> [a]
myDeleteAll e l = [x | x <- l, x /= e ]

{-
cette fonction prend en paramètre une chaîne de caractères (donc une liste)
et la rend sous forme de majuscule

Exemple:
* "toUpperString" retourne "TOUPPERSTRING"
-}
toUpperString :: [Char] -> [Char]
toUpperString l = [toUpper x | x <- l]
