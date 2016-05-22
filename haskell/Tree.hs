module Tree
       (
         Node
       ) where

-- Node contains a Rect id and its children. A child is a compatible Rect with a higher xmin and ymin that the node's Rect's xmax and ymax
--               id       children
data Node = Node Int     [Int]
          deriving(Show)

initializeTree = (Node 0 [])
--addNode node rectList = ()

yoyo = minimalRect
