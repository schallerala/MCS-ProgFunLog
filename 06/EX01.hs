module EX01 where

data BinaryTree a = EmptyTree | Node a (BinaryTree a) (BinaryTree a) deriving (Show, Eq, Ord)

{-
insertInTree v tree : cette fonction ajoute la valeur v dans l'arbre tree et retourne l'arbre
obtenu.

Exemple : 
* `insertInTree 4 (Node 3 EmptyTree EmptyTree)` retourne l'arbre `(Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))`

-}
insertInTree :: Ord a => a -> BinaryTree a -> BinaryTree a
insertInTree v EmptyTree = (Node v (EmptyTree) (EmptyTree))
insertInTree v (Node a left right)
    | v == a = Node v left right
    | v < a = Node a (insertInTree v left) EmptyTree
    | otherwise = Node a EmptyTree (insertInTree v right)


{-
searchInTree v tree : cette fonction retourne True s'il existe un nœud de valeur v dans l'arbre
tree. Elle retourne faux sinon.

Exemple : 
* `searchInTree 4 (Node 3 EmptyTree (Node 4 EmptyTree EmptyTree))` retourne `True`

-}
searchInTree :: Ord t => t -> BinaryTree t -> Bool
searchInTree _ EmptyTree = False
searchInTree v (Node a left right)
    | v == a = True
    | v < a = searchInTree v left
    | otherwise = searchInTree v right 



{-
sortTree tree : cette fonction retourne la liste triée par ordre croissant des valeurs présentes
dans l'arbre tree

Exemple : 
* `sortTree (Node 3 (Node 2 EmptyTree EmptyTree) EmptyTree)` retourne la liste `[2,3]`

-}

sortTree :: Num a => BinaryTree a -> [a]
sortTree EmptyTree = []
sortTree (Node a left right) = sortTree left ++ [a] ++ sortTree right
    
instance Foldable BinaryTree where
    foldr _ acc EmptyTree = acc
    foldr f acc (Node a left right) = foldr f (f a (foldr f acc right)) left

instance Functor BinaryTree where
    fmap _ EmptyTree = EmptyTree
    fmap f (Node a left right) = Node (f a) (fmap f left) (fmap f right)
