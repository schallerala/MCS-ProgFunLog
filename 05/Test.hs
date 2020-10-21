module Test where

import EX01
import EX02


import Test.Hspec
import Control.Exception (evaluate)


tokens = [t1, t2, t3, t4, t5, t6, t7, t8, t9, t10, t11, t12, t13, t14, t15, t16]

main :: IO ()
main = hspec $ do
    describe "S05 Récursivité terminale - Exercice 1" $ do
        it "fibo" $ do
            fibo 7 `shouldBe` 13
            fibo 50 `shouldBe` 12586269025
            fibo' 7 `shouldBe` 13
        it "myProduct" $ do
            myProduct [1,2,3,4] `shouldBe` 24
            myProduct [4] `shouldBe` 4
            myProduct' [1,2,3,4] `shouldBe` 24
            myProduct'' [1,2,3,4] `shouldBe` 24
        it "myFlatten" $ do
            myFlatten [[2,3], [4,2,7], [6,9]] `shouldBe` [2,3,4,2,7,6,9]
            myFlatten' [[2,3], [4,2,7], [6,9]] `shouldBe` [2,3,4,2,7,6,9]
            myFlatten'' [[2,3], [4,2,7], [6,9]] `shouldBe` [2,3,4,2,7,6,9]
            myFlatten''' [[2,3], [4,2,7], [6,9]] `shouldBe` [2,3,4,2,7,6,9]
        it "deleteAll" $ do
            deleteAll 5 [] `shouldBe` []
            deleteAll 5 [2,3,4,5,2,5,7,6,9] `shouldBe` [2,3,4,2,7,6,9]
            deleteAll' 5 [2,3,4,5,2,5,7,6,9] `shouldBe` [2,3,4,2,7,6,9]
            deleteAll'' 5 [2,3,4,5,2,5,7,6,9] `shouldBe` [2,3,4,2,7,6,9]
        it "myInsert" $ do
            myInsert 7 [2,5,8,9] `shouldBe` [2,5,7,8,9]
            myInsert' 7 [2,5,8,9] `shouldBe` [2,5,7,8,9]
            myInsert' 7 [2,5,6,8,9] `shouldBe` [2,5,6,7,8,9]
            myInsert' 7 [2,5] `shouldBe` [2,5,7]
            myInsert' 7 [8,9] `shouldBe` [7,8,9]
            myInsert' 7 [2] `shouldBe` [2,7]
            myInsert' 7 [] `shouldBe` [7]

    describe "S05 Récursivité terminale - Exercice 2" $ do
        it "declaring tokens" $ do
            getToken "{" tokens `shouldBe` "begin_block"
            getToken "}" tokens `shouldBe` "end_block"
            getToken "(" tokens `shouldBe` "begin_par"
            getToken ")" tokens `shouldBe` "end_par"
            getToken ";" tokens `shouldBe` "semicolon"
            getToken "==" tokens `shouldBe` "op_eg"
            getToken "=" tokens `shouldBe` "op_affect"
            getToken "+" tokens `shouldBe` "op_add"
            getToken "-" tokens `shouldBe` "op_minus"
            getToken "*" tokens `shouldBe` "op_mult"
            getToken "/" tokens `shouldBe` "op_div"
            getToken "int" tokens `shouldBe` "type_int"
            getToken "if" tokens `shouldBe` "if"
            getToken "while" tokens `shouldBe` "loop"
            getToken "0" tokens `shouldBe` "value_int"
            getToken "1" tokens `shouldBe` "value_int"
            getToken "2" tokens `shouldBe` "value_int"
            getToken "3" tokens `shouldBe` "value_int"
            getToken "4" tokens `shouldBe` "value_int"
            getToken "5" tokens `shouldBe` "value_int"
            getToken "6" tokens `shouldBe` "value_int"
            getToken "7" tokens `shouldBe` "value_int"
            getToken "8" tokens `shouldBe` "value_int"
            getToken "9" tokens `shouldBe` "value_int"
            getToken "10" tokens `shouldBe` "value_int"
            getToken "11" tokens `shouldBe` "value_int"
            getToken "44" tokens `shouldBe` "value_int"
            getToken "999" tokens `shouldBe` "value_int"
            getToken "1200012" tokens `shouldBe` "value_int"
            getToken "a" tokens `shouldBe` "ident"
            getToken "b" tokens `shouldBe` "ident"
            getToken "c" tokens `shouldBe` "ident"
            getToken "z" tokens `shouldBe` "ident"
            getToken "A" tokens `shouldBe` "ident"
            getToken "Z" tokens `shouldBe` "ident"
            getToken "_" tokens `shouldBe` "ident"
            getToken "aA" tokens `shouldBe` "ident"
            getToken "Aa" tokens `shouldBe` "ident"
            getToken "AA" tokens `shouldBe` "ident"
            getToken "zzZZzz" tokens `shouldBe` "ident"
            getToken "z1212zZZzz" tokens `shouldBe` "ident"
            getToken "z_9_" tokens `shouldBe` "ident"
            getToken "z_9Z9" tokens `shouldBe` "ident"

        it "unkown tokens" $ do
            evaluate (getToken "-----" tokens) `shouldThrow` anyErrorCall
            evaluate (getToken "§" tokens) `shouldThrow` anyErrorCall
            evaluate (getToken "" tokens) `shouldThrow` anyErrorCall
            evaluate (getToken "**" tokens) `shouldThrow` anyErrorCall

        it "lexAnalyse" $ do
            lexAnalyse "int x ; int y ; x = y * 2 ;" tokens `shouldBe`
                ["type_int", "ident", "semicolon", "type_int", "ident", "semicolon", "ident", "op_affect", "ident", "op_mult", "value_int", "semicolon"]
            lexAnalyse "A_123azZ9_ 123490 while if int / * - + = ; == ; ( ) { } ;" tokens `shouldBe`
                ["ident", "value_int", "loop", "if", "type_int", "op_div", "op_mult", "op_minus", "op_add", "op_affect", "semicolon", "op_eg", "semicolon", "begin_par", "end_par", "begin_block", "end_block", "semicolon"]

        -- Don't know how to write those tests as the use of map will start returning a
        -- list of Code before getting an error for a `getToken` call
        -- it "errors with lex analyse" $ do
        --     evaluate (lexAnalyse "A_123azZ9_ 123490 while if int / ** - + = ; == ; ( ) { } ;" tokens) `shouldThrow` anyErrorCall
        --     lexAnalyse "A_123azZ9_ 123490 while if int / ** - + = ; == ; ( ) { } ;" tokens `shouldBe` []
