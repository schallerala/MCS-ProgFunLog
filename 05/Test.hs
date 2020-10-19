module Test where

import EX01
--import EX02

import Test.Hspec ( hspec, describe, it, shouldBe )
--import Test.QuickCheck
--import Control.Exception (evaluate)

main :: IO ()
main = hspec $ do
    describe "S05 Récursivité terminale - Exercice 1" $ do
        it "fibo" $ do
            fibo 7 `shouldBe` 13
            fibo'' 7 (\x -> x) `shouldBe` 13
        it "myProduct" $ do
            myProduct [1,2,3,4] `shouldBe` 24
            myProduct [4] `shouldBe` 4
            myProduct'' [1,2,3,4] (\x -> 1 * x) `shouldBe` 24
            myProduct''' [1,2,3,4] `shouldBe` 24
        it "myFlatten" $ do
            myFlatten [[2,3], [4,2,7], [6,9]] `shouldBe` [2,3,4,2,7,6,9]
            myFlatten'' [[2,3], [4,2,7], [6,9]] (\x -> x) `shouldBe` [2,3,4,2,7,6,9]
            myFlatten''' [[2,3], [4,2,7], [6,9]] `shouldBe` [2,3,4,2,7,6,9]
            myFlatten'''' [[2,3], [4,2,7], [6,9]] `shouldBe` [2,3,4,2,7,6,9]
        it "deleteAll" $ do
            deleteAll 5 [2,3,4,5,2,5,7,6,9] `shouldBe` [2,3,4,2,7,6,9]
            deleteAll'' 5 [2,3,4,5,2,5,7,6,9] (\x -> x) `shouldBe` [2,3,4,2,7,6,9]
            deleteAll''' 5 [2,3,4,5,2,5,7,6,9] `shouldBe` [2,3,4,2,7,6,9]
        it "myInsert" $ do
            myInsert 7 [2,5,8,9] `shouldBe` [2,5,7,8,9]
            myInsert'' 7 [2,5,8,9] (\x -> x) `shouldBe` [2,5,7,8,9]
