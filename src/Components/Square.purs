module Components.Square where

import Prelude
import Data.Foldable (fold)
import Data.Maybe (Maybe)
import Effect (Effect)
import React.Basic (Component, JSX, createComponent, makeStateless)
import React.Basic.DOM as R
import React.Basic.Events (handler_)

type Props
  = { value :: Maybe String
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
          [ R.text $ fold props.value
          ]
      , onClick: handler_ props.onClick
      }
