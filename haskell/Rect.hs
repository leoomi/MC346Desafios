module Rect
       (
         Rect,
         readRect,
         readMultipleRects
       )where

--               id  xmin xmax ymin ymax area
data Rect = Rect Int Int  Int  Int  Int  Int
            deriving (Show) -- for testing

readRect :: String -> Rect
readRect input = (Rect id xmin xmax ymin ymax area)
  where (id:xmin:xmax:ymin:ymax:_) = [ read x :: Int | x <- (words input)]
        area = ((xmax - xmin)*(ymax - ymin))

readMultipleRects :: String -> [Rect]
readMultipleRects input = map (readRect) (lines input)


--compatibleRect :: Rect -> Rect -> Bool
--compatibleRect a b =
