import Control.Applicative (Alternative(some))
-- `fmap` takes in a function, and a value that is an instance of the `Functor` typeclass, and changes the value within the `Functor` (like applying a function to the inside of a `Maybe`)
-- instances of the `Functor` typeclass have to have a kind of `* -> *`

-- `CMaybe` implementation:
data CMaybe a = CNothing | CJust Int a deriving (Show)
instance Functor CMaybe where
    fmap f CNothing = CNothing
    fmap f (CJust counter a) = CJust (counter + 1) (f a)
-- the counter part of `CJust` is kinda like a side effect! it stores a value
-- fails the functor laws, because the counter part increments every time `fmap` is run on a `CMaybe`

-- `Applicatives` are beefed up `Functors`
-- when we use `fmap` on a function that takes in more than one value, we get
funcExample :: [Int -> Int]
funcExample = fmap (*) [1 .. 5]
-- this becomes expression evaluates to: `[(1 *), (2 *), (3 *)]`
-- so, we could use it like this:
funcExampleUsage :: [Int]
funcExampleUsage = fmap (\f -> f 3) funcExample
-- applicative functors are used so that you can take a function wrapped in another functor and apply it to a value in another functor

-- the `Control.Applicative` module is what implements the `Applicative` typeclass
-- `pure` wraps a value in a functor, like `return` for I/O actions but it applies to other functors
-- `<*>` takes an expression wrapped in a functor and applies it to another value wrapped in a functor (as long as the functors are the same)
-- if we have a function `f`, then the expression `pure f <*> x` is is the same as `fmap f x` where `x` is a value wrapped in a functor, such as `Just 5`
-- `<?>` takes in a function and a value wrapped in a functor and runs `fmap` using the values, so `(+ 3) <?> Just 5` is the same as `fmap (+ 3) Just 5` which evaluates to `Just 8`
-- there are two ways lists are applicative functors, normal lists, which apply each function to each functor individually like a list comprehension, and `ZipLists`, which applies functions to functors like how `zip` works
-- `liftA2` takes in `f a b` and basically does `f <$> a <*> b`

-- defining `ZipList` with `newtype` is like this:
newtype ZipList' a = ZipList' { getZipList :: [a] }
-- the difference with `newtype` and `data` is that `newtype` only lets you make one constuctor with only one field
-- this makes initializing `newtype`s faster than `data`s
-- it would be difficult to use `instance` when making tuple pairs an instance of `Functor`, so we can use `newtype` instead
newtype Pair b a = Pair { getPair :: (a, b) }
instance Functor (Pair c) where
    fmap f (Pair (x, y)) = Pair (f x, y)
-- because `newtype` only has on value constructor, Haskell doesn't evaluate the value in order to check which value constructor was used, unlike with `data`

-- `type` is for making synonyms to another type
type IntList = [Int] -- means we can call values of type `[Int]` as an `IntList`, like `String` and `[Char]`
-- `newtype` takes an existing type and wraps them in a new type, usually to make them easier to make them instances of a type class
-- `data` is used to basically make an enum type that can take in multiple values and represent them as a single, new value
