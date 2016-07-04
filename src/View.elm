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
  div []
  [
    h1 [ class "title" ] [text "Tic Tac Toe"],
    statusView model,
    boardView model
  ]

statusView : Model -> Html Msg
statusView model =
  let render txt =
    div [ class "h3 status" ] [text txt] in
  case model.gameState of
    InProgress currentTurn ->
      render ("Player " ++ (playerText currentTurn) ++ "'s turn")
    Finished ->
      render "Finished"


boardView : Model -> Html Msg
boardView model =
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
