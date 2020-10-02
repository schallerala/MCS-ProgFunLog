module EX03A where
---------------- 1. Configuration of the automata
{-
cette fonction retourne vrai si le Int passé en paramètre est un
état de sortie et faux sinon
-}
isFinalState :: Int -> Bool
isFinalState 4 = True
isFinalState _ = False


{-
cette fonction sans paramètre retourne en résultat l'état initial
-}
firstState :: Int
firstState = 0


{-
cette fonction prend en paramètre un état e et un caractère c et retourne en résultat
l'état d'arrivée en suivant la transition qui part de l'état e en portant le caractère c.

Elle retourne -1 s’il n'y a pas de transition portant le caractère c partant de l'état e.

Exemple:
* `transition 1 'b'` retourne 2
* `transition 4 'b'` retourne -1
-}
transition :: Int -> Char -> Int
transition 0 'a' = 1
transition 1 'a' = 3
transition 1 'b' = 2
transition 2 'b' = 2
transition 2 'a' = 4
transition 3 'b' = 4
transition 4 'a' = 1
transition _ _ = -1


---------------- 2. Helpers
{-
cette fonction prend en paramètre une chaîne de caractère et retourne
vrai si cette chaîne est reconnue par l'automate, et faux sinon.

Exemple:
* `isToken "aababba"` retourne True
* `isToken "aaa"` retourne False
-}
isToken :: String -> Bool
isToken xs = recognizedFromState firstState xs


{-
cette fonction prend en paramètre un état state et
une chaîne de caractères. Elle retourne vrai si la chaîne ch est reconnue par
l'automate en partant de l'état state.

Exemple:
* `recognizedFromState 2 "bba"` retourne True
** car il existe un chemin de trois transitions partant de l'état 2 et arrivant à
   un état final
* `recognizedFromState 1 "aba"` retourne False
** car quand on suit le chemin partant de l'état 1 portant les transitions a, b alors
   on arrive sur l'état 1 qui n'est pas final.
-}
recognizedFromState :: Int -> String -> Bool
-- Final condition
recognizedFromState state [] = isFinalState state
-- Consume char
recognizedFromState state (x:xs) =
   recognizedFromState nextState xs
      where nextState = transition state x