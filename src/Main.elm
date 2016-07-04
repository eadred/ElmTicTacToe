
module Main exposing (..)

import Html.App
import Cells.Models exposing (..)
import Models exposing (..)
import Messages exposing (..)
import Update exposing (..)
import View exposing (..)

init : (Model, Cmd Msg)
init =
  ( {
      cells = List.repeat 3 (List.repeat 3 initEmpty)
    , gameState = InProgress X
    }
  , Cmd.none
  )


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
