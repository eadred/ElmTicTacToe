module Utils exposing (const, oneOf)

import Check.Producer as P
import Shrink as S
import Random as R
import Random.Extra as RE
import Lazy.List as L

const : a -> P.Producer a
const a = P.Producer (RE.constant a) S.noShrink

oneOf : List (P.Producer a) -> P.Producer a
oneOf ps =
  let -- Producer a -> Generator (a, Shrinker a)
      -- Given a Producer a get a Generator that produces pairs consisting of
      -- a value and a shrinker to apply to that value
      toGenAndShrinker p = p.generator |> R.map (\a -> (a, p.shrinker))
      -- Generator (a, Shrinker a)
      generator = ps |> List.map toGenAndShrinker |> RE.choices
       -- Shrinker (a, Shrinker a)
      shrinker (a, subshrinker) = subshrinker a |> L.map (\a' -> (a', subshrinker))
  in P.Producer generator shrinker |> P.map (\(a, s) -> a)
