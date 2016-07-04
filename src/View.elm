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
  [class "container"]
  (List.indexedMap renderRow model.cells)

renderRow : Int -> List CellModel -> Html Msg
renderRow rowIndex cells =
  div
  [class "row"]
  (List.indexedMap (renderRowCell rowIndex) cells)

renderRowCell : Int -> Int -> CellModel -> Html Msg
renderRowCell rowIndex colIndex cell =
  cell |> cellView |> (Html.App.map (CellMsg rowIndex colIndex))
