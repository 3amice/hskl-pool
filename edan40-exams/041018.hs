{-- 1 --}
test True True c = not c
test True b True = not b
test a True True = not a
{-- 2 --}
g f = f . (/3) . f
{-- 3 --}
-- e :: (Monad m, Num a) => m a -> m Bool
{-- 4 --}
-- col :: Behavior Color
{-- 5 --}
-- random typeclass
-- sequence computations
-- pipe results
{-- 6 --}
-- f' (f x y) = (x,y)
-- f _        = Nothing
