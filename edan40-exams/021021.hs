{-- 1 --}
-- write out all types

--($) :: (a -> b) -> a -> b
--($x) :: (a -> b) -> b
--map ($x)  :: [ a -> b ] -> [b]
--

-- i guess one way of putting it is:

f x xs = [ f2 x | f2 <- xs ]

{-- 2 --}
{- 
 - zip takes two lists and makes them into one list of tuples
 - unzip takes one list containing tuples and returns a tuple of two lists
 - if you have two lists 
 - xs = [1,2,3]
 - ys = [4,5,6]
 - you can do
 - unzip $ (uncurry zip) . unzip $ (zip [1,2,3] [4,5,6])
 - or something. for fun. i guess.
 -}

{-- 3 --}
oneOf :: Bool -> Bool -> Bool -> Bool
oneOf a b c 
  | not (or [a,b]) = c
  | not (or [b,c]) = a
  | not (or [c,a]) = b
  | otherwise     = False

oneOf' True False False = True
oneOf' False True False = True
oneOf' False False True = True
oneOf' _ _ _    = False


{-- 4 --}
-- The monad in question is List
-- the resulting type is [Char]

{-- 5 --}
{- Num, etc is a class...-}

{-- 6 --}
-- Picks out which elements occur in both 
-- lists.
