module TestMain exposing (..)

import ElmTest exposing (..)
import GameLogicTests

tests : Test
tests =
  suite "All tests"
  [ GameLogicTests.tests
  ]

main : Program Never
main = runSuite tests
