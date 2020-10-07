
{-
cette fonction prend en paramètre une liste et retourne la liste applatie,
c'est-à-dire sans élément sous forme de liste

Exemple:
* [[2,3], [4,2,7], [6,9]] retourne la liste [2,3,4,2,7,6,9]
-}
flatten :: [[a]] -> [a]
flatten [] = []
flatten (l:ls) = [x | x <- l] ++ (flatten ls)
{-
cette fonction prend en paramètre une liste et retourne la liste triée

Exemple:
* [7,13,4,2,7,34,1,9] retourne [1,2,4,7,7,9,13,34]
-}
quicksort :: Ord a => [a] -> [a]
quicksort [] = []
quicksort [l] = [l]
quicksort (l:ls) = quicksort [x | x <- ls, x < l] ++ l:(quicksort [x | x <- ls, x > l])

{-
cette fonction prend en paramètre une liste et retourne toutes les
partitions de cette liste

Exemple:
* [1,2,3] retourne [[],[3],[2],[2,3],[1],[1,3],[1,2],[1,2,3]]
-}
partitions :: [a] -> [[a]]
partitions [] = [[]]  
partitions (l:ls) = (partitions ls) ++ [l:x | x <- (partitions ls)]

-- s02
myDelete :: Eq t => t -> [t] -> [t]
myDelete _ [] = []
myDelete e (x:xs) =
  if (e == x)
    then xs
    else x:(myDelete e xs)

{-
cette fonction prend en paramètre une liste et retourne en résultat la liste
des permutations des éléments de cette liste.

Exemple:
* [1,2,3] retourne [[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]]
-}
permutations :: Eq a => [a] -> [[a]]
permutations [] = [[]]
permutations l = [x:xs | x <- l, xs <- permutations (myDelete x l) ]