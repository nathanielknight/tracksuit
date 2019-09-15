module Main exposing (main)

import Browser
import Html exposing (input, table, tbody, td, th, thead, tr)
import Html.Attributes exposing (checked, class, type_)
import Html.Events exposing (onClick)
import Set


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }


init : Model
init =
    Set.empty


type Suit
    = Club
    | Diamond
    | Heart
    | Spade


type Rank
    = Ace
    | Two
    | Three
    | Four
    | Five
    | Six
    | Seven
    | Eight
    | Nine
    | Ten
    | Jack
    | Queen
    | King


type Card
    = Card Rank Suit


ranks =
    [ Ace
    , Two
    , Three
    , Four
    , Five
    , Six
    , Seven
    , Eight
    , Nine
    , Ten
    , Jack
    , Queen
    , King
    ]


suits =
    [ Club
    , Diamond
    , Heart
    , Spade
    ]


type alias Model =
    Set.Set ( Int, Int )


type Msg
    = Count Card
    | UnCount Card
    | Reset


update : Msg -> Model -> Model
update msg model =
    case msg of
        Count c ->
            count model c

        UnCount c ->
            uncount model c

        Reset ->
            Set.empty


view : Model -> Html.Html Msg
view m =
    table []
        [ thead [] headrow
        , tbody [] <| List.map (rankRow m) ranks
        ]


cardCell : Model -> Card -> Html.Html Msg
cardCell m c =
    let
        (Card rank suit) =
            c

        cardCounted =
            counted m c

        attrs =
            [ if cardCounted then
                onClick (UnCount c)

              else
                onClick (Count c)
            , suitClass suit
            , type_ "checkbox"
            , checked cardCounted
            ]

        content =
            [ Html.text
                (if cardCounted then
                    " "

                 else
                    "●"
                )
            ]
    in
    td attrs content


rankRow : Model -> Rank -> Html.Html Msg
rankRow m r =
    tr [] <| [ th [] [ Html.text <| rankString r ] ] ++ List.map (\s -> cardCell m (Card r s)) suits


headrow =
    [ th [] [] ] ++ List.map (\s -> th [] [ Html.text <| suitString s ]) suits


counted : Model -> Card -> Bool
counted m c =
    Set.member (cardInts c) m


count : Model -> Card -> Model
count m c =
    Set.insert (cardInts c) m


uncount : Model -> Card -> Model
uncount m c =
    Set.remove (cardInts c) m


rankString : Rank -> String
rankString r =
    case r of
        Ace ->
            "A"

        Two ->
            "2"

        Three ->
            "3"

        Four ->
            "4"

        Five ->
            "5"

        Six ->
            "6"

        Seven ->
            "7"

        Eight ->
            "8"

        Nine ->
            "9"

        Ten ->
            "10"

        Jack ->
            "J"

        Queen ->
            "Q"

        King ->
            "K"


suitString : Suit -> String
suitString s =
    case s of
        Club ->
            "♣"

        Diamond ->
            "♦"

        Heart ->
            "♥"

        Spade ->
            "♠"


rankInt : Rank -> Int
rankInt r =
    case r of
        Ace ->
            1

        Two ->
            2

        Three ->
            3

        Four ->
            4

        Five ->
            5

        Six ->
            6

        Seven ->
            7

        Eight ->
            8

        Nine ->
            9

        Ten ->
            10

        Jack ->
            11

        Queen ->
            12

        King ->
            13


suitInt : Suit -> Int
suitInt s =
    case s of
        Club ->
            1

        Diamond ->
            2

        Heart ->
            3

        Spade ->
            4


cardInts : Card -> ( Int, Int )
cardInts (Card r s) =
    ( rankInt r, suitInt s )


suitClass : Suit -> Html.Attribute Msg
suitClass s =
    let
        cls =
            case s of
                Club ->
                    "club"

                Diamond ->
                    "diamond"

                Heart ->
                    "heart"

                Spade ->
                    "spade"
    in
    class cls
