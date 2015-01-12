{-- 1 --}
-- applyPlusOne f x = (f x) + 1
-- applyPlusOne f x = (+1) $ (f x)
-- applyPlusOne = curry ((+1) . (uncurry ($)))
-- never mind! f can still appear!
applyPlusOne f = (+1) . f

{-- 2 --}
-- because it requires Enum
-- better below:
replicate' = flip ((flip take) . repeat)

{-- 3 --}
-- the types are:
-- fst :: (a, b) -> a
-- head :: [a] -> a
-- dropWhile :: (a -> Bool) -> [a]
-- iterate :: (a -> a) -> a -> [a]
-- ps :: (a -> [b]) -> a -> [b]
-- It has the type signature:
-- h :: (Eq a) => (a -> a) -> a -> a
h f = fst . head . dropWhile (uncurry (/=)) . ps (iterate f)
  where
    ps g x = zip (tail (g x)) (g x)
-- tldr: it returns the the closest fixed point in the function
-- f to the second argument (second argument to h, which is implicit)

{-- 4 --}
-- lookup :: a -> [(a, b)] -> b
-- foldl :: (b -> a -> b) -> b -> [a] -> b
lookup' key xs = foldl (f key) i xs
  where
    i = Nothing
    f key Nothing (nk, nv) = if (key == nk) then (Just nv) else Nothing
    f _ a _ = a 

{-- 5 --}
--flip (c f) = c (f.swap)
swap (a, b) = (b, a)

-- test
f (a, b) = a b

a = flip (curry f) 
b = curry (f.swap)

testWorkingProbably = a 1 (+1) == b 1 (+1)

{-- 6 --}
-- Implement Num for (Num a => (Maybe a))
-- like this: instance (Eq a, Num a) => Num (Maybe a) where
-- then implement ‘+’, ‘*’, ‘abs’, ‘signum’, ‘fromInteger’, (-)
-- An operator where either operand is Nothing always returns Nothing.
-- quick implementation here:
instance (Eq a, Num a) => Num (Maybe a) where
  (+) a b = a >>= \ax -> b >>= \bx -> return (ax + bx)
  (-) a b = a >>= \ax -> b >>= \bx -> return (ax - bx)
  (*) a b = a >>= \ax -> b >>= \bx -> return (ax * bx)
  abs = (flip (>>=)) (return . abs)
  signum = (flip (>>=)) (return . signum)
  fromInteger a = fromInteger a



