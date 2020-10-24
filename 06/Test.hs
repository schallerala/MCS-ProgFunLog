module Test where

import EX01
import EX02


import Test.Hspec


main :: IO ()
main = hspec $ do
    describe "S06 Types personnalisés" $ do
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