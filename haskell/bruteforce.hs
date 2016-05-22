import System.IO
import Rect

main :: IO ()
main = do
  contents <- getContents
  putStrLn $ rectListToString $ readMultipleRects $ contents

test list = maximum $ map (`maxSum` list) list

findCompatibles :: Rect -> [Rect] -> [Rect]
findCompatibles x list = filter (`compatible` x) list

maxSum :: Rect -> [Rect] -> Int
maxSum x list
  | comp == [] = area x 
  | otherwise  = (area x) + (maximum $ map (`maxSum` comp) comp)
  where comp = findCompatibles x list
