{-- 1 --}
--a
--Takes a list and returns a function which takes a list and returns a list of those elements in the second lists which 
--are members of the first list
--
f xs ys = [ x | x <- xs, elem ys x]

{-- 2 --}
-- functions only take one argument.
-- partial application, easier to abstract parts of code and neater
-- composition of functions.

{-- 3 --}
-- each line tells something important.
e k = do -- takes a paremeter k
 x <- k  -- k is some sort of value `wrapped` in a monad (k :: (Monad m) => m a), bind each value of this monad to x 
 Nothing -- We know that the type of the monad is Maybe.
 return False -- Lift the bool value into the Maybe monad and yield this as the result.

-- This gives us:
-- e :: Maybe a -> Maybe Bool

{-- 4 --}
--a) Just arithmetic. 
-- (8-) :: (Num a) => a -> a

--b) same as the last one, looks a bit funnier though
-- (+0).(0+) :: (Num a) => a -> a

--c)
--  For (.)(.) we first write out the types of the components.
--  (.) :: (b -> c) -> (a -> b) -> a -> c
--  If we apply (.) to (.) we substitute
--  b for (b' -> c') and, c becomes ((a' -> b') -> a' -> c')
--  which results in:
--  (.)(.) :: (a -> (b' -> c')) -> a -> ((a' -> b') -> a' -> c')
--  (for neatness, we can replace b' with b and c' with c since
--  there aren't any namespace collisions, we remove the parans aswell)
--  (.)(.) :: (a -> b -> c) -> a -> (a' -> b) -> a' -> c

--d)
-- (:) :: a -> [a] -> [a]
-- with the right parameter applied with an empty list this becomes
-- this becomes a regular "cons nil":
-- (:[]) :: a -> [a]

--e) ($)$($)
--  ($) :: (a -> b) -> a -> b
-- first consider ($) ($)
-- a: (a' -> b')
-- b: a' -> b'
-- which yields:
-- ($)($) :: ((a' -> b')) -> (a' -> b')
-- which can be cleant up to (remove parans and resolve namespace conflicts)
-- ($)($) :: (a -> b) -> a -> b
-- which is the exact same as ($)
-- so -- ($)$($) :: (a -> b) -> a -> b
--f) 
-- resolve the types first.
-- [] :: [a] -- but do note that this is the list monad
-- (>>=) :: (Monad m) => m a -> (a -> m b) -> m b
-- const x = (\_ -> x)
-- [(>=)] :: Ord a => [a -> a -> Bool]
-- ([]>>=)(\_->[(>=)]) :: Ord a => [a -> a -> Bool]

{-- 5 --}
-- WIP

{-- 6 --}
-- WIP
