module TestMain exposing (..)

import ElmTest exposing (..)

tests : Test
tests =
    suite "A Test Suite"
        [ test "Addition" (assertEqual (3 + 7) 10)
        , test "Dummy test" (assert True)
        ]


main : Program Never
main =
    runSuite tests
