module Cells.UpdateTests exposing (tests)

import ElmTest exposing (..)
import Check as C
import Check.Producer as P
import Check.Test as T
import Utils as U
import Cells.Models exposing (..)
import Cells.Messages exposing (..)
import Cells.Update exposing (..)

playerProducer : P.Producer Player
playerProducer = P.bool |> P.map (\b -> if b then X else O)

cellProducer : P.Producer CellModel
cellProducer =
  U.oneOf [U.const Empty, playerProducer |> P.map Played] |> P.map CellModel

handleBeginTurn : C.Claim
handleBeginTurn =
  C.claim "beginTurn message should not change model"
    `C.that` (\model -> cellUpdate BeginTurn model)
    `C.is` identity
    `C.for` cellProducer

handleEndTurn : C.Claim
handleEndTurn =
  C.claim "endTurn message should set the cell to Played state"
    `C.that` (\(initModel, player) -> cellUpdate (EndTurn player) initModel)
    `C.is` (\(_, player) -> {status = Played player})
    `C.for` (P.tuple (cellProducer, playerProducer))

claims : C.Claim
claims =
  C.suite
    "Cells.Update"
    [ handleBeginTurn
    , handleEndTurn
    ]

tests : Test
tests = claims |> C.quickCheck |> T.evidenceToTest
