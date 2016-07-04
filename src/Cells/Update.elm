module Cells.Update exposing (..)

import Cells.Models exposing (..)
import Cells.Messages exposing (..)

cellUpdate : CellMsg -> CellModel -> CellModel
cellUpdate mes curMod =
  case mes of
    EndTurn player -> { curMod | status = Played player }
    BeginTurn -> curMod
