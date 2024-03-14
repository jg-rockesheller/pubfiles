-- `fmap` takes in a function, and a value that is an instance of the `Functor` typeclass, and changes the value within the `Functor` (like applying a function to the inside of a `Maybe`)
-- instances of the `Functor` typeclass have to have a kind of `* -> *`

-- `CMaybe` implementation:
data CMaybe a = CNothing | CJust Int a deriving (Show)
instance Functor CMaybe where
    fmap f CNothing = CNothing
    fmap f (CJust counter a) = CJust (counter + 1) (f a)
-- the counter part of `CJust` is kinda like a side effect! it stores a value
-- fails the functor laws, because the counter part increments every time `fmap` is run on a `CMaybe`