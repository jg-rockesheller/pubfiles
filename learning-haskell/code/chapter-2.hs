-- this is how comments are made
-- load file in ghci using `:l chapter-2.hs`
-- `let` is used to name expressions in ghci

-- basic operations
twoPlusFifteen = 2 + 15
fiveDivTwo = 5 / 2
threeOperations = 50 * (100 - 4999)
negativeNumbers = (-50) + 10 -- must fence negative numbers with parenthases

-- expressions that result in a bool
sixNotSeven = 6 /= 7
helloIsHello = "hello" == "hello"

-- prefix functions
minNineTen = min 9 10
maxNineTen = max 9 10
afterTen = succ 10
fusionOne = (succ 9) * (min 9 10) + (max 5 4) / 5 -- apprently `succ` is a partial function?

-- infix functions
threeDivTwo = div 3 2        -- integer division
threeDivTwoInfix = 3 `div` 2 -- integer division

-- functions can be called out of order
anyOrder = doubleSmallNumber 2 + 1

-- if statements
doubleSmallNumber x = if x > 100
                      then x
                      else x * 2
doubleSmallNumber' x = if x > 100 then x else x * 2 -- single quotes can be used in function names
                                                    -- often used to denote a slightly changed function

-- let there be lists
a = 1
numList = [1,2,3,4,5]
plusPlusList = [1,2,3] ++ [4,5,6] -- [1,2,3,4,5,6]
strsAreCharLists =  "he" ++ "llo" -- "hello" == ['h', 'e'] ++ ['l', 'l', 'o']
conOperator = 5:[6,7,8] -- [5,6,7,8]
-- ++ appends to the end of a list and therefore has to traverse the list, whereas
-- cons pushes to a list, which is O(1) (I think IIRC)
theNumberFive = numList !! 4 -- apparently `!!` is a partial function? kindla like numList[4] in C
twoDimensionalList = [[1,2,3,4],[5,3,3,3],[1,2,2,3,4],[1,2,3]]

-- comparisons can be done on lists (lexicographical)
-- all the following express `true`
listCompOne = [3,2,1] > [2,1,0]
listCompTwo = [3,2,1] > [2,10,100]
listCompThree = [3,4,2] > [3,4]
listCompFour = [3,4,2] > [2,4]
listCompFive = [3,4,2] == [3,4,2]

-- common list functions
headExample = head [5,4,3,2,1]
tailExample = tail [5,4,3,2,1]
lastExample = last [5,4,3,2,1]
initExample = init [5,4,3,2,1]
lengthExample = length [5,4,3,2,1]
nullLengthExample = length []
nullExample = null []
reverseExample = reverse [5,4,3,2,1]
takeExampleOne = take 3 [5,4,3,2,1]
takeExampleTwo = take 10 [5,4,3,2,1]
takeExampleThree = take 0 [5,4,3,2,1]
dropExample = drop 3 [5,4,3,2,1] -- `drop` is the opposite of `take`
minimumExample = minimum [5,4,3,2,1]
maximumExample = maximum [5,4,3,2,1]
sumExample = sum [5,4,3,2,1]
productExample = product [5,4,3,2,1]
elemExampleOne = elem 4 [3,4,5,6] -- kinda like a .contains() method
elemExampleTwo = 4 `elem` [3,5,6] -- `elem` is usually used as an infix
-- apparently most of these are all partial functions?

-- ranges
-- only does arithmetic sequences (thank god I'm learning what that means in Calc)
oneThroughTwenty = [1 .. 20]
lowerAlphabet = ['a' .. 'b']
evenNumbers = [2,4 .. 20]
floatRangesWeird = [0.1,0.3 .. 1]
haskellIsLazy = take 10 [2,4..] -- same as `evenNumbers`
repetitionOne = take 10 (cycle [1,2,3]) -- cycle expresses a list that cycles values
iLikeToRideMyBicycle = take 15 (cycle "I like to ride by Bicycle. I like to ride my bike. ") -- strings flatten into a single string
repeatExample = take 5 (repeat 10) -- [10,10,10,10,10]
replicateExample = replicate 5 10 -- same as `repeatExample`

-- I don't know sets in math (list comprehensions)
evenNumbersComprehension = [ x * 2 | x <- [1 .. 10] ] -- equal to `take 10 [2,4..]`
predicateExample = [ x * 2 | x <- [1 .. 10], x * 2 >= 12 ]
numsFiftyToHundredModSevenIsThree = [ x | x <- [50 .. 100], x `mod` 7 == 3 ] -- very nice expression name
-- I'm guessing `xs` is used as a placeholder for a list by convention
bangBoom xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x ] -- example of filtering
bangBoomCall = bangBoom [1..50]
multiplePredicates = [ x | x <- [1 .. 10], x /= 13, x /= 19 ]
adjectives = ["lazy", "grouchy", "scheming"]
nouns = ["hobo", "frog", "pope"]
funnyPhrases xs ys = [ x ++ " " ++ y | x <- xs, y <- ys ]
funnyPhrasesCall = funnyPhrases adjectives nouns
multipleListPredicates = [ x * y | x <- [2,5,10], y <- [8,10,11], x * y >= 50]
length' xs  = sum [ 1 | _ <- xs ] -- `_` isn't used because we don't care about the values in the list
                                  -- basically the same as `sum [1,1,1,....]` until the end of the list
removeNonUpperCase xs = [ x | x <- xs, x `elem` ['A' .. 'Z'] ]
-- `xss` used because it is a two dimensional list
removeOdds xss = [ [ x | x <- xs, even x ] | xs <- xss ]
removeOddsCall = removeOdds twoDimensionalList -- check above to see `twoDimensionalList` definition

-- tuples
exampleTuple = ("Name", 55) -- typles have fixed length and types but can be heterogeneous
fstExample = fst (8, 11)
sndExample = snd ("Wow", False)
zipExample = zip [1..] ['a' .. 'z'] -- zip is pretty cool, and helped by the fact that Haskell is lazy
triangles maxLength perimiter = take 1 [ (a,b,c) | a <- [1 .. maxLength], b <- [1 .. maxLength], c <- [1 .. maxLength],
                                         (a^2) + (b^2) == (c^2), a + b + c == perimiter ]
trianglesCallOne = triangles 10 24
trianglesCallTwo = triangles 200 360
