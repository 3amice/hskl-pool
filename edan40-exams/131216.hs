{- 1 -}
scanl' _ x []     = [x]
scanl' f x (y:ys) = x : scanl' f (f y x) ys

scanlfold f x xs = foldl f2 [x] xs
  where f2 xs x  = xs ++ (f (last xs) x):[]

scanr' _ x []     = [x]
scanr' f x xs     = scanr' f (f (last xs) x) (init xs) ++ [x]

scanrfold f x xs = foldr f2 [x] xs
  where f2 x ys = f x (head ys) : ys

rev :: [a] -> [a]
rev = foldl (flip (:)) []

{- 2 -}
 

-- impose restrictions/constraints on which `superclasses` a class should 
-- implement.

-- example
class (Show a, Num a) => SuperNum a where
  doSomeThing :: a -> a -> a

instance SuperNum Int where
  doSomeThing x y = x 


{- 3 -}
{-
 - twoC `plusC` twoC = 
 - (f.f)  `plusC` (f.f) =
 - (f.f).(f.f)          =
 - f.f.f.f =
 - succC f.f.f =
 - succC (succC (f.f)) =
 - succC (threeC) =
 - fourC
-}

{- 4 -} 

--a)
f :: (Monad m, Num a) => m a -> m a -> m a
f x y = do 
  a <- x
  b <- y
  return (a*b)

--b)
-- [2,4,8,4,8,16,6,12,24]

--c) Nothing

--d) yes (check type signature of fmap)

--e) return 5 :: (Monad m, Num a) => m a

{- 5 -}

-- remember this:
-- seq: suggests evaluation of its first arg (up to WHNF), returns the second
-- pseq: forces evaluation of the first arg first, then returns the second
-- par: like seq, but evaluation of the first arg may be done in parallel with returning the second
-- force: evaluates the spine of a list (up to WHNF)
-- WHNF : Weak head normal form
--
-- First one will only evaluate the first element of grtr (Due to WHNF),
-- no pararellisation - except for the first element of grtr.
--
-- Second is almost same as first but now
-- we make sure that the first element of grtr and first element of
-- lesser are computed (WHNF) before trying to concatenate (which is when
-- the rest will be caluclated non-pararellisated.
--
-- Best attempt:
-- this will force both lists to be computed in pararell before
-- concatenating by using the ´force´ function.

{- 6 -}

type Dur = Int 
data Class = A | B | C | D | E | F deriving Show
type Octave = Int 
type Pitch = (Class, Octave) 
newtype NoteAttribute = Volume Int deriving Show -- i'm lazy

data Music = Note Pitch Dur [NoteAttribute]
  | Rest Dur
  | Music :+: Music
  | Music :=: Music deriving Show

m1 = [Note (C, 5) 1 [] :+: Note (D, 5) 1 [], Note (E, 5) 1 []]
m2 = [Note (C, 5) 1 [], Note (D, 5) 1 [], Note (E, 5) 1 []]
--a)
--The first lists head is two music objects notes in sequence and
--two Musical Objects in total.
--In the second list has the same two notes separate from eachother
--in the list resulting in three notes in total.
--
--So, for example:
--If played in sequence, the music would sound the same.
--Though not in pararell.

lineToList :: Music -> [Music]
lineToList n@(Rest 0) = []
lineToList (n :+: ns) = n : lineToList ns
lineToList n          = [n]

line :: [Music] -> Music
line  = foldr (:+:) (Rest 0) :: [Music] -> Music

-- joke solution (ha-ha)
line' xs = xs >>= lineToList

-- real solution:
line2 :: [Music] -> Music
-- force the constructor 
line2 ((x :+: y):xs) = x :+: (y :+: (line xs))
line2 (x:xs)         = x :+: line2 xs
line2 _              = Rest 0


--b)
-- easy
-- 
lineToList2 :: Music -> [Music]
lineToList2 n@(Rest 0) = []
lineToList2 (n :+: ns) = lineToList2 n ++ lineToList2 ns
lineToList2 n          = [n]
