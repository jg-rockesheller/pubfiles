-- explicit type declarations
removeNonUppercase :: [Char] -> [Char] -- I think this means it takes in a list of chars and returns a list of chars
removeNonUppercase xs = [x | x <- xs, x `elem` ['A' .. 'Z']]

-- the type of the last item will alsways be the return type
addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z -- this only returns one Int

-- `Int` is bounded to a maximum size
-- `Integer` is not bounded and can be used with big numbers
-- `Float` vs `Double`
circumference :: Float -> Float
circumference r = 2 * pi * r

circumference' :: Double -> Double -- doubles contain double the precision as floats
circumference' r = 2 * pi * r

-- the other types are pretty self explanatory

-- type variables
head' :: [a] -> a -- `a` means that is can represent any variable type
head' xs = xs !! 0

-- kinda like generics
-- functions that have type variables are called polymorphic functions
-- do not start with uppercase letters

-- `:t (==)` -> `(==) :: Eq a => a -> a -> Bool`
-- the `==` operator returns a bool by taking in two variables of any type
-- however, `Eq a` is used because the two variables have to be of the same type
-- `Eq` is actually a typeclass, and the `=>` means that the function must be restrained to that class
-- the `Eq` typeclass provides an interface for testing equality between its memebers

-- the typeclases:
-- `Eq` used for types that support testing equality
-- `Ord` used for types that can be ordered
-- `Enum` means that types that are members of this class are sequentually ordered, such as `Ints` (1, 2, 3, 4,...)
-- think of things like `succ`

-- `Show` can be represented as a string (Int -> String)
showThree :: [Char]
showThree = show 3

-- `Read` opposite of `Show` (String -> Int)
readThree :: Int
readThree = read "3" -- `read` works in this case because we use the explicit type declaration above to say we want an `Int` out of the string
-- we could have the same effect by doing:

readFour = read "4" :: Int

-- type annotations can be used to fix confusions around `Int` and `Float`

-- `Bounded` members have an upper and lower bound
minInt = minBound :: Int -- while `Int` is bounded, `Integer` is not

maxInt = maxBound :: Int

-- tuples become members of `Bounded` if their components are a part of the class
maxTupleExample = maxBound :: (Bool, Int, Char)

-- `Num` memebers have the property that they can act like numbers
-- `Integral` is like `Num` but its memebers can only be whole numbers
-- `Floating` is like `Num` but its memebers can only be floating point numbers
intToNum = fromIntegral 5 -- this turns the `Int` 5 into a `Num` 5

workWithLength = fromIntegral (length [1, 2, 3, 4]) + 3.2 -- we do this because length returns an `Int`
