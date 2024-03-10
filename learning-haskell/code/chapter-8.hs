data Bool' = False' | True' -- like an enum

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
-- when we define that the constructors are instances of the `Show` typeclass, the types of all of the fields (like `Float`) have to be part of the typeclass

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
data Vector a = Vector a a a deriving (Show, Eq) -- notice that we defined this class as part of two typeclasses, separated by a `,`
-- so you can do:
vplus :: (Num t) => Vector t -> Vector t -> Vector t
(Vector i j k) `vplus` (Vector l m n) = Vector (i + l) (j + m) (k + n)
-- I forgot you could define infix functions like this! Cool!

-- when making types instances for `Ord`, the constructors defined first are considered smaller
-- data BoolFFirst = False | True deriving (Ord) -- `False` < `True`
-- data BoolTFirst = True | False deriving (Ord) -- `True` < `False`

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
           deriving (Eq, Ord, Show, Read, Bounded, Enum)

-- `String` is a type synonym to `[Char]`
type String' = [Char]
-- `type` is for making type synonyms, whereas `data` makes new types

phoneBook :: [(String, String)]
phoneBook =
    [("alice", "123"),
    ("bob", "456"),
    ("charlie", "789")]
-- we can use type synonyms to convey more information than what the above provides
type Name = String
type PhoneNumber = String
type PhoneBook = [(Name, PhoneNumber)]
-- now we can do:
phoneBook' :: PhoneBook
phoneBook' =
    [("alice", "123"),
    ("bob", "456"),
    ("charlie", "789")]
-- which makes it easier to read:
inPhoneBook :: Name -> PhoneNumber -> PhoneBook -> Bool
inPhoneBook name phoneNumber phoneBook = (name, phoneNumber) `elem` phoneBook
-- which, if we weren't using synonyms, would look like:
-- inPhoneBook :: String -> String -> [(String, String)] -> Bool
-- which is pretty hard to decipher if just looking at the function signature

-- we can also use type synonyms but with values of unknown type
type Vector2dSym n = [(n, n)]

-- we can also use partial type parameters to get new constructors
-- type IntMap = Map Int
-- whatever other type is passed into `IntMap` will turn this value in to `Map Int <T>`

-- `Either` is a type that takes in two other types as parameters
data Either' a b = Left' a | Right' b deriving (Eq, Ord, Read, Show)
-- `Either` is super useful to do pattern matching on to get error messages
errHandlingEither :: Either String String -> String
errHandlingEither (Left err) = "left - err: " ++ err
errHandlingEither (Right val) = "right - val: " ++ val

-- we can create recursive data types
data List' a = Empty' | Cons a (List' a) deriving (Show, Read, Eq, Ord)
-- remember that `Cons` is like `:` when sticking a value to a list
-- `Cons a (List a)` reads as attach something of type `a` to a `List` of type `a`
-- we can define functions to be automatically infix by making them only out of special characters
infixr 5 :-: -- the `5` represents the order in which this operator should be performed, and the `:-:` is the operation
data List'' a = Empty'' | a :-: (List'' a) deriving (Show, Read, Eq, Ord)
-- we can define functions for our new data type
infixr 5 .++
(.++) :: List'' a -> List'' a -> List'' a
Empty'' .++ ys = ys
(x :-: xs) .++ ys = x :-: (xs .++ ys)
-- notice how we pattern matched `(x :-: xs)`, which works because patern matching matches constructors

-- binary search tree implementation:
data Tree a = EmptyTree | Leaf a (Tree a) (Tree a) deriving (Show, Read, Eq)

singletonTree :: (Ord a) => a -> Tree a
singletonTree value = Leaf value EmptyTree EmptyTree

insertToTree :: (Ord a) => Tree a -> a -> Tree a
insertToTree EmptyTree value = singletonTree value
insertToTree (Leaf curLeaf lessLeaf greaterLeaf) value
    | value == curLeaf = Leaf value lessLeaf greaterLeaf
    | value < curLeaf  = Leaf curLeaf (insertToTree lessLeaf value) greaterLeaf
    | value > curLeaf  = Leaf curLeaf lessLeaf (insertToTree greaterLeaf value)

checkElemTree :: (Ord a) => Tree a -> a -> Bool
checkElemTree EmptyTree _ = False
checkElemTree (Leaf curLeaf lessLeaf greaterLeaf) value
    | value == curLeaf = True
    | value < curLeaf  = checkElemTree lessLeaf value
    | value > curLeaf  = checkElemTree greaterLeaf value

-- typeclasses are defined with the `class` keyword
class Eq' a where
    (==.) :: a -> a -> Bool
    (/=.) :: a -> a -> Bool
    x ==. y = not (x /=. y)
    x /=. y = not (x ==. y)

-- we can define an instance of a class like so:
data TrafficLight = Red | Yellow | Green
instance Eq' TrafficLight where
    Red ==. Red = True
    Green ==. Green = True
    Yellow ==. Yellow = True
    _ ==. _ = False
-- kinda like pattern matching, the conditions are read from the top down
-- because `==` and `/=` were written in terms of each other in the class declaration, only one of them had to be overwritten in the instance declaration

-- here is another example with `Show`
class Show' a where
    show' :: a -> String

-- like how we define methods in OO languages like Python
instance Show' TrafficLight where
    show' Red = "Red light"
    show' Yellow = "Yellow light"
    show' Green = "Green light"

-- we could also do typeclass constraints for custom type classes like the following:
-- `class (Eq a) => Num a where`

-- we can also use `Maybe` as a passed in type
-- ```
-- instance (Eq m) => Eq (Maybe m) where
--     Just x == Just y = x == y
--     Nothing == Nothing = True
--     _ == _ = False
-- ```

-- we can make a typeclass for JS like true/false on values that aren't bools
class YesNo a where
    yesno :: a -> Bool
instance YesNo Int where
    yesno 0 = False
    yesno _ = True
instance YesNo [a] where
    yesno [] = False
    yesno _ = True
instance YesNo Bool where
    yesno = id -- id means we return whatever is passed into the function
instance YesNo (Maybe a) where
    yesno (Just _) = True
    yesno Nothing = False
instance YesNo (Tree a) where
    yesno EmptyTree = False
    yesno _ = True
instance YesNo TrafficLight where
    yesno Red = False
    yesno _ = True

-- `Functor` is the typeclass for things that can be mapped over
-- it provides `fmap`, which takes in a function and a type constructor and returns a type constructor
-- the list instance of `Functor` turns `fmap` into just `map`, so we can do:
fmapListExample :: [Int]
fmapListExample = fmap (* 2) [1 .. 3]
-- I think `fmap` lets us run functions on values that are in a `Maybe` or `Either`
fmapOnMaybe1 :: Maybe Int
fmapOnMaybe1 = fmap (* 2) (Just 3)
fmapOnMaybe2 :: Maybe Int
fmapOnMaybe2 = fmap (* 2) Nothing
-- the `Functor` typeclass applies to types that can act like a "box" (they store another type or something of another type)
-- basically applies to type constuctors

instance Functor Tree where
    fmap f EmptyTree = EmptyTree
    fmap f (Leaf x leftsub rightsub) = Leaf (f x) (fmap f leftsub) (fmap f rightsub)

-- a kind is the type of a type
-- a `*` means that a type is a concrete type
-- if we look at the kind of `Maybe`: `* -> *`, this means that `Maybe` is a type constructor that takes in a concrete type and turns it into another concrete type
-- this notation looks like the type declaration of a function
-- the `Functor` typeclass wants types of kind `* -> *`
