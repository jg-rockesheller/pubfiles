-- Haskell modules are a collection of related functions, types, and typeclasses
-- like headers in C or libraries in Python

-- everything used in the previous chapters are from the `Prelude` module, which is imported by default

-- this will import modules directly, letting us use all of the exported functions in the global namespace
-- import Data.List
-- numUniques = length . nub
-- `nub` is a function defined in `Data.List`
-- in GHCi, the analogue would be to use `:m <module name>`

-- you can use parenthases to specify we only want to import certain functions from the module
-- like `from _ import _` in Python
-- import Data.List (nub, sort)
-- numUniques = length . nub

-- the opposite of the above is to use `hiding`
-- import Data.List hiding (nub)
-- numUniques = length . nub -- this wouldn't work because `nub` wasn't imported

-- to import modules into their own namespace, use `qualify`
-- import qualified Data.List
-- numUniques = length . Data.List.num

-- we can change their namesapce using `as`
-- import qualified Data.List as L
-- numUniques = length . L.num

-- common functions from `Data.List`
import Data.List as L

-- importing our custom module:
import Geometry
-- ./Geometry.hs must be in the same directory

-- importing our custom module that is a directory:
import GeometryDir.Rectangle as Rectangle
import GeometryDir.RightTri (hypotenuse)

monkeyWithDots = L.intersperse '.' "MONKEY" :: String
numsWithZeroes = L.intersperse 0 [1 .. 6] :: [Int]

-- `intercalate` flattens results
listToSpaces = L.intercalate " " ["hey", "there", "folks"] :: String
insertZeroes = L.intercalate [0,0] [[1,2],[3,4]] :: [Int]

-- `transpose` swaps columsn and rows if applied to a 2d list (matrix)
transpose2DList = L.transpose [[1,2,3],[4,5,6],[7,8,9]] :: [[Int]]

-- `foldl'`, `foldl1'`, `foldr'`, and `foldr1'` are stricter versions of their normal versions
-- when using the lazy versions on really big lists, you might get a stack overflow error
-- this happens because the accumulator value isn't actually updated, intead promising to accumulate change when needed\
-- the `'` folds foricbly update the accumulator, preventing the error

-- `concat` flattens stuff
concatFooBarCar = L.concat ["foo", "bar", "car"] :: String
concatNumList = L.concat [[3,4,5],[2,3,4],[2,1,1]] :: [Int]

-- `concatMap` runs map on a list, then flattens out the multi-dimensional list that is returned
concatMapRepl = L.concatMap (replicate 4) [1 .. 3] :: [Int]

-- `and` and `or` are boolean operators
andExample = L.and $ map (> 4) [5 .. 8] :: Bool
orExample = L.or $ map (> 4) [1 .. 6] :: Bool

-- `iterate` takes a predicate and a starting value, applying function to the starting value, then the result
-- returns an infinite list
iterateExample = take 10 (L.iterate (* 2) 1) :: [Int]
iterateExample' = take 10 $ L.iterate (* 2) 1 :: [Int]

-- `splitAt` takes a number and a list, then splits the list at that many elements, returing a pair tuple
splitAtExample1 = L.splitAt 3 "heyman" :: (String, String)
splitAtExample2 = L.splitAt 100 "heyman" :: (String, String)
splitAtExample3 = L.splitAt (-3) "heyman" :: (String, String)

-- we've seen `takeWhile` before

-- `dropWhile` is the opposite of `takeWhile`
dropWhileExample = L.dropWhile (/= ' ') "This is a sentence" :: String

-- `span` runs `takeWhile` and returns what `takeWhile` would return and what it would drop
spanExample = L.span (/= ' ') "This is a sentence" :: (String, String)
-- think of it like a `split` function in another language

-- `break` is like `span` but it breaks when the predicate is first true
breakExample = L.break (== ' ') "This is a sentence" :: (String, String)

-- `sort` sorts a list
sortExample = L.sort [8,5,3,2,1,6,4,2] :: [Int]

-- `group` groups elements if they are equal
groupExample = L.group [1,1,1,1,2,2,2,2,3,3,2,2,2,5,6,7] :: [[Int]]

-- `inits` and `tails` work like `init` and `tail`, but do it recursively until there's nothing left of the list
initsExample = L.inits "wooh" :: [String]
tailsExample = L.tails "yeah" :: [String]

-- `isInfixOf` searches for a sublist within a list and returns a bool
isInfixOfExample1 = "cat" `L.isInfixOf` "im a cat burglar" :: Bool
-- `isPrefixOf` and `isSuffixOf` is pretty self explanatory
isPrefixOfExample = "im" `L.isPrefixOf` "im a cat burglar" :: Bool
isSuffixOfExample = "burglar" `L.isSuffixOf` "im a cat burglar" :: Bool
-- `isInfixOf`
isInfixOfExample2 = "im" `L.isInfixOf` "im a cat burglar" :: Bool
isInfixOfExample3 = "burglar" `L.isInfixOf` "im a cat burglar" :: Bool

-- we already know `elem`, and `notElem` does the opposite (returns true if an element is not in a list)

-- `partition` splits up a list based on a predicate, like `span` and `break`, but it doesn't stop after the first true/false
partitionExample = L.partition (`elem` ['A' .. 'Z']) "BOBsidneyMORGANeddy" :: (String, String)

-- we already know `find`, but not what it returns
-- `find` returns a `Maybe a`, which means it could return either nothing or something

-- `elemIndex` works like `elem`, but returns a `Maybe` that is either the index of the first instance of the element or `Nothing`
elemIndexExample1 = 4 `L.elemIndex` [1 .. 6] :: Maybe Int
elemIndexExample2 = 10 `L.elemIndex` [1 .. 6] :: Maybe Int

-- `elemIndices` is like `elemIndex` but it doesn't stop after the first instance, returning an empty list if no elements are matched
elemIndicesExample1 = ' ' `L.elemIndices` "Where are the spaces?" :: [Int]
elemIndicesExample2 = 'z' `L.elemIndices` "Where are the spaces?" :: [Int]

-- `zip3`, `zip4`, `zipWith3`, `zipWith4`, etc. are like `zip` and `zipWith`, but it takes in 3, 4, and so on lists, going up to 7
-- returns tuples of lengths that match the number of lists

-- `lines` takes in a string and splits it into a list by `\n`
linesExample = L.lines "first line\nsecond line\nthird line" :: [String]
-- `unlines` does the opposite
unlinesExample = L.unlines ["first line", "second line", "third line"] :: String
-- `words` and `unwords` split or join based on words
wordsExample = L.words "hey these are the words in this sentence" :: [String]
unwordsExample = L.unwords ["hey","these","are","the","words","in","this","sentence"] :: String

-- `nub` removes duplicate elements in a list
nubExample = L.nub [1,2,3,4,3,2,1,2,3,4,3,2,1] :: [Int]

-- `delete` takes an element and removes its first occurence of it in a list
deleteExample = L.delete 'h' "hey there ghang!" :: String

-- `\\` is a set difference (removes elements of the right list from the left list)
doubleSlashExample = [1..10] \\ [2,5,9] :: [Int]

-- `union` combines the unique elements of each list
unionExample = [1 .. 7] `L.union` [5 .. 10] :: [Int]

-- `intersect` returns the shared elements of a list
intersectExample = [1 .. 7] `L.intersect` [5 .. 10] :: [Int]

-- `insert` inserts an element into a list when it is less than or equal to the next element
insertExample1 = insert 4 [3,5,1,2,8,2] :: [Int]
insertExample2 = insert 4 [1,3,4,4,1] :: [Int]

-- `length`, `take`, `drop`, `splitAt`, `!!`, and `replicate` have generic versions that take in `Num` classtype rather than `Int`
-- `nub`, `delete`, `union`, `intersect`, `group` all have "by" counterparts, that can take in a different equality function other than `==`


-- not gonna do the ones from `Data.Char` cuz it would take forever to get through this chapter and it seems pretty simple, I'll just read through them


sphereVolume3 = sphereVolume 3 :: Float
cubeArea4 = cubeArea 4 :: Float

rectangleArea45 = Rectangle.area 4 5 :: Float
rightTriHypotenuse45 = hypotenuse 4 5 :: Float
