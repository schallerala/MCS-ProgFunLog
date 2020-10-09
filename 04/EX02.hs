module EX02 where

{-
Cette fonction calcule la valeur du polynôme poly pour x = v
Le polynôme 2x +4x^2 -2x^4 est représenté par la liste [(2,1), (4,2), (-2,4)]
--

Exemple :
* `calculatePolynomial [(2,1), (4,2), (-2,4)] 3` retourne `-120`
-}
--

-- version récursive
calculatePolynomial1 :: [(Int, Int)] -> Int -> Int
calculatePolynomial1 [] _ = 0
calculatePolynomial1 ((c,d):ps) v =  c * v ^ d + (calculatePolynomial1 ps v)

-- version avec liste de compréhension
calculatePolynomial2 :: [(Int, Int)] -> Int -> Int
calculatePolynomial2 poly v = sum [ c * v ^ d | (c,d) <- poly]

-- version avec fonction anonyme et fonction d'ordre supérieur
calculatePolynomial3 :: [(Int, Int)] -> Int -> Int
calculatePolynomial3 poly v =  sum (map (\(c,d) -> c * v ^d) poly)