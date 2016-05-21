module Rect
       (
         Rect,
         readRect,
         readMultipleRects,
         area,
         compatible,
         --debug functions from here on out
         rectListToString
       )where

--               id  xmin xmax ymin ymax
data Rect = Rect Int Int  Int  Int  Int
            deriving (Eq, Show)

-- reads a single string line that represents a rectangle and returns its correspondent Rect type variable
readRect :: String -> Rect
readRect input = (Rect id xmin xmax ymin ymax)
  where (id:xmin:xmax:ymin:ymax:_) = [ read x :: Int | x <- (words input) ]

-- reads a string with multiple lines and runs the read Rect on each one, returning a Rect type variable
readMultipleRects :: String -> [Rect]
readMultipleRects input = map (readRect) (lines input)

-- calculates the area of a Rect variable
area :: Rect -> Int
area (Rect _ xmin xmax ymin ymax) = (xmax - xmin) * (ymax - ymin)

-- reads two Rect variables. Returns True if both variables are compatibles, that is, if one variable has all of its X coordinates smallers than the others, and all of its Y coordinates as well, without intersection. Returns False otherwise
compatible :: Rect -> Rect -> Bool
compatible (Rect _ xminA xmaxA yminA ymaxA) (Rect _ xminB xmaxB yminB ymaxB)
  | (xmaxA < xminB) && (ymaxA < yminB) = True
  | (xmaxB < xminA) && (ymaxB < yminA) = True
  | otherwise = False

-- Returns a Rect with area of 0 and the minimal coordinates
minimalRect = let min = minBound :: Int in (Rect 0 min min min min)

--debug functions
rectListToString list =  unlines $ map (show) list

