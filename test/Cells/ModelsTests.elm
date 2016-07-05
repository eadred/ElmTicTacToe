module Cells.ModelsTests exposing (tests)

import ElmTest exposing (..)
import Cells.Models exposing (..)

isEmptyTrue : Test
isEmptyTrue =
  test
    "isEmpty should be true when cell status is empty"
    (assertEqual True (isCellEmpty {status = Empty}))

isEmptyFalse : Test
isEmptyFalse =
  test
    "isEmpty should be false when cell status is non-empty"
    (assertEqual False (isCellEmpty {status = Played X}))

initEmptyT : Test
initEmptyT =
  test
    "initEmpty should create an empty cell"
    (assertEqual Empty initEmpty.status)

playerTextO : Test
playerTextO =
  test
    "Player text for O should be \"O\""
    (assertPlayerText "O" O)

playerTextX : Test
playerTextX =
  test
    "Player text for X should be \"X\""
    (assertPlayerText "X" X)

assertPlayerText : String -> Player -> Assertion
assertPlayerText expected player = assertEqual expected (playerText player)

tests : Test
tests =
  suite "Cells.Models"
  [ isEmptyTrue
  , isEmptyFalse
  , initEmptyT
  , playerTextX
  , playerTextO
  ]
