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
  let generator = ps |> List.map (\p -> p.generator) |> RE.choices
  in P.Producer generator S.noShrink
