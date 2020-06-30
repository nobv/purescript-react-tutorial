module Components.Board where

import Prelude
import Components.Square as Square
import Data.Array ((!!), (..))
import Data.Foldable (fold)
import Data.Maybe (Maybe)
import Effect (Effect)
import React.Basic (Component, JSX, createComponent, makeStateless)
import React.Basic.DOM as R
import Types.Player (Player)

type Props
  = { squares :: Array (Maybe Player)
    , onClick :: Int -> Effect Unit
    }

component :: Component Props
component = createComponent "board"

board :: Props -> JSX
board =
  makeStateless component \props ->
    R.div
      { children:
          [ R.div
              { className: "board-row"
              , children: render3Squares props 0
              }
          , R.div
              { className: "board-row"
              , children: render3Squares props 3
              }
          , R.div
              { className: "board-row"
              , children: render3Squares props 6
              }
          ]
      }

render3Squares :: Props -> Int -> Array JSX
render3Squares props start =
  start .. (start + 2)
    <#> ( \i ->
          Square.square
            { value: fold $ props.squares !! i
            , onClick: props.onClick i
            }
      )
