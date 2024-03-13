-- pattern matching (yay)

-- this will check if whatever is passed into `lucky` is the number `7`
lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"

-- I think this is like a `switch` or `if` statement
-- it goes from top to bottom

-- recursion preview
factorial :: (Integral a) => a -> a
factorial 0 = 1
factorial x = x * factorial (x - 1)

-- pattern matching can fail if a default value is not defined
charName :: Char -> String
charName 'a' = "Alice"
charName 'b' = "Bob"
charName 'c' = "Charlie"

-- if we call `charName` on anything other than `a`, `b`, or `c`, an error will occur, this is when we have a `non-exhaustive` pattern

-- pattern matching works on tuples
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)
addVectors (x1, y1) (x2, y2) = (x1 + x2, y1 + y2) -- already an exhaustive pattern because of the function declaration (it defines that `addVectors` will take in two tuples that are pairs)

addVectors' a b = (fst a + fst b, snd a + snd b) -- we would do something like this if we didn't use pattern matching

-- we can use _ like in list comprehension when doing pattern matching
tripleFirst :: (a, b, c) -> a
tripleFirst (x, _, _) = x

tripleSecond :: (a, b, c) -> b
tripleSecond (_, y, _) = y

tripleThird :: (a, b, c) -> c
tripleThird (_, _, z) = z

-- you can use pattern matching in list comprehensions, as well as using lists to pattern match against
sumPairList :: (Num a) => [(a, a)] -> [a]
sumPairList [] = error "Can't sum a list of pairs if the list is empty!"
sumPairList [(x, y)] = [a + b | (a, b) <- [(x, y)]] -- if a pattern match failed, it will move onto the next element

-- you can also use `:` to separate lists when pattren maching
-- remember: `[1,2,3]` -> `1:2:3:[]`
head' :: [a] -> a
head' [] = error "You can't find the head of nothing"
head' (x : _) = x -- here we are specifiying we only want the first element of the list, the _ means we don't care what the rest of the list is

-- notice the `error` function used above

-- here is some pattern matching + type classes at play
tell :: (Show a) => [a] -> [Char]
tell [] = "The list is empty"
tell (x : []) = "The list has one element: " ++ show x -- remember the `show function`?
tell (x : y : []) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x : y : _) = "It would be too tedious to go further. There are two elements in the list: " ++ show x ++ " and " ++ show y

-- the `x:y:[]` is put before the `x:y:_` pattern, I'm guessing because `[]` specifically means that the list ends there, whereas `_` means the list can either end there or keep on going
-- `x:[]` can be rewritten as `[x]`, and `x:y:[]` can be rewritten as `[x,y]` because they are fixed length, where as `x:y:_` has to be written like that becuase it could be longer than 2 variables

-- here is length using pattern matching:
length' :: (Num b) => [a] -> b
length' [] = 0 -- this is known as the edge case because it cannot be represented by the expression below (I'm thinking like special cases in piecewise functions to avoid an undefined value)
length' (_ : xs) = 1 + length' xs

-- here is sum using pattern matching:
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x : xs) = x + sum' xs

-- patterns are used to break something up yet still have a reference to the whole thing
firstLetter :: String -> String
firstLetter "" = "Empty string, can't find first letter."
firstLetter all@(x : _) = "The first letter of " ++ all ++ " is '" ++ [x] ++ "'"

-- in this example, `all` is a refrence to the entire string passed into the funciton, where as `x` is the first elemenent in the string (the first letter of it)

-- `++` cannot be used in pattern matches

-- guards are used to test if a property or value(s) is/are true or false
gradeTell :: (RealFloat a) => a -> Char
gradeTell grade
  | grade < 60.0 = 'F'
  | grade < 70.0 = 'D'
  | grade < 80.0 = 'C'
  | grade < 90.0 = 'B'
  | grade < 100.0 = 'A'
  | otherwise = error "Invalid Grade" -- anything not before this

-- now this really is like a switch statement, because you are only comparing against the value of something, unlike with a pattern match
-- from my understanding, it's:
-- pattern matching : check against structure
-- guards           : check against values

-- guards can be used when a function receives multiple parameters
operateNum :: (Integral a) => a -> Char -> a
operateNum num operation
  | num == 0 && operation == '/' = error "Cannot divide by 0"
  | num == 0 = 0
  | operation == '/' = 1
  | operation == '-' = 0
  | operation == '+' = num + num
  | operation == '*' = num * num

-- guards can be written online, but these are pretty unreadable
max' :: (Ord a) => a -> a -> a
max' a b | a > b = a | otherwise = b

-- this should just be written as
max'' :: (Ord a) => a -> a -> a
max'' a b
  | a > b = a
  | otherwise = b

-- comparison using guards:
compareValues :: (Show a, Ord a) => a -> a -> String
compareValues x y
  | x > y = show x ++ " is greater than " ++ show y
  | x < y = show x ++ " is less than " ++ show y
  | otherwise = show x ++ " is equal to " ++ show y

-- where:
-- here is an exmaple of a BMI calculator
bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
  | weight / height ^ 2 <= 18.5 = "Underweight"
  | weight / height ^ 2 <= 25.0 = "Standard"
  | weight / height ^ 2 <= 30.0 = "Overweight"
  | otherwise = "Black Hole"

-- the `weight / height ^ 2` is repeated multiple times, so we can simplify this using `where`
bmiTell' :: (RealFloat a) => a -> a -> String
bmiTell' weight height
  | bmi <= under = "Underweight"
  | bmi <= standard = "Standard"
  | bmi <= over = "Overweight"
  | otherwise = "Black Hole"
  where
    bmi = weight / height ^ 2
    (under, standard, over) = (18.5, 25.0, 30.0) -- we are using pattern matching withing the guard here!

-- initials example
initials :: String -> String -> String
initials firstName lastName
  | firstName == "" || lastName == "" = error "Cannot create initial from empty string."
  | otherwise = [first] ++ ". " ++ [last] ++ "."
  where
    (first : _) = firstName
    (last : _) = lastName

-- you can also define functions in where blocks
calcBmis :: (RealFloat a) => [(a, a)] -> [a]
calcBmis xs = [bmi w h | (w, h) <- xs]
  where
    bmi weight height = weight / height ^ 2

-- `let` binds to variables anywhere and are expressions themselves
cylinderSA :: (RealFloat a) => a -> a -> a
cylinderSA radius height =
  let sideArea = 2 * pi * radius * height
      topArea = pi * radius ^ 2
   in sideArea + 2 * topArea

-- anything defined in `let` will can be used in `in`
-- things defiend in `let` are actually expressions, whereas in `where`, they are simple assigning a name to a value
-- for example, you can do:
letsAreExpressions = 4 * (let a = 9 in a + 1) + 2

-- where you can't using `where`

-- `let` lets you define functions in a local scope
squareInline = let square x = x * x in (square 5, square 3, square 2)

-- use semicolons as delimiters when writing inline `lets` expressions
inlineIns = let a = 100; b = 200; c = 300 in a + b + c -- you don't need to have the semicolon after the last `let` variable

-- of course, you can do pattern matching in `lets`
matchIns = let (a, b, c) = (1, 2, 3) in a * b * c

-- you can also put `let`s in list comprehensions
calcBmis' :: (RealFloat a) => [(a, a)] -> [a]
calcBmis' xs = [bmi | (w, h) <- xs, let bmi = w / h ^ 2]

-- like predicates, but it doesn't filter, simply binds to names, or the things used before the `|` (like how `where` is used when used in function definitions)

-- you can use `let` without `in` in GHCi to bind to names for the entire session

-- wait theres an actual `case` expression?
-- pattern matching and guards basically do that
-- pattern matching in function definitions are just syntactic sugar for `case` expressions

headMatch :: [a] -> a
headMatch [] = error "Empty list."
headMatch (x : _) = x

-- can be written as:

headCase :: [a] -> a
headCase xs = case xs of
  [] -> error "Empty list."
  (x : _) -> x

-- in this case: `xs` is matched against `[]` and `(x:_)`, like in C

-- case expressions are expressions (yay!)
describeList :: [a] -> String
describeList xs =
  "The list is " ++ case xs of
    [] -> "empty"
    [x] -> "a singleton"
    xs -> "longer than a singleton"

-- pattern matching is syntactic sugar for `case` expressions, so we can do the following using `where` (remember, `where` can use pattern matching)
describeList' :: [a] -> String
describeList' xs = "The list is " ++ what xs
  where
    what [] = "empty"
    what [x] = "a singleton"
    what xs = "longer than a singleton"
