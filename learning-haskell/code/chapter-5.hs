-- elements that are not defined recursively in a function are called edge conditions
-- edge conditions are used to terminate a recursive function
-- recursion is often used becuase Haskell doesn't have `for` or `while` loops

maximum' :: (Ord a) => [a] -> a
maximum' [] = error "Empty list"
maximum' [x] = x
maximum' (x:xs)
    | x >= maximum' xs = x
    | otherwise = maximum' xs

-- I could have put the first `maximum' xs` guard in a `where` binding, but I forgor 💀
maximum'' :: (Ord a) => [a] -> a
maximum'' [] = error "Empty list"
maximum'' [x] = x
maximum'' (x:xs)
    | x >= maxTail = x
    | otherwise = maxTail
    where maxTail = maximum'' xs

-- pattern matching makes edge conditions easy (prettier, cuz no big `if-else` tree)!

-- could make even simpler by using the `max` function
maximumMax :: (Ord a) => [a] -> a
maximumMax [] = error "Empty list"
maximumMax [x] = x
maximumMax (x:xs) = max x (maximumMax xs)

-- replicate implementation:
replicate' :: Int -> a -> [a]
replicate' n a
    | n < 0 = error "negative repetitions"
    | n == 0 = []
    | otherwise = [a] ++ replicate' (n - 1) a -- should use `:` instead of `++` because its faster
-- use guards because checking for value rather than structure

-- take implementation:
take' :: Int -> [a] -> [a]
take _ [] = []
take' n (x:xs)
    | n < 0 = error "negative take"
    | n == 0 = []
    | otherwise = x : take' (n - 1) xs

-- the way the book does it feels less intuitive to me, although, I do think it would be faster
take'' :: (Num i, Ord i) => i -> [a] -> [a]
take'' n _
    | n <= 0 = []
take'' _ [] = []
take'' n (x:xs) = x : take'' (n - 1) xs -- felt like this line could have been included with the guard

-- reverse implementation:
reverse' :: [a] -> [a]
reverse' [] = []
reverse' (x:xs) = reverse' xs ++ [x]

-- repeat implementation:
repeat' :: a -> [a]
repeat' x = x:repeat' x -- this will never end

-- zip implementation:
zip' :: [a] -> [a] -> [(a, a)]
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = (x, y):(zip' xs ys)

-- elem implementation:
elem' :: (Eq a) => a -> [a] -> Bool
elem' _ [] = False
elem' x (y:ys)
    | x == y = True
    | otherwise = elem' x ys

-- quick sort implementation:
quickSort :: (Ord a) => [a] -> [a]
quickSort [] = []
quickSort (x:xs) =
    let
        smaller = quickSort [ i | i <- xs, i <= x ]
        larger = quickSort [ i | i <- xs, i > x ]
    in
        smaller ++ [x] ++ larger
