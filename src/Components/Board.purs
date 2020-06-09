module Components.Board where

import Components.Sqaere as Square
import Data.Array as Array
import Data.Functor ((<#>))
import Prelude (Unit, show, unit, (#))
import React.Basic (Component, JSX, createComponent, makeStateless)
import React.Basic.DOM as R

component :: Component Unit
component = createComponent "board"

lenderSquare :: Int -> Int -> Array JSX
lenderSquare start end = Array.range start end <#> (\i -> Square.square { value: show i })

board :: JSX
board =
  unit
    # makeStateless component \_ ->
        R.div
          { children:
              [ R.div
                  { className: "status"
                  , children:
                      [ R.text "Next player: X"
                      ]
                  }
              , R.div
                  { className: "board-row"
                  , children: lenderSquare 0 2
                  }
              , R.div
                  { className: "board-row"
                  , children: lenderSquare 3 5
                  }
              , R.div
                  { className: "board-row"
                  , children: lenderSquare 6 8
                  }
              ]
          }
