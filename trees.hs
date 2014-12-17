data Tree a = Leaf a | Node (Tree a) (Tree a) 

instance Monad Tree where
  return 	   = Leaf
  (Leaf t)   >>= f = f t
  (Node l r) >>= f = Node (l >>= f) (r >>= f)

instance (Show a) => Show (Tree a) where
  show (Leaf a)   = "(" ++ show a ++")"
  show (Node l r) = "(" ++ show l ++", " ++ show r ++ ")"

