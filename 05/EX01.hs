module EX01 where
{-
cette fonction retourne la valeur de fibonacci de n

Exemple :
* `fibo 4` retourne `3`
-}

-- avec accumulateur
fibo :: Int -> Int
fibo n = fib n 0 1 where
    fib :: Int -> Int -> Int -> Int
    fib 0 acc1 _  = acc1
    fib n acc1 acc2 = fib (n-1) acc2 $! acc1 + acc2

-- avec programmation continue
fibo' :: Int -> Int
fibo' n = fib n (\x -> x) where
    fib :: Int -> (Int -> Int) -> Int
    fib 0 cont = cont 0
    fib 1 cont = cont 1
    fib n cont = fib (n-1) (\acc1 -> fib (n-2) (\acc2 -> cont acc1 + acc2))

{-
cette fonction retourne le produit des éléments de la liste passée en paramètre

Exemple :
* `myProduct [1,2,3,4]` retourne `24`
-}
-- avec accumulateur
myProduct :: Num t => [t] -> t
myProduct list = myProd list 1 where
    myProd :: Num t => [t] -> t -> t
    myProd [] acc = acc
    myProd (x:xs) acc = myProd xs $! (acc * x)

-- avec programmation par continuation
myProduct' :: Num a => [a] -> a
myProduct' list = myProd list (\x -> x) where
    myProd :: Num a => [a] -> (a -> a) -> a
    myProd [] cont = cont 0
    myProd [x] cont = cont x
    myProd (x:xs) cont = myProd xs (\y -> cont x*y)

-- avec plis
myProduct'':: (Foldable t, Num a) => t a -> a
myProduct'' list = foldl1 (\acc x -> acc * x) list


{-
cette fonction prend en paramètre une liste de listes et retourne en résultat la
liste aplatie

Exemple :
* `myFlatten [[2,3], [4,2,7], [6,9]]` retourne `[2,3,4,2,7,6,9]`
-}
-- avec accumulateur
myFlatten :: [[a]] -> [a]
myFlatten list = myFlat list [] where
    myFlat :: [[a]] -> [a] -> [a]
    myFlat [] acc = acc
    myFlat (x:xs) acc = myFlat xs $! (acc ++ x)

-- avec programmation par continuation
myFlatten' :: [[a]] -> [a]
myFlatten' list = myFlat list (\x -> x) where
    myFlat :: [[a]] -> ([a] -> [a]) -> [a]
    myFlat [] cont = cont []
    myFlat [x] cont = cont x
    myFlat (x:xs) cont = myFlat xs (\y -> cont x ++ y)

-- avec plis à gauche
myFlatten'' :: Foldable t => t [a] -> [a]
myFlatten'' list = foldl (\acc x -> acc ++ x) [] list

-- avec plis à droite
myFlatten''' :: Foldable t => t [a] -> [a]
myFlatten''' list = foldr (\x acc -> x ++ acc) [] list


{-
cette fonction retourne la liste sans toutes ses occurrences de e

Exemple :
* `deleteAll 3 [1,2,3,2,3]` retourne `[1,2,2]`

-}
-- avec accumulateur
deleteAll :: Eq a => a -> [a] -> [a]
deleteAll e list = del e list [] where
    del:: Eq a => a -> [a] -> [a] -> [a]
    del _ [] acc = acc
    del e (x:xs) acc
        | e == x = del e xs acc
        | otherwise = del e xs $! (acc ++ [x])

-- avec programmation par continuation
deleteAll' :: Eq a => a -> [a] -> [a]
deleteAll' e list = del e list (\x -> x) where
    del :: Eq a => a -> [a] -> ([a] -> p) -> p
    del _ [] cont = cont []
    del e (x:xs) cont
        | e /= x = del e xs (\y -> cont (x:y))
        | otherwise = del e xs (\y -> cont y)

-- avec plis
deleteAll'' :: Eq a => a -> [a] -> [a]
deleteAll'' _ [] = []
deleteAll'' e list = foldr (\x acc -> if x /= e then x : acc else acc) [] list


{-
cette fonction prend en paramètre une valeur et une liste triée par ordre
croissant et insère l'élément à sa place dans la liste.
Exemple :
* `myInsert 7 [2,5,8,9]` retourne `[2,5,7,8,9]`
-}
-- avec accumulateur
myInsert :: Ord a => a -> [a] -> [a]
myInsert e list = insert e list [] where
    insert :: Ord a => a -> [a] -> [a] -> [a]
    insert _ [] acc = acc
    insert e (x:xs) acc
        | e < x =  acc ++ [e] ++ (x:xs)
        | otherwise = insert e xs (acc ++ [x])


-- avec programmation par continuation
myInsert' :: Ord a => a -> [a] -> [a]
myInsert' e list = insert e list (\x -> x) where
    insert :: Ord a => a -> [a] -> ([a] -> p) -> p
    insert e [] cont = cont [e]
    insert e [x] cont
        | e > x = cont [x,e] 
        | otherwise = cont [x]
    insert e (x:xs) cont
        | e <= x = cont (e:x:xs)
        | otherwise = insert e xs (\y -> cont (x:y))
        
