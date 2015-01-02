1. Each row should be equivalent to the previous etc...
  a)
  f x = 5 + 8/x
  f x = (+5) $ 8/x
  f   = (+5) . (8/)
  b)
  f x y = 3*y + x
  f     = flip ((+) . (3*)) -- How do I avoid using flip here...?

2. rewrite
  [ f x | x <- [ y + 4 | y <- ys, y<5 ] ]

  step 1:

    [ y + 4 | y <- ys, y<5 ]

  could be written as:

  map (+4) $ filter (<5) ys

  step 2:

    [ f x | x <- xs ]
  
  could be written as 

    map f xs

  so in total:

  map f $ map (+4) $ filter (<5) ys
  map (f . (+4)) $ filter (<5) ys

3.

> data Digits = Zero | One | Two | Three deriving Enum

(short)
Deriving enumerable typeclass will solve the problem of not being enumerable.

4. 

(draft)
Something about no side effects, write somethign about IO and how
it's handled using Monads for example...

5. 
  do "merry"; return "christmas"

  "merry" :: [Char]
  "christmas" :: [Char]

the above expression could be written as:
  "merry" >> return "christmas"

`return` will lift `a` into `m a`,
since "merry" is of [Char] `a` will be lifted
into `[a]` and the resulting type will be

  "merry" >> return "christmas" :: [[Char]]

.

6.

step 1: write out base-level types:

  (.) :: (b -> c) -> (a -> b) -> a -> c 
  (:) :: a -> [a] -> [a]

step 2: solve em all.
  
1: (.) (:) 
  with (:) partially applied to (.)

  b `becomes` a' and c becomes ([a] -> [a])

  (a -> a') -> a -> ([a'] -> [a'])

  and after simplification this becomes:

  (a -> a') -> a -> [a'] -> [a']

2: (:(.)) NEEDS PEER REVIEW:
   (:)´s right argument (.) is applied and should be a list, but it isn't a list..?
   Evaluating (:(.)) in the repl returns an error...

3: ((.):) 
  (:)´s `a` becomes ((b -> c) -> (a -> b) -> a -> c), and substitution gives 
  ((.):) ::  [(b -> c) -> (a -> b) -> a -> c] -> [(b -> c) -> (a -> b) -> a -> c]

4. ((:):)
  Pretty much the same as the one above...
  (:)´s `a` becomes (a -> [a] -> [a]), and substitution gives 
  ((:):) ::  [a -> [a] -> [a]] -> [a -> [a] -> [a]]



