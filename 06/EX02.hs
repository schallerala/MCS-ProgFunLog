module EX02 where

import Data.Char

{-
Dans cet exercice, on poursuit l'analyse lexicale commencée dans l'exercice 2 de la série
05. Les tokens reconnus pour ce langage sont :

* `begin_block` qui est exprimé par le caractère '{'
* `end_block` qui est exprimé par le caractère '}'
* `begin_par` qui est exprimé par le caractère '('
* `end_par` qui est exprimé par le caractère ')'
* `seminolon` qui est exprimé par le caractère ';'
* `op_eg` qui est exprimé par la suite de caractère "=="
* `op_affect` qui est exprimé par le caractère '='
* `op_add` qui est exprimé par le caractère '+'
* `op_minus` qui est exprimé par le caractère '-'
* `op_mult` qui est exprimé par le caractère '*'
* `op_div` qui est exprimé par le caractère '/'
* `type_int` qui est exprimé par la suite de caractères "int"
* `cond` qui est exprimé par la suite de caractères "if"
* `loop` qui est exprimé par la suite de caractères "while"
* `value_int` qui est exprimé par une suite de caractère respectant l'expression régulière
  [0..9]+
* `ident` qui est exprimé par une suite de caractère respectant l'expression régulière
  [a..zA..Z_][a..zA..Z0..9_]*

Les types introduits dans la série 05 sont en partie repris et transformés comme suit :
* `type State = Int`
* `type Code = String`
* `type Transition = (State, (Char->Bool), State)`
* `data StateMachine = StateMachine State [State] [Transition]`
* `data Token = Token StateMachine Code`
-}
type State = Int
type Code = String

type TransInitState = State
type TransFinalState = State
type Transition = (TransInitState, (Char->Bool), TransFinalState)


type InitialState = State
type FinalStates = [State]
data StateMachine = StateMachine InitialState FinalStates [Transition]

data Token = Token StateMachine Code

{-
Exemples :
* token `begin_block` est représenté par la valeur de type Token suivante :
** (Token (StateMachine 0 [1] [( 0, (=='{'), 1 )] ) "begin_block")
où (StateMachine 0 [1] [( 0, (=='{'), 1 )]) est l'automate qui reconnaît la chaîne de
caractère "{"
(0, (=='{'),1) est la seule transition de cet automate. Son état de départ est l'état 0,
son état d'arrivée est l'état 1 et le caractère porté satisfait le prédicat (=='{')


La simplification adoptée dans la série 5 supposant que les tokens du texte à analyser
sont séparés par des espaces est abandonnée. Les tokens du texte à reconnaître ne sont
donc pas forcément séparés par des espaces. Exemple de texte : "int x; int y; x=y*2;"

Travail à faire
===============

1) Représentez chacun des tokens de ce langage

Exemple :
* `t1 = (Token (StateMachine 0 [1] [( 0, (=='{'), 1 )] ) "begin_block")`
Indications : vous pouvez utiliser des fonctions prédéfinies du module Date.Char telle
que la fonction isDigit x qui retourne vrai si le caractère x est un chiffre et faux sinon
-}
singleCharToken :: Char -> String -> Token
singleCharToken eqChar codeName =
    Token
    (StateMachine
        0 -- Initial state
        [1] -- Final state
        [ -- Transition
            (
                0, -- initial state
                (== eqChar), -- char predicate
                1 -- following state
            )
        ]
    )
    codeName -- Code

linearCharToken :: [Char] -> String -> Token
linearCharToken chars codeName =
    Token
    (StateMachine
        0 -- Initial state
        [length chars] -- Final state
        (transitions chars 0)
    )
    codeName -- Code
    where
        transition :: Char -> TransInitState -> Transition
        transition x i = (
                i, -- initial state
                (== x), -- char predicate
                i + 1 -- following state
            )
        transitions :: [Char] -> TransInitState -> [Transition]
        transitions [] _ = []
        transitions (x:xs) i = transition x i : transitions xs (i + 1)

{-
begin_block : '{'
-}
t1 :: Token
t1 = singleCharToken '{' "begin_block"

{-
end_block : '}'
-}
t2 :: Token
t2 = singleCharToken '}' "end_block"

{-
begin_par : '('
-}
t3 :: Token
t3 = singleCharToken '(' "begin_par"

{-
end_par : ')'
-}
t4 :: Token
t4 = singleCharToken ')' "end_par"

{-
semicolon : ';'
-}
t5 :: Token
t5 = singleCharToken ';' "semicolon"

{-
op_eg : "=="
-}
t6 :: Token
t6 = linearCharToken "==" "op_eg"
-- t6 =
--     Token
--     (StateMachine
--         0 -- Initial state
--         [2] -- Final state
--         [ -- Transition
--             (
--                 0, -- initial state
--                 (== '='), -- char predicate
--                 1 -- following state
--             ),
--             (
--                 1, -- initial state
--                 (== '='), -- char predicate
--                 2 -- following state
--             )
--         ]
--     )
--     "op_eg" -- Code

{-
op_affect : '='
-}
t7 :: Token
t7 = singleCharToken '=' "op_affect"

{-
op_add : '+'
-}
t8 :: Token
t8 = singleCharToken '+' "op_add"

{-
op_minus : '-'
-}
t9 :: Token
t9 = singleCharToken '-' "op_minus"

{-
op_mult : '*'
-}
t10 :: Token
t10 = singleCharToken '*' "op_mult"

{-
op_div : '/'
-}
t11 :: Token
t11 = singleCharToken '/' "op_div"

{-
type_int : "int"
-}
t12 :: Token
t12 = linearCharToken "int" "type_int"
-- t12 =
--     Token
--     (StateMachine
--         0 -- Initial state
--         [3] -- Final state
--         [ -- Transition
--             (
--                 0, -- initial state
--                 (== 'i'), -- char predicate
--                 1 -- following state
--             ),
--             (
--                 1, -- initial state
--                 (== 'n'), -- char predicate
--                 2 -- following state
--             ),
--             (
--                 2, -- initial state
--                 (== 't'), -- char predicate
--                 3 -- following state
--             )
--         ]
--     )
--     "type_int" -- Code

{-
cond : "if"
-}
t13 :: Token
t13 = linearCharToken "if" "cond"
-- t13 =
    -- Token
    -- (StateMachine
        -- 0 -- Initial state
        -- [2] -- Final state
        -- [ -- Transition
            -- (
                -- 0, -- initial state
                -- (== 'i'), -- char predicate
                -- 1 -- following state
            -- ),
            -- (
                -- 1, -- initial state
                -- (== 'f'), -- char predicate
                -- 2 -- following state
            -- )
        -- ]
    -- )
    -- "cond" -- Code

{-
loop : "while"
-}
t14 :: Token
t14 = linearCharToken "while" "loop"
-- t14 =
--     Token
--     (StateMachine
--         0 -- Initial state
--         [1] -- Final state
--         [ -- Transition
--             (
--                 0, -- initial state
--                 (== 'w'), -- char predicate
--                 1 -- following state
--             ),
--             (
--                 1, -- initial state
--                 (== 'h'), -- char predicate
--                 2 -- following state
--             ),
--             (
--                 2, -- initial state
--                 (== 'i'), -- char predicate
--                 3 -- following state
--             ),
--             (
--                 3, -- initial state
--                 (== 'l'), -- char predicate
--                 4 -- following state
--             ),
--             (
--                 4, -- initial state
--                 (== 'e'), -- char predicate
--                 5 -- following state
--             )
--         ]
--     )
--     "loop" -- Code

{-
value_int : [0..9]+
-}
t15 :: Token
t15 =
    Token
    (StateMachine
        0 -- Initial state
        [1] -- Final state
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
    )
    "value_int" -- Code

{-
ident : [a..zA..Z_][a..zA..Z0..9_]*
-}
t16 :: Token
t16 =
    Token
    (StateMachine
        0 -- Initial state
        [1] -- Final state
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
    )
    "ident" -- Code


{-
2) Implémentez les fonctions qui suivent :
------------------------------------------
-}
{-
# `recognizedFromState state text recognizedPart token` :
cette fonction cherche à extraire du texte `text` un token en utilisant l'automate à état
fini du token passé en paramètre. state est un état de l'automate de token, il représente
l'état duquel on part pour analyser le texte. recognizedPart est un accumulateur contenant
la partie du texte reconnue.

Cette fonction retourne un triplet (code,rec,rest) où code est le code du token reconnu,
rec est le dédut de text reconnu par le token et rest est la partie du texte qui suit la
partie reconnue. Elle retourne le triplet ("","",text) si le début de text n'est pas
reconnu par le token. Cette fonction est "gloutonne", elle reconnaît la plus grande partie
possible de texte.

Exemples:
* si t16 est la donnée de type Token permettant de reconnaître des identificateurs,
l'appel recognizedFromState 0 "toto=3;" "" t16 signifie que l'on cherche si le début
du texte "toto=3;" est reconnu par le token t16 (si t16 est le token "ident").
Cet appel retourne le triplet ("ident", "toto", "=3;") où "toto" est le plus grand
identificateur au début du texte "toto=3;", "ident" est le code du token t16 et "=3;"
est la partie du texte située après la partie reconnue (ici après "toto")

l'appel recognizedFromState 0 "{x=3;}" "" t16 signifie que l'on cherche si le
début du texte "{x=3;}" est reconnu par le token t16.
Cet appel retourne le triplet ("", "", "{x=3;}") car ce texte ne commence pas par un
identificateur.

Indications : Reprenez et adaptez au besoin les fonctions isFinalState et nextState de
l'exercice 2 de la série 5.
-}




{-
# `getNextRecognizedToken text tokens`
cette fonction recherche quel est le token qui reconnaît le début du texte text et
retourne en résultat le triplet (code,rec,rest) où code est le code du token reconnu,
rec est le début de text reconnu par le token et rest est la partie du texte qui suit la
partie du texte reconnu. Le paramètre tokens est la liste des tokens du langage.

Exemple :
* `getNextRecognizedToken "toto=3;" lt` où lt est la liste des tokens du langage
(lt=[t1,t2,...t16]) retourne le triplet ("ident", "toto", "=3;") car le texte commence
par un identificateur, cet identificateur est "toto" et "=3;" est la partie du texte qui
suit.
* `getNextRecognizedToken "{x=3;}" lt` retourne le triplet ("begin_block", "{", "x=3;}")
car le texte commence par le token {, et "x=3;}" est la partie du texte qui suit.

Attention :
* `getNextRecognizedToken "while (x==3)" lt` doit retourner le triplet
("begin_loop", "while", " (x==3)") et non le triplet ("ident", "while", "(x==3)").

Indication : l'ordre dans lequel les tokens sont testés par cette fonction est
significatif. Le token reconnu est celui qui reconnaît le plus long mot. Si deux tokens
reconnaissent le même mot le gagnant est le premier qui a été testé.
-}


{-
# `lexAnalyse text tokens`
cette fonction retourne la liste des codes des tokens composant le texte text.

Exemple :
* `lexAnalyse "toto=3;" lt` retourne la liste
["ident","op_affect","value_int","semicolon"]

Indication :
vous pouvez implémenter et utiliser la fonction trim ch qui retourne la chaîne de
caractères ch sans ses premiers caractères qui sont des espaces. La fonction isSpace c du
module Data.Char retourne True si c est un des caractères de séparation
(espace,tabulation,etc)
-}

