module GameLogicTests exposing (tests)

import ElmTest exposing (..)
import GameLogic exposing (..)
import Cells.Models exposing (..)

tests : Test
tests =
  suite "GameLogic"
  [ diagUpIsWinner
  , diagDownIsWinner
  , fullRowOs
  , fullRowMixedPlayers
  , fullCol
  , fullThirdRow
  , fullSecondRow
  , threeNonWinningPlays
  , fullRow
  , singlePlayThirdCol
  , singlePlaySecondCol
  , singlePlaySecondRow
  , singlePlay
  , noPlays
  ]

noPlays : Test
noPlays =
  test
    "No plays shouldn't have a winner"
    (assertNoWinner [])

singlePlay : Test
singlePlay =
  test
    "Single play shouldn't have a winner"
    (assertNoWinner [makePlay X 0 0])

singlePlaySecondRow : Test
singlePlaySecondRow =
  test
    "Single play on the second row shouldn't have a winner"
    (assertNoWinner [makePlay X 1 0])

singlePlaySecondCol : Test
singlePlaySecondCol =
  test
    "Single play on the second column shouldn't have a winner"
    (assertNoWinner [makePlay X 0 1])

singlePlayThirdCol : Test
singlePlayThirdCol =
  test
    "Single play on the third column shouldn't have a winner"
    (assertNoWinner [makePlay X 0 2])

fullRow : Test
fullRow =
  let game = [makePlay X 0 0, makePlay X 0 1, makePlay X 0 2] in
  test
    "Full row should be a winner"
    (assertWinner game X)

threeNonWinningPlays : Test
threeNonWinningPlays =
  let game = [makePlay X 0 0, makePlay X 0 1, makePlay X 1 0] in
  test
    "Three plays not in line should not be a winner"
    (assertNoWinner game)

fullSecondRow : Test
fullSecondRow =
  let game = [makePlay X 1 0, makePlay X 1 1, makePlay X 1 2] in
  test
    "Full second row should be a winner"
    (assertWinner game X)

fullThirdRow : Test
fullThirdRow =
  let game = [makePlay X 2 0, makePlay X 2 1, makePlay X 2 2] in
  test
    "Full third row should be a winner"
    (assertWinner game X)

fullCol : Test
fullCol =
  let game = [makePlay X 0 0, makePlay X 1 0, makePlay X 2 0] in
  test
    "Full column should be a winner"
    (assertWinner game X)

fullRowMixedPlayers : Test
fullRowMixedPlayers =
  let game = [makePlay X 0 0, makePlay O 0 1, makePlay X 0 2] in
  test
    "Full row with mixed players should not have a winner"
    (assertNoWinner game)

fullRowOs : Test
fullRowOs =
  let game = [makePlay O 0 0, makePlay O 0 1, makePlay O 0 2] in
  test
    "Full row of Os should be a win for O"
    (assertWinner game O)

diagDownIsWinner : Test
diagDownIsWinner =
  let game = [makePlay O 0 0, makePlay O 1 1, makePlay O 2 2] in
  test
    "Downward diagonal of Os should be a win for O"
    (assertWinner game O)

diagUpIsWinner : Test
diagUpIsWinner =
  let game = [makePlay O 0 2, makePlay O 1 1, makePlay O 2 0] in
  test
    "Upward diagonal of Os should be a win for O"
    (assertWinner game O)

makePlay : Player -> Int -> Int -> Play
makePlay p row col = {player = p, row = row, col = col}

assertNoWinner : List Play -> Assertion
assertNoWinner game = assertEqual (checkWinner game) Nothing

assertWinner : List Play -> Player -> Assertion
assertWinner game player = assertEqual (checkWinner game) (Just player)
