module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (action)
import Html.Events exposing (onClick)
import Process
import Task



-- MAIN


main : Program () Model Msg
main =
    Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
    Int


init : Model
init =
    0



-- UPDATE


type Msg
    = Increment
    | IncrementByTen
    | Decrement
    | Reset


subtract : Int -> Int -> Int
subtract x y =
    y - x


subtractOne : Int -> Int
subtractOne =
    subtract 1


add : Int -> Int -> Int
add x y =
    x + y


addOne : Int -> Int
addOne =
    add 1


addTen : Int -> Int
addTen =
    add 10


isEven : Int -> Bool
isEven x =
    if modBy 2 x == 0 then
        True

    else
        False


evenOrOdd : Int -> String
evenOrOdd x =
    if isEven x then
        "Even"

    else
        "Odd"



-- recursion


countDownFrom10 : Int -> Int
countDownFrom10 n =
    case n of
        0 ->
            0

        _ ->
            Process.sleep 1000 |> (always <| (subtractOne n |> countDownFrom10))


hit10 : Int -> Int
hit10 n =
    if n == 10 then
        countDownFrom10 n

    else
        n


update : Msg -> Model -> Model
update msg model =
    case msg of
        Increment ->
            addOne model |> hit10

        IncrementByTen ->
            addTen model

        Decrement ->
            subtractOne model |> hit10

        Reset ->
            0



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ actionButton onClick Decrement "-"
        , div [] [ text (String.fromInt model) ]
        , actionButton onClick Increment "+"
        , actionButton onClick IncrementByTen "+10"
        , actionButton onClick Reset "Reset"
        , div [] [ text (evenOrOdd model) ]
        ]


actionButton : (Msg -> Html.Attribute Msg) -> Msg -> String -> Html Msg
actionButton action toMsg texts =
    button [ action toMsg ] [ text texts ]
