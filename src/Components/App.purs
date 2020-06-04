module Components.App where

import Prelude
import Components.Board as Board
import React.Basic (Component, JSX, createComponent, makeStateless)
import React.Basic.DOM as R

component :: Component Unit
component = createComponent "app"

app :: JSX
app =
  unit
    # makeStateless component \_ ->
        R.div
          { className: "game"
          , children:
              [ R.div
                  { className: "game-board"
                  , children:
                      [ Board.board
                      ]
                  }
              , R.div
                  { className: "game-info"
                  , children:
                      [ R.div {}
                      , R.ol {}
                      ]
                  }
              ]
          }
