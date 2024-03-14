-- reverse polish notation calucator:
import Data.List (words)
solveRPN :: String -> Float
solveRPN expression = head (foldl foldingFunction [] (words expression))
    where foldingFunction (x:y:xs) "+" = (x + y):xs
          foldingFunction (x:y:xs) "*" = (x * y):xs
          foldingFunction (x:y:xs) "-" = (x - y):xs
          foldingFunction (x:y:xs) "/" = (x / y):xs
          foldingFunction xs "sum" = [sum xs]
          foldingFunction xs x = read x:xs

-- heathrow to london implementation:
-- remember: a and b are horizontal roads and c is the road between a and b
data Section = Section { getA :: Int, getB :: Int, getC :: Int } deriving (Show)
type RoadSystem = [Section]

heathrowToLondon :: RoadSystem
heathrowToLondon = [Section 50 10 30, Section 5 90 20, Section 40 2 25, Section 10 8 0]  

data Label = A | B | C deriving (Show) -- what road you should take
type Path = [(Label, Int)] -- the path is the label and length of the labeled road

optimalPath :: RoadSystem -> Path
optimalPath roadSystem =
    let (bestAPath, bestBPath) = foldl roadStep ([], []) roadSystem -- find the best path till the end of the road system
    -- this will leave us with two possible shortest routes, so we just sum up their distances and check which one is smaller
    in if sum (map snd bestAPath) <= sum (map snd bestBPath)
            then reverse bestAPath
            else reverse bestBPath
    -- reversing because `roadStep` returns optimal paths in reverse

-- `roadStep` takes in the optimal path to the current A and B nodes and the current section, then returns the new optimal path to the next A and B nodes
roadStep :: (Path, Path) -> Section -> (Path, Path)
roadStep (pathA, pathB) (Section a b c) =
    let priceA = sum $ map snd pathA -- first get the price it took to get to the current A and B nodes
        priceB = sum $ map snd pathB

        forwardA = priceA + a -- calculate the price it would take if we kept going on the nodes going right from our A and B nodes
        forwardB = priceB + b

        crossA = c + forwardB -- calculate the price it would take if we crossed into the other road
        crossB = c + forwardA

        -- these are finding the new optimal paths to the next A or B nodes
        newPathToA = if forwardA <= crossA -- check if its better to cross over to A from the B node or keep going on the A node
                        then (A, a):pathA
                        else (C, c):(B, b):pathB
        newPathToB = if forwardB <= crossB -- vice versa
                        then (B, b):pathB
                        else (C, c):(B, b):pathA
        in (newPathToA, newPathToB)