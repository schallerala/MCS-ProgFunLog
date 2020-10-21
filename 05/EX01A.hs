module EX01A where

{-
fibo n : cette fonction retourne la valeur de fibonacci de n.

Développez deux versions de cette fonction :
1. une version avec accumulateur
2. et une version avec programmation par continuation.
-}
{- Accumulateur -}
fibo :: Int -> Int
fibo = undefined

{- Continuation -}
fibo' :: Int -> Int
fibo' = undefined

{-
myProduct list : cette fonction retourne le produit des éléments de la liste passée en
paramètre.

Développez trois versions de cette fonction :
1. une version avec accumulateur,
2. une version avec programmation par continuation
3. et une version avec un plis.
-}
{- Accumulateur -}
myProduct :: [Int] -> Int
myProduct = undefined

{- Continuation -}
myProduct' :: [Int] -> Int
myProduct' = undefined

{- Fold -}
myProduct'' :: [Int] -> Int
myProduct'' = undefined

{-
myFlatten list : cette fonction prend en paramètre une liste de listes et retourne en
résultat la liste aplatie.

Développez quatre versions de cette fonction :
1. une version avec accumulateur,
2. une version avec programmation par continuation,
3. une version avec un plis à gauche
4. et une version avec un plis à droite.

Exemple :
* `myFlatten [[2,3], [4,2,7], [6,9]]` retourne `[2,3,4,2,7,6,9]`
-}
{- Accumulateur -}
myFlatten :: [[a]] -> [a]
myFlatten = undefined

{- Continuation -}
myFlatten' :: [[a]] -> [a]
myFlatten' = undefined

{- Left fold -}
myFlatten'' :: [[a]] -> [a]
myFlatten'' = undefined

{- Right Fold -}
myFlatten''' :: [[a]] -> [a]
myFlatten''' = undefined

{-
deleteAll e list : retourne la liste sans toutes ses occurrences de e.

Développez trois versions de cette fonction :
1. une version avec accumulateur,
2. une version avec programmation par continuation
3. et une version avec un plis.
-}
{- Accumulateur -}
deleteAll :: a -> [a] -> [a]
deleteAll = undefined

{- Continuation -}
deleteAll' :: a -> [a] -> [a]
deleteAll' = undefined

{- Fold -}
deleteAll'' :: a -> [a] -> [a]
deleteAll'' = undefined

{-
myInsert e list : cette fonction prend en paramètre une valeur et une liste triée par
ordre croissant et insère l'élément à sa place dans la liste.

Développez deux versions de cette fonction :
1. une version avec accumulateur
2. et une version avec programmation par continuation.

Exemple :
* `myInsert 7 [2,5,8,9]` retourne `[2,5,7,8,9]`
-}
{- Accumulateur -}
myInsert :: Ord a => a -> [a] -> [a]
myInsert = undefined

{- Continuation -}
myInsert' :: Ord a => a -> [a] -> [a]
myInsert' = undefined