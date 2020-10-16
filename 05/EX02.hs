module EX02 where

import Data.Char

{-
Dans cet exercice, on poursuit l'analyse lexicale commencée dans l'exercice 3 de la série 03.
Le but de cet exercice est de transformer un texte source d'un mini langage en une suite
de tokens. Les tokens reconnus pour ce langage sont :
* begin_block qui est exprimé par le caractère '{'
* end_block qui est exprimé par le caractère '}'
* begin_par qui est exprimé par le caractère '('
* end_par qui est exprimé par le caractère ')'
* seminolon qui est exprimé par le caractère ';'
* op_eg qui est exprimé par la suite de caractère "=="
* op_affect qui est exprimé par le caractère '='
* op_add qui est exprimé par le caractère '+'
* op_minus qui est exprimé par le caractère '-'
* op_mult qui est exprimé par le caractère '*'
* op_div qui est exprimé par le caractère '/'
* type_int qui est exprimé par la suite de caractères "int"
* cond qui est exprimé par la suite de caractères "if"
* loop qui est exprimé par la suite de caractères "while"
* value_int qui est exprimé par une suite de caractère respectant l'expression régulière
    [0..9]+
* ident qui est exprimé par une suite de caractère respectant l'expression régulière
    [a..zA..Z_][a..zA..Z0..9_]*



Les types introduits dans la série 03 sont en partie repris et complétés comme suit :
* un état d'un automate est modélisé par un entier
    type State = Int

* une transition d'un automate est modélisée par un triplet : l'état de départ de la
transition, une fonction booléenne qui décrit le caractère porté par la transition et
l'état d'arrivée de la transition
    type Transition = (State,(Char->Bool),State)

* un automate est modélisé par un triplet : l'état initial de l'automate, la liste de ses
états finaux, et la liste de ses transitions
    type StateMachine = (State, [State], [Transition])

* le code représentant un token est modélisé par une chaîne de caractères
    type Code = String

* un token est modélisé par un couple : l'automate modélisant le token et son code
    type Token = (StateMachine,Code)
-}
type State = Int
type TransInitState = State
type TransFinalState = State
type Transition = (TransInitState, (Char->Bool), TransFinalState)
type InitialState = State
type FinalStates = [State]
type StateMachine = (InitialState, FinalStates, [Transition])
type Code = String
type Token = (StateMachine, Code)

{-
Exemples :
* le token begin_block est représenté par le doublet :
    ( (0, [1], [( 0, (=='{'), 1 )] ), "begin_block")
où
    (0, [1], [( 0, (=='{'), 1 )])
est l'automate qui reconnaît la chaîne de caractère "{" (0, (=='{'),1) est la seule
transition de cet automate. Son état de départ est l'état 0, son état d'arrivée est
l'état 1 et le caractère porté satisfait le prédicat (=='{')

* le token op_eg est représenté par le doublet
    ( (0,[2],[(0,(=='='),1),(1,(=='='),2)] ),"op_eg")
où
    (0,[2],[(0,(=='='),1),(1,(=='='),2)] )
est l'automate qui reconnaît la chaîne de caractères "=="



Important : dans cet exercice, par souci de simplification, on suppose que tous les
tokens du texte à analyser sont séparés par des espaces.
Exemple de texte : "int x ; int y ; x = y * 2 ; "



Travail à faire :
* Représentez chacun des tokens de ce langage
Exemple :
    t1 = ( (0, [1], [( 0, (=='{'), 1 )] ), "begin_block")

Indications : vous pouvez utiliser des fonctions prédéfinies du module Date.Char telle que la
fonction isDigit x qui retourne vrai si le caractère x est un chiffre et faux sinon
-}

{-
begin_block : '{'
-}
t1 :: Token
t1 = (
        ( -- StateMachine
            0, -- Initial state
            [1], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== '{'), -- char predicate
                    1 -- following state
                )
            ]

        ),
        "begin_block" -- Code
    )

{-
end_block : '}'
-}
t2 :: Token
t2 = (
        ( -- StateMachine
            0, -- Initial state
            [1], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== '}'), -- char predicate
                    1 -- following state
                )
            ]

        ),
        "end_block" -- Code
    )

{-
begin_par : '('
-}
t3 :: Token
t3 = (
        ( -- StateMachine
            0, -- Initial state
            [1], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== '('), -- char predicate
                    1 -- following state
                )
            ]

        ),
        "bengin_par" -- Code
    )

{-
end_par : ')'
-}
t4 :: Token
t4 = (
        ( -- StateMachine
            0, -- Initial state
            [1], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== ')'), -- char predicate
                    1 -- following state
                )
            ]

        ),
        "end_par" -- Code
    )

{-
seminolon : ';'
-}
t5 :: Token
t5 = (
        ( -- StateMachine
            0, -- Initial state
            [1], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== ';'), -- char predicate
                    1 -- following state
                )
            ]

        ),
        "semiolon" -- Code
    )

{-
op_eg : "=="
-}
t6 :: Token
t6 = (
        ( -- StateMachine
            0, -- Initial state
            [2], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== '='), -- char predicate
                    1 -- following state
                ),
                (
                    1, -- initial state
                    (== '='), -- char predicate
                    2 -- following state
                )
            ]

        ),
        "op_eg" -- Code
    )

{-
op_affect : '='
-}
t7 :: Token
t7 = (
        ( -- StateMachine
            0, -- Initial state
            [1], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== '='), -- char predicate
                    1 -- following state
                )
            ]

        ),
        "op_affect" -- Code
    )

{-
op_add : '+'
-}
t8 :: Token
t8 = (
        ( -- StateMachine
            0, -- Initial state
            [1], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== '1'), -- char predicate
                    1 -- following state
                )
            ]

        ),
        "op_add" -- Code
    )

{-
op_minus : '-'
-}
t9 :: Token
t9 = (
        ( -- StateMachine
            0, -- Initial state
            [1], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== '-'), -- char predicate
                    1 -- following state
                )
            ]

        ),
        "op_minus" -- Code
    )

{-
op_mult : '*'
-}
t10 :: Token
t10 = (
        ( -- StateMachine
            0, -- Initial state
            [1], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== '*'), -- char predicate
                    1 -- following state
                )
            ]

        ),
        "op_mult" -- Code
    )

{-
op_div : '/'
-}
t11 :: Token
t11 = (
        ( -- StateMachine
            0, -- Initial state
            [1], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== '/'), -- char predicate
                    1 -- following state
                )
            ]

        ),
        "op_div" -- Code
    )

{-
type_int : "int"
-}
t12 :: Token
t12 = (
        ( -- StateMachine
            0, -- Initial state
            [3], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== 'i'), -- char predicate
                    1 -- following state
                ),
                (
                    1, -- initial state
                    (== 'n'), -- char predicate
                    2 -- following state
                ),
                (
                    2, -- initial state
                    (== 't'), -- char predicate
                    3 -- following state
                )
            ]

        ),
        "type_int" -- Code
    )

{-
cond : "if"
-}
t13 :: Token
t13 = (
        ( -- StateMachine
            0, -- Initial state
            [2], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== 'i'), -- char predicate
                    1 -- following state
                ),
                (
                    1, -- initial state
                    (== 'f'), -- char predicate
                    2 -- following state
                )
            ]

        ),
        "if" -- Code
    )

{-
loop : "while"
-}
t14 :: Token
t14 = (
        ( -- StateMachine
            0, -- Initial state
            [5], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    (== 'w'), -- char predicate
                    1 -- following state
                ),
                (
                    1, -- initial state
                    (== 'h'), -- char predicate
                    2 -- following state
                ),
                (
                    2, -- initial state
                    (== 'i'), -- char predicate
                    3 -- following state
                ),
                (
                    3, -- initial state
                    (== 'l'), -- char predicate
                    4 -- following state
                ),
                (
                    4, -- initial state
                    (== 'e'), -- char predicate
                    5 -- following state
                )
            ]

        ),
        "loop" -- Code
    )

{-
value_int : [0..9]+
-}
t15 :: Token
t15 = (
        ( -- StateMachine
            0, -- Initial state
            [1], -- Final state
            [ -- Transition
                (
                    0, -- initial state
                    isDigit, -- char predicate
                    1 -- following state
                ),
                (
                    1, -- initial state
                    isDigit, -- char predicate
                    1 -- following state
                )
            ]

        ),
        "value_int" -- Code
    )

{-
ident : [a..zA..Z_][a..zA..Z0..9_]*
-}
t16 :: Token
t16 = (
        ( -- StateMachine
            0, -- Initial state
            [1], -- Final state
            [ -- Transition
                -- "first group"
                ( -- [a-zA-Z]
                    0, -- initial state
                    isAlpha, -- char predicate
                    1 -- following state
                ),
                ( -- _
                    0, -- initial state
                    (== '_'), -- char predicate
                    1 -- following state
                ),
                -- "second optional group"
                ( -- [a-zA-Z]
                    1, -- initial state
                    isAlpha, -- char predicate
                    1 -- following state
                ),
                ( -- [0-9]
                    1, -- initial state
                    isDigit, -- char predicate
                    1 -- following state
                ),
                ( -- _
                    1, -- initial state
                    (== '_'), -- char predicate
                    1 -- following state
                )
            ]

        ),
        "ident" -- Code
    )


{-
* Implémentez les fonctions qui suivent :
-}

{-
** getToken :: String -> [Token] -> Code
cette fonction prend une chaîne de caractères et retourne le code du token correspondant
à cette chaîne

Exemple : l'appel
* `getToken "toto" <liste des tokens du langage>` retourne `"ident"`
car "toto" est reconnu par l'automate du token "ident"

Indications :
cette fonction crée une exception si la chaîne de caractères passée en paramètre ne
correspond à aucun token. Vous pouvez générer une exception grâce à la fonction
error ch. Elle crée une exception et affiche la chaîne de caractères ch.
Reprenez et adaptez au besoin les fonctions isToken, recognizedFromState,
isFinalState, nextState de la seconde partie de l'exercice 3 de la série 3.
-}
getToken :: String -> [Token] -> Code
getToken [] _ = error "Empty token is invalid"
getToken _ [] = error "Didn't find any corresponding token for the given string"
getToken xs ((sm, code): sms) = if isToken xs sm
    then code
    else getToken xs sms

{- ---------------------- -}

{-
cette fonction prend en paramètre une chaîne de caractères et un automate et
retourne vrai si cette chaîne est reconnue par l'automate, et faux sinon.

Exemple:
* `isToken "aababba" monAutomate` retourne True
* `isToken "aaa" monAutomate` retourne False
-}
isToken :: String -> StateMachine -> Bool
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
recognizedFromState :: State -> String -> StateMachine -> Bool
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
isFinalState :: State -> StateMachine -> Bool
isFinalState state (_, finalStates, _) = elem state finalStates



{-
cette fonction prend en paramètre un état, un caractère et un automate.
Elle retourne l'état d'arrivée de la transition partant de l'état et portant le caractère.
Elle retourne -1 si la transition n'existe pas.

Exemple:
* `nextState 3 'b' monAutomate` retourne 4
* `nextState 3 'a' monAutomate` retourne -1
-}
nextState :: InitialState -> Char -> StateMachine -> Int
-- Final condition, consumed all transitions
nextState _ _ (_, _, []) = -1
-- Consume transitions
nextState s1 char (initialState, finals, ((s2, charPredicate, next):xs)) =
    if s1 == s2 && charPredicate char
        then next
        else nextState s1 char (initialState, finals, xs)

{- ---------------------- -}

{-
** lexAnalyse :: String -> [token] -> [Code]
cette fonction prend un texte source en paramètre et retourne la liste des tokens
correspondant.

Indication : Vous pouvez utiliser la fonction words qui permet de séparer une chaîne
de caractères en liste de mots.
Exemple :
* `words "int a ; int b ;"` retourne `["int", "a", ";", "int", "b", ";"]`

Exemple : l'appel
* `lexAnalyse "int x ; int y ; x = y * 2 ; " <liste des tokens du langage>` retourne la liste
`["type_int", "ident", "semicolon", "type_int", "ident", "semicolon",
"ident", "op_affect", "ident", "op_mult", "value_int", "semilocon"]`
-}
lexAnalyse :: String -> [Token] -> [Code]
lexAnalyse xs ts = map (`getToken` ts) xss
    where xss = words xs
