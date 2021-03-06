module TestMain exposing (..)

import ElmTest exposing (..)
import GameLogicTests
import Cells.ModelsTests
import Cells.UpdateTests
import UtilsTests

tests : Test
tests =
  suite "All tests"
  [ GameLogicTests.tests
  , Cells.ModelsTests.tests
  , Cells.UpdateTests.tests
  , UtilsTests.tests
  ]

main : Program Never
main = runSuite tests
