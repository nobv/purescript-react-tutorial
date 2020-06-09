module Components.Sqaere where

import Prelude (Unit, unit, (#))
import React.Basic (Component, JSX, createComponent, makeStateless)
import React.Basic.DOM as R

type Props
  = { value :: String }

component :: Component Unit
component = createComponent "square"

square :: Props -> JSX
square props =
  unit
    # makeStateless component \_ ->
        R.button
          { className: "square"
          , children:
              [ R.text props.value
              ]
          }
