module Components.Board where

import Prelude
import React.Basic
import Components.Squere as Squere
import Data.Array as Array
import React.Basic.DOM as R

component :: Component Unit
component = createComponent "board"

lenderSquere :: Array JSX
lenderSquere = (\_ -> Squere.squere) <$> Array.range 0 2

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
                  , children: lenderSquere
                  }
              , R.div
                  { className: "board-row"
                  , children: lenderSquere
                  }
              , R.div
                  { className: "board-row"
                  , children: lenderSquere
                  }
              ]
          }
