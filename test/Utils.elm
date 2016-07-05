module Utils exposing (const, oneOf)

import Check.Producer as P
import Shrink as S
import Random as R
import Lazy.List as L

const : a -> P.Producer a
const a = P.unit |> P.map (always a)

oneOf : List (P.Producer a) -> P.Producer a
oneOf ps =
  let indexed = indexedProducers ps
       -- Generator (Int, a)
      generator =
        (R.int 0 (List.length ps - 1))
        `R.andThen` (\idx -> (getAt indexed idx).generator)
       -- Shrinker (Int, a)
      shrinker (idx,a) = a |> (getAt ps idx).shrinker |> L.map (\a' -> (idx, a'))
  in P.Producer generator shrinker |> P.map (\(idx,a) -> a)

-- Internal functions

indexedProducers : List (P.Producer a) -> List (P.Producer (Int, a))
indexedProducers =
  let applyIndex idx = P.map (\a -> (idx,a)) in
  List.indexedMap applyIndex

getAt : List a -> Int -> a
getAt ls n =
  case (ls,n) of
    ([], _) -> Debug.crash "Reached end of list"
    ((x::xs), 0) -> x
    ((x::xs), _) -> getAt xs (n-1)
