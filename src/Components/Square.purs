module Components.Squere where

import Prelude
import React.Basic
import React.Basic.DOM as R

component :: Component Unit
component = createComponent "squere"

squere :: JSX
squere =
  unit
    # makeStateless component \_ ->
        R.div_
          [ R.button { className: "squere" }
          ]
