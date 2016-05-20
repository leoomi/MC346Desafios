import System.IO
import Rect

main :: IO ()
main = do
  contents <- getContents
  putStrLn $ process $ readMultipleRects $ lines contents

process :: [Rect] -> String
process = unlines.map(""++)
--getCompatibleRect :: Rect -> [Rect] -> [Rect]
--getCompatibleRect (Rect ) list = filter (\) list
