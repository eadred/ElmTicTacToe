module TestMain exposing (..)

import ElmTest exposing (..)
import GameLogicTests
import Cells.ModelsTests

tests : Test
tests =
  suite "All tests"
  [ GameLogicTests.tests
  , Cells.ModelsTests.tests
  ]

main : Program Never
main = runSuite tests
