module Main exposing (main)

import Html
import Browser


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }

init :  Model
init = 1


type alias Model = Int

type Msg = NoOp

update : Msg -> Model -> Model
update _  x = x


view : Model -> Html.Html Msg
view m = Html.p [] [Html.text "Hi there"]
