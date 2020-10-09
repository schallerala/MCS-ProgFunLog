module EX01 where

{-
 cette fonction prend en paramètre une valeur et une liste triée par ordre
croissant et insère l'élément à sa place dans la liste

Exemple :
* `myInsert 7 [2,5,8,9]` retourne `[2,5,7,8,9]`
-}
myInsert :: Ord a => a -> [a] -> [a]
myInsert = undefined
{-
cette fonction trie la liste selon l'algorithme du tri par insertion.

Rappel : Le tri par insertion consiste à trier la liste privée de son premier élément,
puis à y insérer cet élément.
-}
insertionSort :: Ord a => [a] -> [a]
insertionSort = undefined

{-
cette fonction est équivalente à la fonction prédéfinie takeWhile
-}
myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile = undefined

{-
cette fonction est équivalente à la fonction prédéfinie zipWith
-}
myZipWith :: (a -> a -> a) -> [a] -> [b] -> [a]
myZipWith = undefined

{-
cette fonction retourne l'intersection ensembliste des deux listes
passées en paramètre.

Développez trois versions de cette fonction :
1. une version récursive,
2. une version avec une fonction d'ordre supérieur,
3. une version avec une liste en compréhension
-}
-- Récursive
myIntersect :: [a] -> [a] -> [a]
myIntersect = undefined
-- Ordre supérieur
myIntersect' :: [a] -> [a] -> [a]
myIntersect' = undefined
-- liste en compréhension
myIntersect'' :: [a] -> [a] -> [a]
myIntersect'' = undefined

{-
cette fonction retourne la liste des diviseurs de v compris dans l'intervalle [1..v-1].

Développez trois versions de cette fonction :
1. une version récursive,
2. une version avec la fonction filter
3. et une fonction anonyme,
4, et une version avec une liste en compréhension

Exemple :
* `divisorsList 9` retourne `[1,3]`
-}
-- Récursive
divisorsList :: Int -> [Int]
divisorsList = undefined
-- avec fonction filter
divisorsList' :: Int -> [Int]
divisorsList' = undefined
-- fonction anonyme
divisorsList'' :: Int -> [Int]
divisorsList'' = undefined
-- liste en compréhension
divisorsList''' :: Int -> [Int]
divisorsList''' = undefined

{-
cette fonction retourne True si v est un nombre parfait. Un nombre est
parfait si la somme des diviseurs de x compris dans [1..x-1] est égale à x.

Exemple :
* `perfectNumber 6` retourne `True`
** car 6 = 1 + 2 + 3
-}
perfectNumber :: Int -> Bool
perfectNumber = undefined

{-
cette fonction retourne les n premiers nombres parfaits.

Exemple :
* `perfectNumbers 4` retourne `[6,28,496,8128]`
-}
perfectNumbers :: Int -> [Int]
perfectNumbers = undefined