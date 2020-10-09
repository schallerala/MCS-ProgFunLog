module EX01 where

{-
cette fonction prend en paramètre une valeur et une liste triée par ordre
croissant et insère l'élément à sa place dans la liste

Exemple :
* `myInsert 7 [2,5,8,9]` retourne `[2,5,7,8,9]`
-}
myInsert :: Ord a => a -> [a] -> [a]
myInsert x [] = [x]
myInsert a (x:xs) =
    if a > x
        then x:(myInsert a xs)
        else a:x:xs

{-
cette fonction trie la liste selon l'algorithme du tri par insertion.

Rappel : Le tri par insertion consiste à trier la liste privée de son premier élément,
puis à y insérer cet élément.
-}
insertionSort :: Ord a => [a] -> [a]
insertionSort [] = []
insertionSort [x] = [x]
insertionSort (x:xs) = insert x sorted
    where
        sorted = insertionSort xs
        insert a [] = [a]
        insert a (y:ys) =
            if a < y
                then a : y : ys
                else y : insert a ys

{-
cette fonction est équivalente à la fonction prédéfinie takeWhile
-}
myTakeWhile :: (a -> Bool) -> [a] -> [a]
myTakeWhile _ [] = []
myTakeWhile f (x:xs) =
    if f x
        then x:(myTakeWhile f xs)
        else []

{-
cette fonction est équivalente à la fonction prédéfinie zipWith
-}
myZipWith :: (a -> a -> a) -> [a] -> [a] -> [a]
myZipWith _ [] [] = []
myZipWith f (x:xs) (y:ys) = f x y : myZipWith f xs ys

{-
cette fonction retourne l'intersection ensembliste des deux listes
passées en paramètre.

Développez trois versions de cette fonction :
1. une version récursive,
2. une version avec une fonction d'ordre supérieur,
3. une version avec une liste en compréhension
-}
-- Récursive
myIntersect :: Eq a => [a] -> [a] -> [a]
myIntersect [] _ = []
myIntersect _ [] = []
myIntersect (x:xs) ys =
    if elem x ys
        then x : myIntersect xs ys
        else myIntersect xs ys

-- Ordre supérieur
myIntersect' :: Eq a => [a] -> [a] -> [a]
myIntersect' xs ys = filter (`elem` ys) xs

-- liste en compréhension
myIntersect'' :: Eq a => [a] -> [a] -> [a]
myIntersect'' xs ys = [x | x <- xs, elem x ys]


{-
cette fonction retourne la liste des diviseurs de v compris dans l'intervalle [1..v-1].

Développez trois versions de cette fonction :
1. une version récursive,
2. une version avec la fonction filter et une fonction anonyme,
3, et une version avec une liste en compréhension

Exemple :
* `divisorsList 9` retourne `[1,3]`
-}
-- Récursive
divisorsList :: Int -> [Int]
divisorsList y = addDivisors [1..y-1]
    where
        addDivisors [] = []
        addDivisors (x:xs) = if mod y x == 0
            then x : addDivisors xs
            else addDivisors xs

-- avec fonction filter et fonction anonyme
divisorsList' :: Int -> [Int]
divisorsList' y = filter (\x -> mod y x == 0) [1..y-1]

-- liste en compréhension
divisorsList'' :: Int -> [Int]
divisorsList'' y = [x | x <- [1..y-1], mod y x == 0]


{-
cette fonction retourne True si v est un nombre parfait. Un nombre est
parfait si la somme des diviseurs de x compris dans [1..x-1] est égale à x.

Exemple :
* `perfectNumber 6` retourne `True`
** car 6 = 1 + 2 + 3
-}
perfectNumber :: Int -> Bool
perfectNumber x = sum (divisorsList x) == x

{-
cette fonction retourne les n premiers nombres parfaits.

Exemple :
* `perfectNumbers 4` retourne `[6,28,496,8128]`
-}
perfectNumbers :: Int -> [Int]
perfectNumbers x = take x [y | y <- [1..], perfectNumber y]