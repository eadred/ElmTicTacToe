module Cells.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Cells.Models exposing (..)
import Cells.Messages exposing (..)

cellView : CellModel -> Html CellMsg
cellView model =
  case model.status of
    Empty -> renderCell ""
    O -> renderCell "O"
    X -> renderCell "X"

renderCell : String -> Html CellMsg
renderCell content =
  div
  [class "col-xs-1"]
  [ button [class "btn cell"] [text content] ]
