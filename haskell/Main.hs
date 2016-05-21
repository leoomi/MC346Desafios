import System.IO
import Rect

main :: IO ()
main = do
  contents <- getContents
  --putStrLn $ rectListToString $ readMultipleRects $ contents
  putStrLn $ show $ test $ readMultipleRects $ contents

test list = maximum $ map (`maxSum` list) list

findCompatibles :: Rect -> [Rect] -> [Rect]
findCompatibles x list = filter (`compatible` x) list

maxSum :: Rect -> [Rect] -> Int
maxSum x list
  | comp == [] = area x 
  | otherwise  = (area x) + (maximum $ map (`maxSum` comp) comp)
  where comp = findCompatibles x list

-- Rect 1 3 5 2 10 (16)
-- [Rect 2 9 13 13 16 (12) ,Rect 5 16 20 11 14 (12),Rect 7 23 27 13 14 (4)]
