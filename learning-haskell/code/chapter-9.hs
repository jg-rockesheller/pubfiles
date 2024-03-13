-- main = putStrLn "Hello, world!"

-- the type declaration of `putStrLn` is `String -> IO ()`
-- the `IO ()` means that the function returns an I/O action that has a result type of `()` (an empty tuple)
-- an I/O action have side-effects (like printing to screen or reading input)
-- we put I/O actions in a `main` function

-- we can do multiple I/O actions in `main` using `do`
-- main = do
--        putStrLn "Enter your name:"
--        name <- getLine
--        putStrLn ("Hello, " ++ name ++ "!")
-- `do` takes in multiple I/O actions and turns them into a single one

-- `getLine` has the type signature of `IO String` because it takes user input and turns it into a `String`
-- the `name <- getLine` means we are binding the value of `getLine` to the variable `name`
-- `<-` is used to take an action that returns `IO <type>` and take that `<type>` out of the action and bind it to a variable
-- data in an I/O action can only be taken out when inside another I/O action (such as `main` in this case)

-- every I/O action has a result encapsulated in it, so we could do:
-- `foo <- putStrLn "Enter your name: "`
-- but this would make the type of `foo` `()`, so we don't have to bind I/O actions
-- in a `do` block, the last action cannot be bound to a name

-- you use `let` expressions in `do` blocks like you do in list comprehensions (with no `in`)
-- import Data.Char as Data.Char
-- main = do
--        putStrLn "First name:"
--        firstName <- getLine
--        putStrLn "Last name:"
--        lastName <- getLine
--        let bigFirstName = map Data.Char.toUpper firstName
--            bigLastName = map Data.Char.toUpper lastName
--        putStrLn (bigFirstName ++ " " ++ bigLastName)

-- use `let` instead of `<-` when doing stuff that isn't related to I/O actions (i.e just a `map`)
-- if we did `let firstName = getLine`, it would just map `getLine` to `firstName`, and we would have to use `firstName` like `getLine`

-- continuously reversing strings:
-- main = do
--        str <- getLine
--        if str == ""
--            then return ()
--            else do
--                let reversedStr = reverseLine str
--                putStrLn reversedStr
--                main
-- reverseLine :: String -> String
-- reverseLine = foldl (\acc ch -> ch : acc) ""
-- the `else` and `do` in the `else do` can be though of as separate, as the `do` just glues together I/O actions

-- the `return ()` means that `main` returns an `IO ()`
-- `return` wraps a value in a box, we could `return` something and use `<-` to unwrap it somewhere else
-- `return` isn't the keyword that ends the `do` block, that would be the `if then`, instead it makes sure we have something to return for the condition
-- this means we could do the following:
-- main = do
--        a <- return "Hello"
--        b <- return "World"
--        putStr $ a ++ " " ++ b ++ "\n"
--        putChar (a !! 0)
--        print 3.2
--        print [3, 4, 3]
-- `putStr` is like `putStrLn` but it doesn't printout a new line character
-- `putChar` is like `putStr` but it only prints out a char
-- `print` takes any value of a type that's an instance of `Show` and basically runs `putStrLn . show` on it

-- `getChar` is like getLine but it takes in chars
-- main = do
--        c <- getChar
--        if c /= ' '
--            then do
--                putChar c
--                main
--            else return ()
-- `getChar` gets chars one at at time, but we have to press enter in order to pass it a value, so it will go in order everytime `getChar` is called again

-- `when` takes a boolean value and an I/O action if the bool value is true
-- when the bool value is false, it runs `return ()`
-- import Control.Monad as Control.Monad
-- main = do
--        c <- getChar
--        when (c /= ' ') $ do
--            putChar c
--            main

-- `sequence` runs multiple I/O actions performed one after another and the result is an I/O action containing the results of the other I/O actions
-- the type signature is `sequence :: [IO a] -> IO [a]`
-- main = do
--        rs <- sequence [getLine, getLine, getLine]
--        print rs

-- `mapM` is used like `map` but the predicate is an I/O action
-- `mapM print [1, 2, 3]`
-- `mapM_` throws away the result
-- `mapM_ print [1, 2, 3]`

-- `forever` takes an I/O action and returns an I/O action that repeats the given I/O action forever
-- import Control.Monad as Control.Monad
-- import Data.Char as Data.Char
-- main = Control.Monad.forever $ do
--        putStr "Give me an input: "
--        l <- getLine
--        putStrLn $ map Data.Char.toUpper l

-- `forM` is like `mapM` but its parameters are switched, which is better for readability with lambdas
-- import Control.Monad as Control.Monad
-- main = do
--        colors <- forM [1, 2, 3, 4] (\a -> do
--            putStrLn $ "Which color do you associate with the number " ++ show a ++ "?"
--            color <- getLine
--            return color)
--        putStrLn "The colors that you associate with 1, 2, 3, and 4 respecitively are: "
--        mapM putStrLn colors

-- `getContents` is an I/O action that reads eerything from the standard input until it encounters an end-of-file character
-- import Data.Char as Data.Char
-- main = do
--        contents <- getContents
--        putStr (map Data.Char.toUpper contents)
-- we pipe some sort text into the compiled binary, which will be received by `getContents`
-- works as if we did a `forever $ do` and `getLine`, but can also receive stuff piped to the executable

-- printing line shorter than 10 chars
-- main = do
--        contents <- getContents
--        putStr (shortLinesOnly contents)
-- shortLinesOnly :: String -> String
-- shortLinesOnly input =
--     let allLines = lines input -- remember that `lines` takes in a string that contains "\n" escape sequences and turns it into a list of strings
--         shortLines = filter (\line -> length line < 10) allLines
--         result = unlines shortLines
--     in result

-- taking a string from input and transforming it is common, so there is a function `interact` that makes it easier
-- the type signature of interact is `interact :: (String -> String) -> IO ()`
-- main = interact shortLinesOnly
-- shortLinesOnly :: String -> String
-- shortLinesOnly input =
--     let allLines = lines input -- remember that `lines` takes in a string that contains "\n" escape sequences and turns it into a list of strings
--         shortLines = filter (\line -> length line < 10) allLines
--         result = unlines shortLines
--     in result

-- we could simplify this even further although we will give up readability using partially applied functions:
-- main = interact $ unlines . filter ((< 10) . length) . lines

-- palindrome implementation:
-- main = interact palindromeReplace
-- palindromeReplace :: String -> String
-- palindromeReplace input = unlines (map (\xs -> if isPalindrome xs then "palindrome" else "not a palindrome") (lines input))
--                           where isPalindrome xs = xs == reverse xs

-- to open files:
-- import System.IO as System.IO
-- main = do
--        handle <- System.IO.openFile "girlfriend.txt" ReadMode
--        contents <- System.IO.hGetContents handle
--        putStr contents
--        System.IO.hClose handle
-- the type signature of `openFile` is `openFile :: FilePath -> IOMode -> IO Handle`
-- this means it takes in the path to a file, the mode in which the file should be opened, and then it returns a handle of the file
-- a `Handle` is used to represent where a file is
-- `hGetContents` is a function that takes in a `Handle` and returns an `IO String`
-- `hGetContents` doesn't read the whole file and stores it in memory, instead getting the parts as needed (because Haskell is lazy)
-- `hClose` is necessary whenever `openFile` is used

-- you can do a similar thing using `withFile`:
-- import System.IO as System.IO
-- main = do
--        withFile "girlfriend.txt" ReadMode (\handle -> do
--            contents <- hGetContents handle
--            putStr contents)
-- opening and closing the file and handle are handled automatically
-- there are also the `hGetLine`, `hPutStr`, `hPutStrLn`, and `hGetChar` functions, which do as the name suggests

-- `readFile` takes in a file path and outputs it contents
-- import System.IO as System.IO
-- main = do
--        contents <- readFile "girlfriend.txt"
--        putStr contents

-- `writeFile` takes a path to a file and a string and writes to the file
-- import System.IO as System.IO
-- import Data.Char as Data.Char
-- main = do
--        contents <- System.IO.readFile "girlfriend.txt"
--        System.IO.writeFile "girlfriendcaps.txt" (map Data.Char.toUpper contents)
-- this overwrites, rather than appends, to a file

-- `appendFile` appends to a file
-- import System.IO as System.IO
-- import Data.Char as Data.Char
-- main = do
--        contents <- System.IO.readFile "girlfriend.txt"
--        System.IO.appendFile "girlfriendcaps.txt" (map Data.Char.toUpper contents)

-- `hFlush` takes a handle and returns an I/O action that will flush the buffer of the handle
-- when reading a file line by line, the buffer is flushed automatically after every line

-- `openTempFile` takes a path to a temporary directory and a template name for a file, opening said file in said directory
-- `openTempFile` returns a tuple pair that contains the name of the file, and the file handle
-- `"."` stands for the current directory

-- the `System.Environment` module provides the `getArgs` function, which returns an `IO [String]`, as well as `getProgName`, which returns an `IO String`
-- the names should be self explanatory
-- import System.Environment as System.Environment
-- import Data.List as Data.List
-- main = do
--        args <- System.Environment.getArgs
--        progName <- System.Environment.getProgName
--        putStrLn "The arguments are: "
--        mapM putStrLn args
--        putStrLn "The program name is: "
--        putStrLn progName

-- todo implementation:
-- import Data.List as Data.List
-- import System.Directory as System.Directory
-- import System.Environment as System.Environment
-- import System.IO as System.IO
--
-- data Command = Add | Remove | View
--
-- main = do
--        (command:args) <- System.Environment.getArgs
--        let action = dispatch command
--        action args
--        return ()
--
-- dispatch :: String -> ([String] -> IO ())
-- dispatch command
--     | command == "add" = add
--     | command == "remove" = remove
--     | command == "view" = view
--     | otherwise = invalidCommand
--
-- add :: [String] -> IO ()
-- add [] = do
--          putStrLn "no file specified"
--          return ()
-- add (file:[]) = do
--                 putStrLn "nothing to append"
--                 return ()
-- add (file:tasks) = do
--                    let newLineTasks = map (++ "\n") tasks
--                    mapM (appendFile file) (newLineTasks)
--                    return ()
--
-- remove :: [String] -> IO ()
-- remove [] = do
--             putStrLn "no file specified"
--             return ()
-- remove [file] = do
--                 putStrLn "no indices specified"
--                 return ()
-- remove [file, index] = do
--                        handle <- openFile file ReadMode
--                        (tempName, tempHandle) <- openTempFile "." "temp"
--                        contents <- System.IO.hGetContents handle
--                        let number = read index
--                            todoTasks = lines contents
--                            newTodoItems = delete (todoTasks !! number) todoTasks
--                        System.IO.hPutStr tempHandle $ unlines newTodoItems
--                        System.IO.hClose handle
--                        System.IO.hClose tempHandle
--                        removeFile file
--                        System.Directory.renameFile tempName file
--
-- view :: [String] -> IO ()
-- view [] = do
--           putStrLn "no file specified"
--           return ()
-- view [file] = do
--               contents <- readFile file
--               let tasks = lines contents
--                   numberedTasks = zipWith (\linum line -> show linum ++ " : " ++ line) [0..] tasks
--               putStr $ unlines numberedTasks
--               return ()
-- view (file:_) = do
--                 putStrLn "too many arguments for view"
--                 return ()
--
-- invalidCommand :: [String] -> IO ()
-- invalidCommand _ = do
--                    putStrLn "invalid command"
--                    return ()

-- the type signature of the `random` function from the `System.Random` module is `random :: (RandomGen g, Random a) => g -> (a, g)`
-- the `RandomGen` typeclass is for types that can act as sources of randomness
-- the `Random` typeclass is for things that can take on random values
-- the `random` function takes in a random generator, then returns a random value and a new random generator

-- we can manually create a random generator using `mkStdGen`
-- import System.Random as System.Random
-- mkStdGenExample :: Int -> (Int, System.Random.StdGen)
-- mkStdGenExample n = System.Random.random (System.Random.mkStdGen n)
-- we can make this return any type
-- mkStdGenExample2 n = System.Random.random (System.Random.mkStdGen n) :: (Float, StdGen)
-- mkStdGenExample3 n = System.Random.random (System.Random.mkStdGen n) :: (Bool, StdGen)
-- mkStdGenExample4 n = System.Random.random (System.Random.mkStdGen n) :: (Integer, StdGen)

-- coin flip implementation:
-- import System.Random as System.Random
-- mapTriple :: (a -> b) -> (a, a, a) -> (b, b, b)
-- mapTriple f (a1, a2, a3) = (f a1, f a2, f a3)
-- flipCoins :: Int -> (String, String, String)
-- flipCoins n =
--   let randGenerator = System.Random.mkStdGen n
--       (flip1, randGen1) = System.Random.random randGenerator
--       (flip2, randGen2) = System.Random.random randGen1
--       (flip3, _) = System.Random.random randGen2
--       results = mapTriple (\b -> if b == True then "heads" else "tails") (flip1, flip2, flip3)
--    in results

-- we could do this shorter using `randoms`, which returns an infinite list of values based on a generator
-- import System.Random as System.Random
-- type Seed = Int
-- flipCoins :: Int -> Seed -> [String]
-- flipCoins n s = take n $ map (\b -> if b == True then "heads" else "tails") (randoms (mkStdGen s))

-- notice how in the previous examples we didn't have to specify that we wanted `random` to return a bool because later we use its results like a bool, so Haskell can infer what we want it to become

-- `randoms` implementation:
-- import System.Random as System.Random
-- randoms' :: (System.Random.RandomGen g, System.Random.Random a) => g -> [a]
-- randoms' gen = let (value, newGen) = System.Random.random gen in value:randoms' newGen

-- we can use `randomR` to get a random value in a range
-- import System.Random as System.Random
-- randomRExample min max seed = System.Random.randomR (min, max) (System.Random.mkStdGen seed) :: (Int, StdGen)

-- we can use `randomRs` to produce an infinite stream of random values within a range
-- import System.Random as System.Random
-- randomRsExample min max seed length = take length $ System.Random.randomRs (min, max) (System.Random.mkStdGen seed) :: String

-- `getStdGen` is an I/O action that returns a value of type `IO StdGen` it asks the system for a good random number generator and stores that in a global generator
-- import System.Random as System.Random
-- main = do
--   gen <- System.Random.getStdGen
--   putStrLn $ take 20 (System.Random.randomRs ('a', 'z') gen)

-- you cannot use `getStdGen` twice, as it will return the same value, instead use `random` to make a new generator or split whatever is returned from `randomRs`
-- or you can use `newStdGen`, which will just return a new generator wrapped in `IO`

-- number guessing game implementation:
-- import Control.Monad (when)
-- import System.Random (getStdGen, newStdGen, StdGen, randomR)
-- 
-- main :: IO ()
-- main = do
--     gen <- getStdGen
--     guessingGame gen
--     return ()
-- 
-- guessingGame :: StdGen -> IO ()
-- guessingGame gen = do
--     putStr "Guess the number between 1 and 10: "
--     guess <- getLine
-- 
--     let (value, newGen) = randomR (1, 10) gen :: (Int, StdGen)
--         guessInt = read guess :: Int
-- 
--     if guessInt == value
--         then putStrLn "Correct!"
--         else do putStrLn ("Incorrect, the corrent number is: " ++ show value)
-- 
--     putStr "Play again? [y/n] "
--     playAgain <- getLine
--     if playAgain == "y"
--         then guessingGame newGen
--         else return ()