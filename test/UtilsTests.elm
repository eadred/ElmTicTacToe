module UtilsTests exposing (tests)

import ElmTest exposing (..)
import Check as C
import Check.Producer as P
import Check.Test as T
import Utils as U

const : C.Claim
const =
  let constVal = "Hello, World!" in
  C.claim "const producer should always return same value"
    `C.that` identity
    `C.is` (always constVal)
    `C.for` U.const constVal

-- The oneOf producer should be producing either 1, 5 or 7
-- If we filter this to just the 5 values then all values from this producer will be 5
-- However if oneOf doesn't actually produce 5 values then the filtered producer won't
-- produce any values and the test will fall over
oneOf : C.Claim
oneOf =
  let constVal = 5 in
  C.claim "oneOf should sometimes produce values from one of the producers"
    `C.that` identity
    `C.is` (always constVal)
    `C.for` (U.oneOf [U.const 1, U.const constVal, U.const 7] |> P.filter (\v -> v == constVal))

oneOfComplex : C.Claim
oneOfComplex =
  let constVal = 1 in
  C.claim "oneOf should sometimes produce values from one of the producers (complex)"
    `C.that` identity
    `C.is` (always constVal)
    `C.for` (U.oneOf [(P.rangeInt 0 2), (P.rangeInt 10 12)] |> P.filter (\v -> v == constVal))

claims : C.Claim
claims =
  C.suite
    "Utils"
    [ const
    , oneOf
    , oneOfComplex
    ]

tests : Test
tests = claims |> C.quickCheck |> T.evidenceToTest
