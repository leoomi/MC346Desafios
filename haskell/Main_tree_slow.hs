import System.IO
import Rect

main :: IO ()
main = do
  contents <- getContents
  --putStrLn $ rectListToStrinog $ sortById $ readMultipleRects $ contents
  putStrLn $ show $ solve $ sortById $ readMultipleRects $ contents

solve :: [Node] -> Int
solve nodes = getMax (makeTree nodes) 0

makeTree :: [Node] -> [Node]
makeTree tree = foldl (\acc x -> addNode acc x 0 0) tree [0..(length tree)-1]

getMax tree currId
  | length children == 0 = area rect
  | otherwise = (area rect) + maxChildren
  where rect = getRect (tree !! currId)
        children = getChildren (tree !! currId)
        maxChildren = maximum (map (getMax tree) children)
