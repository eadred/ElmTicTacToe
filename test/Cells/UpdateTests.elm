module Cells.UpdateTests exposing (tests)

import ElmTest exposing (..)
import Cells.Models exposing (..)
import Cells.Messages exposing (..)
import Cells.Update exposing (..)

handleBeginTurn : Test
handleBeginTurn =
  let model = {status = Empty} in
  test
    "beginTurn message should not change model"
    (assertEqual model (cellUpdate BeginTurn model))

handleEndTurn : Test
handleEndTurn =
  let player = X
      initModel = {status = Empty}
      expected = {status = Played player} in
  test
    "endTurn message should set the cell to Played state"
    (assertEqual expected (cellUpdate (EndTurn player) initModel))

tests : Test
tests =
  suite "Cells.Update"
  [ handleBeginTurn
  , handleEndTurn
  ]
