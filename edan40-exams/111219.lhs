1.
Start from bottom up, evaluate all expressions and explicitly state their type:

  (++)  :: [a] -> [a] -> [a]
  const :: a -> b -> a
  map   :: (a -> b) -> [a] -> [b]

Now we can write out the types when they are partially applied, 
by using simple substitutions like so:

For `const (++)` the a is replaced by ([a] -> [a] -> [a]) and the first argument is applied.

  const (++) :: b -> ([a] -> [a] -> [a])

For `map (++)` the (a -> b) is replaced by ([a] -> [a] -> [a]) and the first argument is applied.
This means that [a] becomes [[a]] and [b] becomes [[a] -> [a]]:

  map (++) :: [[a]] -> [[a] -> [a]]

Using the results from the above computations we can conclude that:

  const $ map (++) :: b -> [[a]] -> [[a] -> [a]]

and

  map $ const (++) :: b -> [[a] -> [a] -> [a]] 

2.

To curry a function means to convert a function which takes a pair to a function which takes
an argument which returns a function that takes an argument.
For example:

  curry (\(x,y) -> x + y) :: Num c => c -> c -> c

To uncurry a function means to take a function which takes a value, and gives a function which takes
another value and convert the first function to a function which takes a pair.

  uncurry (\x y -> x + y) :: Num c => (c, c) -> c


3.
  
  do [1,2,3,4,5]; "curry"

is equivalent to 

  [1,2,3,4,5] >> "curry"

The result is 

["currycurrycurrycurrycurry"] :: [Char]

.

  do [1,2,3,4,5]; return "uncurry"

is equivalent to:
  
  [1,2,3,4,5] >> return "uncurry"

The result is 

["uncurry","uncurry","uncurry","uncurry","uncurry"] :: [Char]

.

`return` lifts its argument into the monad, which is evaluated to be
the list monad (by the in-argument to (>>))

4.

(\\) finds the elements in the first list which don´t occur in the second list.

c a = (a \\) . (a \\)

finds the elements which occur in both lists.


5.

The first one (in steps where each step is equivalent to the one before):

  f x y = (5 + x) / y

  f x y = (/ y) (5 + x)

  f = (/) . (5 +)

The second one:

g x y = x y 

y is applied to x, which (sloppily) means that 

  x :: (a -> b)
  y :: a
  g :: (a -> b) -> a -> b

Which pretty much is the definition of function application ($),
which means a solution could be:

  g = ($)

6. (WIP)

>  data Tree = Leaf Int | Node Int Tree Tree deriving Show

subTree :: Tree -> Tree -> Bool
subTree (Leaf a) (Leaf b) == a == b
subTree (Node a l r) (
