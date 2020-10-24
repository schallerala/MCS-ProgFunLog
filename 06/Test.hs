module Test where

import EX01
import EX02

import Data.Char


import Test.Hspec


tokens = [t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16]

getReconCode :: RecognizedToken -> Code
getReconCode None = error "No recognized token"
getReconCode (Result (code, _, _)) = code

main :: IO ()
main = hspec $ do
    describe "S06 Types personnalisés - Exercice 1" $ do
        it "insertInTree" $ do
            insertInTree 4 (Node 3 EmptyTree EmptyTree) `shouldBe` (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
            insertInTree 4 (Node 3 EmptyTree EmptyTree) `shouldBe` (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))
            insertInTree 5 EmptyTree `shouldBe` (Node 5 EmptyTree EmptyTree)
        it "searchInTree" $ do
            searchInTree 4 EmptyTree `shouldBe` False
            searchInTree 4 (Node 3 EmptyTree EmptyTree) `shouldBe` False
            searchInTree 4 (Node 4 EmptyTree EmptyTree) `shouldBe` True
            searchInTree 4 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree)) `shouldBe` True
        it "sortTree" $ do
            sortTree EmptyTree `shouldBe` []
            sortTree (Node 3 (Node 2 EmptyTree EmptyTree) EmptyTree) `shouldBe` [2,3]
        it "tree with foldable" $ do
            fmap (*2) EmptyTree `shouldBe` EmptyTree
            fmap (*2) (Node 3 (Node 2 EmptyTree EmptyTree) EmptyTree) `shouldBe` (Node 6 (Node 4 EmptyTree EmptyTree) EmptyTree)
            foldr insertInTree EmptyTree [3,4] `shouldBe` Node 4 (Node 3 EmptyTree EmptyTree) EmptyTree
    
    describe "S06 Types personnalisés - Exercice 2" $ do
        it "declaring tokens" $ do
            getReconCode (recognizedFromState 0 "{"  "" t1) `shouldBe` "begin_block"
            getReconCode (recognizedFromState 0 "}"  "" t2) `shouldBe` "end_block"
            getReconCode (recognizedFromState 0 "("  "" t3) `shouldBe` "begin_par"
            getReconCode (recognizedFromState 0 ")"  "" t4) `shouldBe` "end_par"
            getReconCode (recognizedFromState 0 ";"  "" t5) `shouldBe` "semicolon"
            getReconCode (recognizedFromState 0 "=="  "" t6) `shouldBe` "op_eg"
            getReconCode (recognizedFromState 0 "="  "" t7) `shouldBe` "op_affect"
            getReconCode (recognizedFromState 0 "+"  "" t8) `shouldBe` "op_add"
            getReconCode (recognizedFromState 0 "-"  "" t9) `shouldBe` "op_minus"
            getReconCode (recognizedFromState 0 "*"  "" t10) `shouldBe` "op_mult"
            getReconCode (recognizedFromState 0 "/"  "" t11) `shouldBe` "op_div"
            getReconCode (recognizedFromState 0 "int" "" t12) `shouldBe` "type_int"
            getReconCode (recognizedFromState 0 "if" "" t13) `shouldBe` "cond"
            getReconCode (recognizedFromState 0 "while" "" t14) `shouldBe` "loop"
            getReconCode (recognizedFromState 0 "0" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "1" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "2" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "3" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "4" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "5" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "6" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "7" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "8" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "9" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "10" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "11" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "44" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "999" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "1200012" "" t15) `shouldBe` "value_int"
            getReconCode (recognizedFromState 0 "a" "" t16) `shouldBe` "ident"
            getReconCode (recognizedFromState 0 "b" "" t16) `shouldBe` "ident"
            getReconCode (recognizedFromState 0 "c" "" t16) `shouldBe` "ident"
            getReconCode (recognizedFromState 0 "z" "" t16) `shouldBe` "ident"
            getReconCode (recognizedFromState 0 "A" "" t16) `shouldBe` "ident"
            getReconCode (recognizedFromState 0 "Z" "" t16) `shouldBe` "ident"
            getReconCode (recognizedFromState 0 "_" "" t16) `shouldBe` "ident"
            getReconCode (recognizedFromState 0 "aA" "" t16) `shouldBe` "ident"
            getReconCode (recognizedFromState 0 "Aa" "" t16) `shouldBe` "ident"
            getReconCode (recognizedFromState 0 "AA" "" t16) `shouldBe` "ident"
            getReconCode (recognizedFromState 0 "zzZZzz" "" t16) `shouldBe` "ident"
            getReconCode (recognizedFromState 0 "z1212zZZzz" "" t16) `shouldBe` "ident"
            getReconCode (recognizedFromState 0 "z_9_" "" t16) `shouldBe` "ident"
            getReconCode (recognizedFromState 0 "z_9Z9" "" t16) `shouldBe` "ident"

        it "recognizedFromState examples" $ do
            recognizedFromState 0 "toto=3;" "" t16 `shouldBe` Result ("ident", "toto", "=3;")
            recognizedFromState 0 "{x=3;}" "" t16  `shouldBe` None

        it "getNextrecognizedToken examples" $ do
            getNextRecognizedToken "toto=3;" tokens `shouldBe` Result ("ident", "toto", "=3;")
            getNextRecognizedToken "{x=3;}" tokens  `shouldBe` Result ("begin_block", "{", "x=3;}")
            getNextRecognizedToken "while (x==3)" tokens  `shouldBe` Result ("loop", "while", " (x==3)")

        it "unkown tokens" $ do
            getNextRecognizedToken "§" tokens `shouldBe` None
            getNextRecognizedToken "" tokens `shouldBe` None
            getNextRecognizedToken ":" tokens `shouldBe` None

        it "matching token" $ do
            recognizedFromState 1 "" "otot" t16 `shouldBe` Result ("ident", "toto", "")
            recognizedFromState 1 "- dsffdsf" "otot" t16 `shouldBe` Result ("ident", "toto", "- dsffdsf")

        it "not matching token" $ do
            -- should never happen
            recognizedFromState 0 "" "toto" t1 `shouldBe` None
            recognizedFromState 0 " dsffdsf" "93287398" t15 `shouldBe` None

        it "not next token" $ do
            nextState 1 '3' (StateMachine 0 [1] []) `shouldBe` -1
            nextState 1 ' ' (StateMachine 0 [1] [(0, isDigit, 1)]) `shouldBe` -1

        it "check result order" $ do
            max (Result ("1", "while", "")) (Result ("2", "while", "")) `shouldBe` Result ("1", "while", "")

        it "get next token" $ do
            getNextRecognizedToken "while (x==3)" tokens `shouldBe` Result ("loop", "while", " (x==3)")

        it "lexAnalyse examples" $ do
            lexAnalyse "toto=3;" tokens `shouldBe` ["ident", "op_affect", "value_int", "semicolon"]

        it "lexAnalyse" $ do
            lexAnalyse "int x ; int y ; x = y * 2 ;" tokens `shouldBe`
                ["type_int", "ident", "semicolon", "type_int", "ident", "semicolon", "ident", "op_affect", "ident", "op_mult", "value_int", "semicolon"]
            lexAnalyse "int x;int y;x=y*2;" tokens `shouldBe`
                ["type_int", "ident", "semicolon", "type_int", "ident", "semicolon", "ident", "op_affect", "ident", "op_mult", "value_int", "semicolon"]
            lexAnalyse "A_123azZ9_ 123490 while if int / * - + = ; == ; ( ) { } ;" tokens `shouldBe`
                ["ident", "value_int", "loop", "cond", "type_int", "op_div", "op_mult", "op_minus", "op_add", "op_affect", "semicolon", "op_eg", "semicolon", "begin_par", "end_par", "begin_block", "end_block", "semicolon"]

        -- Still the same as previous series
        -- Don't know how to write those tests as the use of map will start returning a
        -- list of Code before getting an error for a `getToken` call
        -- it "errors with lex analyse" $ do
        --     evaluate (lexAnalyse "A_123azZ9_ 123490 while if int / * § - + = ; == ; ( ) { } ;" tokens) `shouldThrow` anyErrorCall
        --     evaluate (lexAnalyse "A_123azZ9_ 123490 _while if int / * - + = ; == ; ( ) { } ;" tokens) `shouldThrow` anyErrorCall
