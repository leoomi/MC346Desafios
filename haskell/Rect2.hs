module Rect
       (
         Rect,
         Node,
         getRect,
         getChildren,
         readRect,
         readMultipleRects,
         area,
         sortById,
         addNode,
         --debug functions from here on out
         rectListToString
       )where
import Data.List

--               id  xmin xmax ymin ymax
data Rect = Rect Int Int  Int  Int  Int
            deriving (Eq, Show)
                     
-- Tree structure. A node contains a Rect and its children's id. A child is a compatible Rect with a higher xmin and ymin that the node's Rect's xmax and ymax
data Node = Node Rect [Int]
            deriving (Show)

getRect :: Node -> Rect
getRect (Node rect _) = rect

getChildren :: Node -> [Int]
getChildren (Node _ children) = children
        
-- calculates the area of a Rect variable
area :: Rect -> Int
area (Rect _ xmin xmax ymin ymax) = (xmax - xmin) * (ymax - ymin)

-- reads two Rect variables. Returns 1 or 2 if both variables are compatibles, that is, if one variable has all of its X coordinates smallers than the others, and all of its Y coordinates as well, without intersection. 1 means the first Rect is lower than the second and 2 is the opposite. Returns 0 otherwise
compatible :: Rect -> Rect -> Int
compatible (Rect _ xminA xmaxA yminA ymaxA) (Rect _ xminB xmaxB yminB ymaxB)
  | (xmaxA < xminB) && (ymaxA < yminB) = 1
  | (xmaxB < xminA) && (ymaxB < yminA) = 2
  | otherwise = 0

-- From a list of Rect ids, returns a list of tuples with compatible Rect's ids and the compatible function return value
getCompatibleNodes :: [Node] -> [Int] -> Rect -> [(Int, Int)]
getCompatibleNodes tree list rect = filter (\(id, comp) -> (comp > 0) && (id /= 0)) tuples
  where rects = map getRect [ tree !! x | x <- list]
        tuples = [ (getId a, compatible rect a) | a <- rects]
        getId (Rect id _ _ _ _) = id
        
-- Returns a Rect with area of 0 and the minimal coordinates
minimalRect = let min = minBound :: Int in (Rect 0 min min min min)

-- Sorts Node list with id
sortById :: [Node] -> [Node]
sortById list = sortBy cmpId list
  where cmpId (Node (Rect idA _ _ _ _) _) (Node (Rect idB _ _ _ _) _) = compare idA idB
        
searchForCompatible :: [Node] -> Rect -> [Int] -> [Int]
searchForCompatible _    _    []  = []
searchForCompatible tree rect (x:xs)
  | compatible currRect rect == 0 = searchForCompatible tree rect children
  | compatible currRect rect  > 0 = (x:searchForCompatible tree rect xs)
    where (Node currRect children) = tree !! x
          
findAndReplace oldVal newVal (x:xs)
  | x == oldVal = newVal:xs
  | otherwise   = x : (findAndReplace oldVal newVal xs)

updateNode n newVal (x:xs)
  | n == 0    = newVal:xs
  | otherwise = x : (updateNode (n-1) newVal xs)

--- IO Functions ---
-- reads a single string line that represents a rectangle and returns its correspondent Rect type variable
readRect :: String -> Rect
readRect input = (Rect id xmin xmax ymin ymax)
  where (id:xmin:xmax:ymin:ymax:_) = [ read x :: Int | x <- (words input) ]

-- reads a string with multiple lines and runs the read Rect on each one, returning a list of Node type variables, appended with a minimal rect
readMultipleRects :: String -> [Node]
readMultipleRects input = (map (stringToNode) (lines input)) ++ [(Node minimalRect [])]
  where stringToNode string = (Node (readRect string) [])

-- Add a node to a tree
addNode :: [Node] -> Int -> Int -> Int -> [Node]
addNode tree newId parentId currId
  | (comp == 2) && (length compatibleChildren == 0) && (length childrenB == 0)= updateNode currId (Node rectB (childrenB ++ [newId])) tree
  | (comp == 2) && (length compatibleChildren == 0) = updateNewAndCurrent
  | comp == 2 = foldl (\acc x -> addNode acc newId currId x) tree (childrenB)
  | comp == 1 = invertNodes
  | comp == 0 = tree
  where (Node rectA childrenA) = tree !! newId
        (Node rectB childrenB) = tree !! currId
        (Node rectC childrenC) = tree !! parentId
        comp = compatible rectA rectB
        compatibleChildren = getCompatibleNodes tree childrenB rectA
        invertNodes = updateNode newId (Node rectA (childrenA ++ [currId])) (updateNode parentId (Node rectC (findAndReplace currId newId childrenC)) tree)
        updateNewAndCurrent = updateNode currId (Node rectB (childrenB ++ [newId])) (updateNode newId (Node rectA (childrenA ++ (searchForCompatible tree rectA childrenB))) tree)

--debug functions
rectListToString list =  unlines $ map (show) list

