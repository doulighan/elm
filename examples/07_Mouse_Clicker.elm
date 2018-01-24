module MouseClicker exposing (..)

import Html exposing (Html, div, text, program)
import Mouse
import Keyboard
import Char


main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { x : Int
    , y : Int
    , keyPressed : Keyboard.KeyCode
    }


init : ( Model, Cmd Msg )
init =
    ( Model 0 0 0, Cmd.none )


type Msg
    = MouseMessage Mouse.Position
    | KeyboardMessage Keyboard.KeyCode


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MouseMessage position ->
            ( { model | x = position.x, y = position.y }, Cmd.none )

        KeyboardMessage code ->
            ( { model | keyPressed = code }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Mouse.moves MouseMessage
        , Keyboard.presses KeyboardMessage
        ]


view : Model -> Html Msg
view model =
    div []
        [ text ("PosX: " ++ toString model.x ++ " PosY: " ++ toString model.y)
        , div [] [ text ("You pressed: " ++ (toString (Char.fromCode model.keyPressed))) ]
        ]
