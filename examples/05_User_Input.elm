module UserInput exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Model =
    { text : String }


model : Model
model =
    { text = " " }


type Msg
    = Text String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Text txt ->
            { model | text = txt }


adjustSize : Model -> Attribute msg
adjustSize { text } =
    let
        ( size, color ) =
            if String.length text < 8 then
                ( "20em", "goldenrod" )
            else
                ( "10em", "plum" )
    in
        style
            [ ( "fontSize", size )
            , ( "color", color )
            ]


view : Model -> Html Msg
view model =
    div []
        [ input [ placeholder "Type text here", onInput Text ] []
        , div [ adjustSize model ] [ text model.text ]
        ]
