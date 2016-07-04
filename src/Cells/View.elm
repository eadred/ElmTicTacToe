module Cells.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Cells.Models exposing (..)
import Cells.Messages exposing (..)

cellView : CellModel -> Html CellMsg
cellView model =
  case model.status of
    Empty -> renderEmptyCell
    Played O -> renderFilledCell "cell-o" "O"
    Played X -> renderFilledCell "cell-x" "X"

renderEmptyCell : Html CellMsg
renderEmptyCell =
  div
  [class "col-xs-1"]
  [ button [class "btn cell cell-empty", onClick BeginTurn] [] ]

renderFilledCell : String -> String -> Html CellMsg
renderFilledCell cellClass content =
  div
  [class "col-xs-1"]
  [ div [class ("btn cell " ++ cellClass)] [text content] ]
