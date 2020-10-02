
{-
cette fonction prend en paramètre une liste et retourne en résultat la liste
des permutations des éléments de cette liste.

Exemple:
* [1,2,3] retourne [[1,2,3], [1,3,2], [2,1,3], [2,3,1], [3,1,2], [3,2,1]]

TODO: Utilisez une liste en compréhension et la fonction myDelete de la série précédente.
N'utilisez pas de fonctions d'ordre supérieur.
-}
permutations :: [a] -> [[a]]
permutations = undefined

-- implementation found: https://stackoverflow.com/a/19034050/3771148
permutations' :: [a] -> [[a]]
permutations' [] = [[]]
permutations' (x:xs) = [bs ++ x:cs | p' <- permutations xs, (bs, cs) <- splits p']
    where
        splits [] = [ ([], []) ]
        splits (y:ys) = ([], y:ys) : [(y:bs, cs) | (bs, cs) <- splits ys]