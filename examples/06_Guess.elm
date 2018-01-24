module Guess exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)


main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Result =
    { text : String, isCorrect : Bool }


type alias Model =
    { word : String
    , guess : String
    , revealedWord : String
    , result : Result
    }


model : Model
model =
    Model "Cubert" "C" "C" { text = "", isCorrect = False }


type Msg
    = Answer String
    | Reveal
    | Check


revealLetter : Model -> String
revealLetter { word, revealedWord } =
    if word == revealedWord then
        revealedWord
    else
        String.slice 0 ((String.length revealedWord) + 1) word


checkResult : Model -> Result
checkResult { word, guess, result } =
    if guess == word then
        { result | text = "Correct!", isCorrect = True }
    else
        { result | text = "Incorrect.", isCorrect = False }


model : Msg -> Model -> Model
model msg = 
  type alias {word : cool}


update : Msg -> Model -> Model
update msg model =
    case msg of
        Answer txt ->
            { model | guess = txt }

        Reveal ->
            { model | revealedWord = revealLetter model }

        Check ->
            { model | result = checkResult model }


checkStyle : Result -> Attribute msg
checkStyle { isCorrect } =
    let
        ( color, size ) =
            if isCorrect then
                ( "green", "8em" )
            else
                ( "red", "5em" )
    in
        style [ ( "color", color ), ( "fontSize", size ) ]


view : Model -> Html Msg
view model =
    div []
        [ h2 [] [ text ("I'm thinking of a word that starts with " ++ model.revealedWord) ]
        , input [ placeholder "Type your guess", onInput Answer ] []
        , button [ onClick Reveal ] [ text "Hint?" ]
        , button [ onClick Check ] [ text "Check" ]
        , div [] [ div [ checkStyle model.result ] [ text model.result.text ] ]
        ]
