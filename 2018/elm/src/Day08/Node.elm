module Day08.Node exposing (Node(..), children, data, flatten)


type Node a
    = Node (List (Node a)) a


flatten : Node a -> List (Node a)
flatten node =
    childless node
        :: List.foldl List.append [] (List.map flatten (children node))


children : Node a -> List (Node a)
children (Node childNodes nodeData) =
    childNodes


data : Node a -> a
data (Node childNodes nodeData) =
    nodeData


childless : Node a -> Node a
childless (Node childNodes nodeData) =
    Node [] nodeData
