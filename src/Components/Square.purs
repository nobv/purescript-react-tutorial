module Components.Square where

import Prelude
import Data.Maybe (Maybe(..))
import Effect (Effect)
import React.Basic (Component, JSX, createComponent, makeStateless)
import React.Basic.DOM as R
import React.Basic.Events (handler_)
import Types.Turn (Player)

type Props
  = { value :: Maybe Player
    , onClick :: Effect Unit
    }

component :: Component Props
component = createComponent "square"

square :: Props -> JSX
square =
  makeStateless component \props ->
    R.button
      { className: "square"
      , children:
          [ R.text case props.value of
              Nothing -> ""
              Just value -> show value
          ]
      , onClick: handler_ props.onClick
      }
