-- functions can be partially applied
-- max 4 5 == (max 4) 5
-- (max 4) turns into a single function that takes in another number, then compares it to 4 and returns whichever is greater

-- currying
-- the following 2 functions do the same thing
compareWithHundred :: (Num a, Ord a) => a -> Ordering
compareWithHundred x = compare 100 x

compareWithHundred' :: (Num a, Ord a) => a -> Ordering
compareWithHundred' = compare 100
-- think of `compareWithHundred'` as just expanding into `compare 100` when called

-- the same can be done with infix functions
divideByTen :: (Floating a) => a -> a
divideByTen = (/10)
-- again, think of `divideByTen` as just expanding into `/ 10` when called, but it is placed before the other value

-- partial functions will fill in whatever they are missing, so it doesn't matter if its the first, second, third, or whatever that is missing


-- functions can receive functions as arguments and return functions
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)
-- here, the parentheses around the first `a -> a` represent what the function we are passing into `applyTwice` takes in and returns

-- zipWith implementation:
-- the function we pass into `zipWith'` take in things with types `a` and `b` and returns something with type `c`
-- then, we pass two lists of type `a` and `b` respectively into `zipWith'`
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = (f x y) : (zipWith' f xs ys)

-- flip implementation:
-- remember that parenthases are used to denote another function when defining a function
flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = g
    where g x y = f y x
-- this is the same thing, but takes advantage of currying
flip'' :: (a -> b -> c) -> b -> a -> c
flip'' f y x = f x y

-- map implementation:
map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

-- filter implementation:
filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' f (x:xs)
    | f x == True = x : filter' f xs
    | otherwise   = filter' f xs

-- a predicate (in terms of higher order functions) is a function that tells whether something is true or not

-- quick sort with filter:
quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) =
    let
        lessThanX = quickSort (filter (<= x) xs)
        greaterThanX = quickSort (filter (> x) xs)
    in
        lessThanX ++ [x] ++ greaterThanX

-- find largest num under 100,000 that's divisble by 3829
hundredKDivNum :: Int
hundredKDivNum = head (filter f [100000,99999..])
    where f x = x `mod` 3829 == 0
-- here, `f` is the predicate that returns either true or false
-- this is a common functional programming pattern

-- takeWhile implementation:
takeWhile' :: (a -> Bool) -> [a] -> [a]
takeWhile' _ [] = []
takeWhile' f (x:xs)
    | f x == True = x : takeWhile f xs
    | otherwise   = []

-- oddSquareSum implementation:
oddSquareSum :: Int
oddSquareSum = sum (takeWhile (< 10000) (filter odd (map (^2) [1..])))
-- using list comprehensions:
oddSquareSum' :: Int
oddSquareSum' = sum (takeWhile (< 10000) [ i | x <- [1..], let i = x ^ 2, i `mod` 2 == 1 ])

-- Collatz sequences implementations:
collatzSequence :: Int -> [Int]
collatzSequence 1 = [1]
collatzSequence x
    | odd x = x : collatzSequence ((x * 3) + 1)
    | even x = x : collatzSequence (x `div` 2)

collatzLenGTFifteen :: Int
collatzLenGTFifteen = length (filter gtFifteen (map collatzSequence [1..100]))
    where gtFifteen xs = length xs > 15

-- lambdas are anonymous functions that are defined inside an expression
numLongChains :: Int
numLongChains = length (filter (\xs -> length xs > 15) (map collatzSequence [1 .. 100]))
-- this is the same thing we wrote above, but using lambdas and partial functions
-- normally, this is when more than 2 functions are applied to an input, or when there is more than 1 input
-- you can pattern match with lambdas, but you cannot do more than one pattern

-- lambdas are surrounded by parentheses unless they extend all the way to the right
-- flip using lambdas:
lambdaFlip :: (a -> b -> c) -> b -> a -> c
lambdaFlip f = \x y -> f y x
-- works because of lambdas and currying

-- fold encapsulate the pattern of defining a function that has an edge case of an empty list then using the `(x:xs)` pattern
-- `foldl` folds the list from the left side
sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs
-- the lambda funtion is like the main body of the function (what should be done)
   -- when folding, the function must take in two values
      -- one value represents the "head" of a function
      -- one value represents the `sum'` function run on the tail
-- `0` represents the starting value
-- `xs` is the function we

-- here is a more concise version using currying:
currySum :: (Num a) => [a] -> a
currySum = foldl (+) 0
-- when currying, you can generally write `foo a = bar b a` as `foo = bar b`

-- elem implementation:
elem' :: (Eq a) => a -> [a] -> Bool
elem' x xs = foldl (\acc e -> if e == x then True else acc) False xs
-- the starting value is the same type as the return type of the function
-- `acc` is the starting value of the function with accumulated change at any point in time
-- `e` is the head of the list at any point in time
-- for `foldl`, the accumulator is always first parameter and the current value is the second one of the binary function

-- `foldr` works in a similar way to `foldl`, but the accumular eats the list from the right rather than the left, and the parameters of the binary function are swapped
-- `foldr` map implementation:
foldrMap :: (a -> b) -> [a] -> [b]
foldrMap f = foldr (\x acc -> f x : acc) []

-- `foldl1` and `foldr1` work like `foldl` and `foldr`, but you don't need to define a starting value
-- they assume that the first or last item in the list is the starting value
foldl1Sum :: (Num a) => [a] -> a
foldl1Sum = foldl1 (+)

-- `scanl` and `scanr` work like `foldl` and `foldr`, but all the intermediate accumular states are returned as a list
-- there is also `scanl1` and `scanr1`, which work like `foldl1` and `foldr1`
maxWithSteps :: (Ord a) => [a] -> [a]
maxWithSteps = scanl1 (\acc x -> if x > acc then x else acc)

-- sqrtSums:
sqrtSums :: Int
sqrtSums = length (takeWhile (<= 1000) (scanl1 (\acc x -> acc + x) (map sqrt [1..]))) + 1

-- function applications using `$` is like using space but with the lowest precedence
-- the following are equivialent:
spaceFuncApps = sum (map sqrt [1 .. 130])
dollarFuncApps = sum $ map sqrt [1 .. 130]
-- you can usually use `$` in place of parenthases

-- we can use `$` to run a value against various functions in a list using `map`
dollarFuncMap = map ($ 3) [(4+), (10*), (^2), sqrt]

-- function composition means doing something like `f(g(x))` in math
(.) :: (b -> c) -> (a -> b) -> a -> c
f . g = \x -> f (g x)
-- `f` must take in what `g` returns
-- function composition can be used in place of lambdas to be clearer and more concise
absNegative :: (Num a) => [a] -> a
absNegative = map (negate . abs)
-- if we were to use lambdas:
absNegative' :: (Num a) => [a] -> a
absNegative' = map (\x -> negative (abs x))

-- we can compose more than 2 functions
absNegativeTail :: (Num a) => [[a]] -> [a]
absNegativeTail = map (negative . sum . tail)

-- can use to make a function support currying
pointLessEx x = ceiling (negate (tan (cos (max 50 x))))
pointLessEx' = ceiling . negate . tan . cos . max 50
-- usually, composing is more readable than the the alternatives


