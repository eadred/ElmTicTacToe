
module Main exposing (..)

import Html exposing (..)
import Html.App
import Html.Attributes exposing (..)
import Cells.Models exposing (..)
import Cells.View exposing (..)


-- MODEL


type alias Model =
  {
  cells : List (List CellModel)
  }


init : (Model, Cmd Msg)
init =
  ( {
      cells =
        [
          [ {status = X},{status = O},{status = Empty} ],
          [ {status = O},{status = Empty},{status = X} ],
          [ {status = Empty},{status = X},{status = O} ]
        ]
    }
  , Cmd.none
  )


-- UPDATE


type Msg
  = NoOp


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NoOp ->
      (model, Cmd.none)


-- VIEW


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


-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none


main : Program Never
main =
  Html.App.program
    { init = init
    , update = update
    , view = view
    , subscriptions = subscriptions
    }
