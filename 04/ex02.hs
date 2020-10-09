module EX02 where

{-
Cette fonction calcule la valeur du polynôme poly pour x = v
Le polynôme 2x + 4x^2 -2x 4 est représenté par la liste [(2,1), (4,2), (-2,4)]
-- 

Exemple :
* `calculatePolynomial [(2,1), (4,2), (-2,4)]` retourne `-120`
-}
-- 

-- version récursive
calculatePolynomial1 :: (Integral b, Num t) => [(t, b)] -> t -> t
calculatePolynomial1 [(c,d)] v = c * v ^ d
calculatePolynomial1 ((c,d):ps) v =  c * v ^ d + (calculatePolynomial1 ps v)

-- version avec liste de compréhension
calculatePolynomial2 :: (Integral b, Num a) => [(a, b)] -> a -> a
calculatePolynomial2 poly v = sum [ c * v ^ d | (c,d) <- poly]

-- version avec fonction anonyme et fonction d'ordre supérieur
calculatePolynomial3 :: (Integral b1, Num b2) => ([b2] -> t) -> [(b2, b1)] -> b2 -> t
calculatePolynomial3 fct poly v =  fct (map (\(c,d) -> c * v ^d) poly)


main = do
  print (calculatePolynomial1 [(2,1), (4,2), (-2,4)] 3)
  print (calculatePolynomial2 [(2,1), (4,2), (-2,4)] 3)
  print (calculatePolynomial3 sum [(2,1), (4,2), (-2,4)] 3)