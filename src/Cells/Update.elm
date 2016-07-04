module Cells.Update exposing (..)

import Cells.Models
import Cells.Messages

update : CellMsg -> CellModel -> (CellModel, Cmd CellMsg)
update mes curMod =
  case mes of
    SetCell newStatus -> {curMod | status = status }
