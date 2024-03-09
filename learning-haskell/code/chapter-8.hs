data Bool' = False | True -- like an enum

-- we can set a range using `...`
-- data Int' = (-2147483648) | -2147483647 | ... | -1 | 0 | 1 | 2 | ... | 2147483647 -- doesn't really work

-- we can define fields by passing in types before a `|`
data Shape = Circle Float Float Float | Rectangle Float Float Float Float
-- the fields are actually parameters, `Circle` and `Rectangle` can be thought of as functions that return type `Shape` and take in their fields as function arguments
-- these are called value constructors


-- if a "type" has paramteres, we can use them in functions as so:
area :: Shape -> Float
area (Circle _ _ r) = pi * r ^ 2
area (Rectangle x1 y1 x2 y2) = (abs $ x1 - x2) * (abs $ y1 - y2)
-- note that `Circle` and `Rectangle` aren't types, they are constructors, whereas `Shape` is the type
-- you can pattern match against constructors

-- we can use custom defined types in other custom defined types
data Point' = Point' Float Float deriving (Show)
data Shape' = Circle' Point' Float | Rectangle' Point' Point' deriving (Show)
-- the `deriving (Show)` means that this type is part of the `Show` typeclass

area' :: Shape' -> Float
area' (Circle' _ r) = pi * r ^ 2
area' (Rectangle' (Point' x1 y1) (Point' x2 y2)) = (abs $ x1 - x2) * (abs $ y1 - y2)

-- we can also return constructors of a type
nudge :: Shape' -> Float -> Float -> Shape'
nudge (Circle' (Point' x y) r) a b =  Circle' (Point' (x + a) (y + b)) r
nudge (Rectangle' (Point' x1 y1) (Point' x2 y2)) a b = Rectangle' (Point' (x1 + a) (y1 + b)) (Point' (x2 + a) (y2 + b))

-- some helper functions
baseCircle :: Float -> Shape'
baseCircle r = Circle' (Point' 0 0) r
baseRect :: Float -> Float -> Shape'
baseRect width height = Rectangle' (Point' 0 0) (Point' width height)

-- if we want to export types as a module:
-- module Shapes ( Point(..) ) where the `(..)` means we want to export all the value constructors for `Point`
-- if it were ommitted, then the user who imports our module would not be able to make their own `Point` values without us also defining helper functions

-- instead of just having a type with many parameters, we can structure it like this:
data Person = Person {
    firstName :: String,
    lastName :: String,
    age :: Int,
    height :: Float,
    phoneNumber :: String,
    flavor :: String
} deriving (Show)
-- kinda like a struct
-- this will display differently when just printing out a `Person`
-- i think this is just used for syntactic sugar and to make sure arguments are passed in proper order, especiall useful for debugging and code readability

-- like how value constructors can take values and return a type, type constructors take in types as parameters and produce new types
data Maybe' a = Nothing' | Just' a
-- `a`, the type parameter, is used here similar to how it is used in function definitions
-- `Just` is the type constructor, taking in a type `a` and becoming a `Just <Type>` value, and that `<Type>` can be used as that type

-- you can put typeclass constraints when doing data declarations, but it is **highly discouraged**
-- instead of doing this:
-- data (Ord a) => Vector a = Vector a a a deriving (Show)
-- you should do:
data Vector a = Vector a a a deriving (Show)
-- so you can do:
vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) = Vector (i + l) (j + m) (k + n)
-- I forgot you could define infix functions like this! Cool!
