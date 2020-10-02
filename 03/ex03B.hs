module EX03B where
---------------- 1. Configuration of the automata
{-
On choisit de représenter un automate par un triplet de la forme
(state, [state], [transition]) où:
* le premier élément est l'état initial,
* le second élément est la liste des états finaux et
* le troisième élément est la liste des transitions.

Une transition est elle-même un triplet de la forme (state, char, state) où:
* le premier élément est l'état de départ de la transition,
* le second élément est le caractère porté et
* le troisième élément est l'état d'arrivée.
-}
type State = Int
type Transition = (State, Char, State)
type Automate = (State, [State], [Transition])

monAutomate :: Automate
monAutomate = (0, [4], [(0, 'a', 1),  (1, 'b', 2), (1, 'a', 3),  (2, 'a', 4), (2, 'b', 2),  (3, 'b', 4),  (4, 'a', 1)])


---------------- 2. Helpers
{-
cette fonction prend en paramètre une chaîne de caractères et un automate et
retourne vrai si cette chaîne est reconnue par l'automate, et faux sinon.

Exemple:
* `isToken "aababba" monAutomate` retourne True
* `isToken "aaa" monAutomate` retourne False
-}
isToken :: String -> Automate -> Bool
isToken xs automata@(initialS, _, _) = recognizedFromState initialS xs automata


{-
cette fonction prend en paramètre un état state, une chaîne de caractères et un automate.
Elle retourne vrai si la chaîne ch est reconnue par l'automate en partant de l'état state.

Exemple:
* `recognizedFromState 2 "bba" monAutomate` retourne True
** car il existe un chemin de trois transitions partant de l'état 2 et arrivant à un
   état final
* `recognizedFromState 1 "aba" monAutomate` retourne False
** car quand on suit le chemin partant de l'état 1 portant les transitions a, b alors on
   arrive sur l'état 1 qui n'est pas final.
-}
recognizedFromState :: State -> String -> Automate -> Bool
-- Final condition
recognizedFromState state [] automata = isFinalState state automata
-- Consume char
recognizedFromState state (x:xs) automata =
   recognizedFromState nextStateS xs automata
      where nextStateS = nextState state x automata



{-
cette fonction prend en paramètre un état et un automate. Elle retourne vrai si l'état
est final dans cet automate.

Exemple:
* `isFinalState 4 monAutomate` retourne True
* `isFinalState 1 monAutomate` retourne False
-}
isFinalState :: State -> Automate -> Bool
isFinalState state (_, finalStates, _) = elem state finalStates


{-
cette fonction prend en paramètre un état, un caractère et un automate.
Elle retourne l'état d'arrivée de la transition partant de l'état et portant le caractère.
Elle retourne -1 si la transition n'existe pas.

Exemple:
* `nextState 3 'b' monAutomate` retourne 4
* `nextState 3 'a' monAutomate` retourne -1
-}
nextState :: State -> Char -> Automate -> Int
-- Final condition, consumed all transitions
nextState s1 c1 (_, _, []) = -1
-- Consume transitions
nextState s1 c1 (initialState, finals, ((s2, c2, next):xs)) = if c1 == c2 && s1 == s2
   then next
   else nextState s1 c1 (initialState, finals, xs)