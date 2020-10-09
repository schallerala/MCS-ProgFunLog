module Test where

import EX01
import EX02

import Test.Hspec
import Test.QuickCheck
import Control.Exception (evaluate)

main :: IO ()
main = hspec $ do
    describe "S04 fonctions d'ordre supérieur - Exercice 1" $ do
        it "myInsert" $ do
            myInsert 7 [2,5,8,9] `shouldBe` [2,5,7,8,9]
            myInsert 11 [2,5,8,9] `shouldBe` [2,5,8,9,11]
        it "insertionSort" $ do
            insertionSort [7,13,4,2,7,34,1,9] `shouldBe` [1,2,4,7,7,9,13,34]
        it "myTakeWhile" $ do
            myTakeWhile (<34) [7,13,4,2,7,34,1,9] `shouldBe` (takeWhile (<34) [7,13,4,2,7,34,1,9])
        it "myZipWith" $ do
            myZipWith (+) [1,2,3] [4,6,8] `shouldBe` (zipWith (+) [1,2,3] [4,6,8])
        it "myIntersect" $ do
            myIntersect [1..10] [6..14] `shouldBe` [6,7,8,9,10]
            myIntersect' [1..10] [6..14] `shouldBe` [6,7,8,9,10]
            myIntersect'' [1..10] [6..14] `shouldBe` [6,7,8,9,10]
        it "divisorsList" $ do
            divisorsList 9 `shouldBe` [1,3]
            divisorsList' 9 `shouldBe` [1,3]
            divisorsList'' 9 `shouldBe` [1,3]
        it "perfectNumber" $ do
            perfectNumber 6 `shouldBe` True
            perfectNumber 5 `shouldBe` False
            perfectNumber 7 `shouldBe` False
        it "perfectNumbers" $ do
            -- perfectNumbers 2 `shouldBe` [6,28]
            perfectNumbers 4 `shouldBe` [6,28,496,8128]

    describe "S04 fonctions d'ordre supérieur - Exercice 2" $ do
         it "calculatePolynomial avec récursion" $ do
             calculatePolynomial1 [(2,1), (4,2), (-2,4)] 3 `shouldBe` -120
         it "calculatePolynomial avec liste de compréhension" $ do
             calculatePolynomial2 [(2,1), (4,2), (-2,4)] 3 `shouldBe` -120
         it "calculatePolynomial avec fonction d'ordre supérieur et fonction anonyme" $ do
             calculatePolynomial3 [(2,1), (4,2), (-2,4)] 3 `shouldBe` -120