module EX01 where
{-
cette fonction retourne la valeur de fibonacci de n

Exemple :
* `fibo 4` retourne `3`
-}

-- avec accumulateur
fibo :: (Eq a, Num a, Num t) => a -> t
fibo n = fibo' n 0

fibo' :: (Eq a, Num a, Num t) => a -> t -> t
fibo' 0 acc = acc
fibo' 1 acc = acc + 1
fibo' n acc = fibo' (n-2) (fibo' (n-1) acc)

-- avec programmation continue
fibo'' :: (Eq a1, Num a1, Num t, Num a2) => a1 -> (t -> a2) -> a2
fibo'' 0 cont = cont 0
fibo'' 1 cont = cont 1
fibo'' n cont = fibo'' (n-1) (\x -> cont x + (fibo (n-2)))

{-
cette fonction retourne le produit des éléments de la liste passée en paramètre

Exemple :
* `myProduct [1,2,3,4]` retourne `24`
-}
-- avec accumulateur
myProduct :: Num t => [t] -> t
myProduct list = myProduct' list 1

myProduct' :: Num t => [t] -> t -> t
myProduct' [] acc = acc
myProduct' (x:xs) acc = myProduct' xs (acc * x)

factCont :: (Eq t, Num t) => t -> (t -> p) -> p
factCont 0 cont = cont 1
factCont n cont = factCont (n-1) (\x -> cont (n * x))

-- avec programmation par continuation
myProduct'' :: Num a => [a] -> (a -> a) -> a
myProduct'' [] cont = cont 0
myProduct'' [x] cont = cont x
myProduct'' (x:xs) cont = myProduct'' xs (\y -> cont x*y)

-- avec plis
myProduct''' :: (Foldable t, Num a) => t a -> a
myProduct''' list = foldl1 (\acc x -> acc * x) list


{-
cette fonction prend en paramètre une liste de listes et retourne en résultat la
liste aplatie

Exemple :
* `myFlatten [[2,3], [4,2,7], [6,9]]` retourne `[2,3,4,2,7,6,9]`
-}
-- avec accumulateur
myFlatten :: [[a]] -> [a]
myFlatten list = myFlatten' list []

myFlatten' :: [[a]] -> [a] -> [a]
myFlatten' [] acc = acc
myFlatten' (x:xs) acc = myFlatten' xs (acc ++ x)
-- avec programmation par continuation
myFlatten'' :: [[a]] -> ([a] -> [a]) -> [a]
myFlatten'' [] cont = cont []
myFlatten'' [x] cont = cont x
myFlatten'' (x:xs) cont = myFlatten'' xs (\y -> cont x ++ y)

-- avec plis à gauche
myFlatten''' :: Foldable t => t [a] -> [a]
myFlatten''' list = foldl (\acc x -> acc ++ x) [] list

-- avec plis à droite
myFlatten'''' :: Foldable t => t [a] -> [a]
myFlatten'''' list = foldr (\x acc -> x ++ acc) [] list


{-
cette fonction retourne la liste sans toutes ses occurrences de e

Exemple :
* `deleteAll 3 [1,2,3,2,3]` retourne `[1,2,2]`

-}
-- avec accumulateur
deleteAll :: Eq a => a -> [a] -> [a]
deleteAll e list = deleteAll' e list []

deleteAll' :: Eq a => a -> [a] -> [a] -> [a]
deleteAll' _ [] acc = acc
deleteAll' e (x:xs) acc = 
    if (e == x)
        then deleteAll' e xs acc
        else deleteAll' e xs (acc ++ [x])

-- avec programmation par continuation
deleteAll'' :: Eq a => a -> [a] -> ([a] -> p) -> p
deleteAll'' _ [] cont = cont []
deleteAll'' e (x:xs) cont = deleteAll'' e xs (\y -> if e /= x then cont (x:y) else cont y)

-- avec plis
deleteAll''' :: Eq a => a -> [a] -> [a]
deleteAll''' _ [] = []
deleteAll''' e list = foldr (\x acc -> if x /= e then x : acc else acc) [] list


{-
cette fonction prend en paramètre une valeur et une liste triée par ordre
croissant et insère l'élément à sa place dans la liste.
Exemple :
* `myInsert 7 [2,5,8,9]` retourne `[2,5,7,8,9]`
-}
-- avec accumulateur
myInsert :: Ord a => a -> [a] -> [a]
myInsert e list = myInsert' e list []

myInsert' :: Ord a => a -> [a] -> [a] -> [a]
myInsert' _ [] acc = acc
myInsert' e (x:xs) acc = 
    if e < x
        then acc ++ [e] ++ (x:xs)
        else myInsert' e xs (acc ++ [x])


-- avec programmation par continuation
myInsert'' :: Ord a => a -> [a] -> ([a] -> p) -> p
myInsert'' _ [] cont = cont []
myInsert'' e [x] cont = if e >= x then cont [x,e] else cont [x]
myInsert'' e (x:y:xs) cont = myInsert'' e (y:xs) (\z -> if e >= x && e <= y then cont (x:e:z) else cont (x:z))