module Test where

import EX01
import EX02
import EX03A
import EX03B

import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

main :: IO ()
main = hspec $ do
    describe "S03 Listes et analyse lexicale - Exercice 1" $ do
        it "myLength" $ do
            myLength [1,5,7] `shouldBe` 3
        it "myDeleteAll" $ do
            myDeleteAll 5 [1,5,7,5,8] `shouldBe` [1,7,8]
        it "toUpperString" $ do
            toUpperString "hello" `shouldBe` "HELLO"

    describe "S03 Listes et analyse lexicale - Exercice 2" $ do
        it "flatten" $ do
            flatten [[2,3],[4,2,7],[6,9]] `shouldBe` [2,3,4,2,7,6,9]
        it "quicksort" $ do
            quicksort [7,13,4,2,7,34,1,9] `shouldBe` [1,2,4,7,7,9,13,34]
        it "partitions" $ do -- improve
            partitions [1,2,3] `shouldBe` [[],[3],[2],[2,3],[1],[1,3],[1,2],[1,2,3]]
        it "permutations" $ do -- improve
            permutations [1,2,3] `shouldBe` [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]]

    describe "S03 Lists et analyse lexicale - Exercice 3 a)" $ do
        it "transitions" $ do
            transition 1 'b' `shouldBe` 2
            transition 4 'b' `shouldBe` -1
        it "isToken" $ do
            EX03A.isToken "aababba" `shouldBe` True
            EX03A.isToken "aaa" `shouldBe` False
        it "recognizedFromState" $ do
            EX03A.recognizedFromState 2 "bba" `shouldBe` True
            EX03A.recognizedFromState 1 "aba" `shouldBe` False

    describe "S03 Lists et analyse lexicale - Exercice 3 b)" $ do
        it "isToken" $ do
            EX03B.isToken "aababba" monAutomate `shouldBe` True
            EX03B.isToken "aaa" monAutomate `shouldBe` False
        it "recognizedFromState" $ do
            EX03B.recognizedFromState 2 "bba" monAutomate `shouldBe` True
            EX03B.recognizedFromState 1 "aba" monAutomate `shouldBe` False
        it "isFinalState" $ do
            EX03B.isFinalState 4 monAutomate `shouldBe` True
            EX03B.isFinalState 1 monAutomate `shouldBe` False
        it "nextState" $ do
            nextState 3 'b' monAutomate `shouldBe` 4
            nextState 3 'a' monAutomate `shouldBe` -1
