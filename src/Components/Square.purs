module Components.Square where

import Prelude
import Data.Foldable (fold)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import React.Basic (Component, JSX, createComponent, make)
import React.Basic.DOM as R
import React.Basic.Events (handler_)

type Props
  = { value :: Maybe String
    , onClick :: Effect Unit
    }

component :: Component Unit
component = createComponent "square"

square :: Props -> JSX
square props = make component { initialState, render } unit
  where
  initialState =
    { value: Nothing
    }

  render self =
    R.button
      { className: "square"
      , children:
          [ R.text $ fold props.value
          ]
      , onClick: handler_ props.onClick
      }
