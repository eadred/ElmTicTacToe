module Messages exposing (..)

import Cells.Messages exposing (..)

type Msg
  = CellMsg Int Int CellMsg
