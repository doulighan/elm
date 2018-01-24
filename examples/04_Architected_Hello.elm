module ArchitectedHello exposing (..)

import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (onClick)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Model =
    { text : String
    , size : Int
    }


model : Model
model =
    Model "Hello World" 1


type Msg
    = AddExcl
    | RemExcl
    | SizeUp
    | SizeDown


update : Msg -> Model -> Model
update msg model =
    case msg of
        AddExcl ->
            { model | text = model.text ++ "!" }

        RemExcl ->
            { model | text = removeExclamation model.text }

        SizeUp ->
            { model | size = model.size + 1 }

        SizeDown ->
            { model | size = shrinkSize model.size }


removeExclamation : String -> String
removeExclamation string =
    if String.endsWith "!" string then
        String.dropRight 1 string
    else
        string


shrinkSize : Int -> Int
shrinkSize size =
    if size <= 1 then
        size
    else
        size - 1


myStyle : Int -> Attribute msg
myStyle size =
    style
        [ ( "fontSize", toString size ++ "em" )
        , ( "color", "teal" )
        ]


view : Model -> Html Msg
view model =
    div []
        [ div [ myStyle model.size ] [ text model.text ]
        , button [ onClick AddExcl ] [ text "!!" ]
        , button [ onClick RemExcl ] [ text "REM" ]
        , button [ onClick SizeUp ] [ text "++" ]
        , button [ onClick SizeDown ] [ text "--" ]
        ]
