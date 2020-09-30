module Test where

import S02

import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

main :: IO ()
main = hspec $ do
    describe "S02 Lists et récursivité - Exercice 1" $ do
        it "f1" $ do
            f1 [4,8,2,7,9,3] `shouldBe` [4,8,2]
        it "fibonacci" $ do
            fibonacci 0 `shouldBe` 0
            fibonacci 1 `shouldBe` 1
            fibonacci 19 `shouldBe` 4181
            fibonacci 20 `shouldBe` 6765

    describe "S02 Lists et récursivité - Exercice 2" $ do
        it "myLast" $ do
            myLast [4,8,2] `shouldBe` 2
        it "myDelete" $ do
            myDelete 5 [1,5,7,5,8] `shouldBe` [1,7,5,8]
        it "myMaximum" $ do
            myMaximum [1,5,7,5] `shouldBe` 7
        it "myLength" $ do
            myLength [1,5,7] `shouldBe` 3
        it "myDeleteAll" $ do
            myDeleteAll 5 [1,5,7,5,8] `shouldBe` [1,7,8]


    describe "S02 Lists et récursivité - Exercice 3" $ do
        it "scalarProduct" $ do
            scalarProduct [1,5,7] [2,3,1,7,4] `shouldBe` 24
        it "toUpperString" $ do
            toUpperString "hello" `shouldBe` "HELLO"


    describe "S02 Lists et récursivité - Exercice 4" $ do
        it "countVowel" $ do
            countVowel "hello" `shouldBe` 2
        it "analyseStrings" $ do
            analyseStrings ["hello","him","char"] `shouldBe` [("hello",5),("him",3),("char",4)]
        it "analyseStrings2" $ do
            analyseStrings2 ["hello","him","char"] `shouldBe` [("hello",5,2),("him",3,1),("char",4,1)]