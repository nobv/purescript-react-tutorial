module Components.App where

import Prelude
import React.Basic (Component, JSX, createComponent, makeStateless)
import React.Basic.DOM as R

component :: Component Unit
component = createComponent "app"

app :: JSX
app =
  unit
    # makeStateless component \_ ->
        R.div_
          [ R.h1_ [ R.text "hello world" ]
          ]
