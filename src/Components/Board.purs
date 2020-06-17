module Components.Board where

import Prelude
import Components.Square as Square
import Data.Array ((!!), (..))
import Data.Array as Array
import Data.Foldable (fold)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import React.Basic (Component, JSX, createComponent, make)
import React.Basic.DOM as R
import Types.Turn (Turn)
import Types.Turn as Turn

component :: Component Unit
component = createComponent "board"

board :: JSX
board = make component { initialState, render } unit
  where
  initialState ::
    { squares :: Array (Maybe String)
    , xIsNext :: Turn
    }
  initialState =
    { squares: (\_ -> Nothing) <$> 0 .. 8
    , xIsNext: Turn.First
    }

  render self =
    R.div
      { children:
          [ R.div
              { className: "status"
              , children:
                  [ R.text $ "Next player: " <> show self.state.xIsNext
                  ]
              }
          , R.div
              { className: "board-row"
              , children: render3Squares 0
              }
          , R.div
              { className: "board-row"
              , children: render3Squares 3
              }
          , R.div
              { className: "board-row"
              , children: render3Squares 6
              }
          ]
      }
    where
    render3Squares :: Int -> Array JSX
    render3Squares start =
      start .. (start + 2)
        <#> ( \i ->
              Square.square
                { value: fold $ self.state.squares !! i
                , onClick: handleClick i
                }
          )

    handleClick :: Int -> Effect Unit
    handleClick index = do
      self.setState \state ->
        state
          { squares = fold $ Array.updateAt index (pure $ show state.xIsNext) state.squares
          , xIsNext = not state.xIsNext
          }
      mempty
