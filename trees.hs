import Control.Applicative
data Tree a = Leaf a | Node (Tree a) (Tree a) deriving Eq

instance Monad Tree where 
  return 	   = Leaf
  (Leaf t)   >>= f = f t
  (Node l r) >>= f = Node (l >>= f) (r >>= f)

instance Functor Tree where
  fmap f (Leaf t)   = Leaf (f t)
  fmap f (Node l r) = Node (fmap f l) (fmap f r)

instance Applicative Tree where
  pure  = Leaf
  (Leaf f) <*> other = fmap f other
  (Node f g) <*> other = Node (f <*> other) (g <*> other)

instance (Show a) => Show (Tree a) where
  show (Leaf a)   = "(" ++ show a ++")"
  show (Node l r) = "(" ++ show l ++", " ++ show r ++ ")"

testnode = Node (Leaf 10) (Leaf 5)
testleaf = Leaf (10)
testFLaw11 = fmap id testleaf == testleaf
testFLaw12 = fmap id testnode == testnode 

testFLaw2 x = fmap ((+5) . (+10)) x  == ((fmap (+5)) . (fmap (+10))) x
testFLaw21 =  testFLaw2 testleaf
testFLaw22 =  testFLaw2 testnode 
