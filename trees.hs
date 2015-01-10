import Control.Applicative
import Data.Foldable
import Data.Monoid
data Tree a = Leaf a | Node (Tree a) (Tree a) deriving Eq

instance Monad Tree where 
  return 	   = Leaf
  (Leaf t)   >>= f = f t
  (Node l r) >>= f = Node (l >>= f) (r >>= f)


instance Foldable (Tree) where
  foldMap f (Leaf a) = f a
  foldMap f (Node l r) = foldMap f l `mappend` foldMap f r

instance Functor Tree where
  fmap f (Leaf t)   = Leaf (f t)
  fmap f (Node l r) = Node (fmap f l) (fmap f r)

instance Applicative Tree where
  pure  = Leaf
  (Leaf f) <*> other = fmap f other
  (Node f g) <*> other = Node (f <*> other) (g <*> other)

instance Show a => Show (Tree a) where
  show (Leaf a)   = "(" ++ show a ++")"
  show (Node l r) = "(" ++ show l ++", " ++ show r ++ ")"

testnode = Node (Leaf 3) (Leaf 5)
testnode2 = Node (Leaf 5) (Leaf 5)
testnode3 = Node (Leaf 6) (Leaf 5)
testleaf = Leaf (10)
testFLaw11 = fmap id testleaf == testleaf
testFLaw12 = fmap id testnode == testnode 

testFLaw2 x = fmap ((+5) . (+10)) x  == ((fmap (+5)) . (fmap (+10))) x
testFLaw21 =  testFLaw2 testleaf
testFLaw22 =  testFLaw2 testnode 

instance (Ord a) => Ord (Tree a) where
  x `compare` y = x `compare` y
  max (Leaf x) (Leaf y) = Leaf (max x y)
  max (Node x y) (Node x' y') = max (max x y) (max x' y')
  max (Node x y) z = max (max x y) (z)
  max z (Node x y) = max (max x y) (z)

{-
isBalanced :: Ord a => Tree a -> Bool
isBalanced (Leaf a) = True
--isBalanced (Node (Leaf a) (Leaf b)) = a <= b
--isBalanced (Node a b) = max a <= max b
-}
