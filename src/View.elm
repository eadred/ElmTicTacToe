module View exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Models exposing (..)
import Messages exposing (..)
import Cells.Models exposing (..)
import Cells.View exposing (..)

view : Model -> Html Msg
view model =
  div
  []
  (List.map renderRow model.cells)

renderRow : List CellModel -> Html Msg
renderRow cells =
  div
  []
  (List.map (cellView >> Html.App.map (always NoOp)) cells)
