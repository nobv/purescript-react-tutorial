module Components.Board where

import Prelude
import Components.Square as Square
import Data.Array ((!!), (..))
import Data.Array as Array
import Data.Foldable (fold)
import Data.Maybe (Maybe(..), isJust)
import Effect (Effect)
import React.Basic (Component, JSX, createComponent, make)
import React.Basic.DOM as R
import Types.Turn (Player(..))

component :: Component Unit
component = createComponent "board"

board :: JSX
board = make component { initialState, render } unit
  where
  initialState ::
    { squares :: Array (Maybe Player)
    , player :: Player
    }
  initialState =
    { squares: (\_ -> Nothing) <$> 0 .. 8
    , player: First
    }

  render self =
    R.div
      { children:
          [ R.div
              { className: "status"
              , children:
                  [ R.text case caluculateWinner of
                      Nothing -> "Next player: " <> show self.state.player
                      Just winner -> "Winner: " <> show winner
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
          { squares = fold $ Array.updateAt index (pure state.player) state.squares
          , player = not state.player
          }
      mempty

    caluculateWinner :: Maybe Player
    caluculateWinner =
      let
        lines =
          [ [ 0, 1, 2 ]
          , [ 3, 4, 5 ]
          , [ 6, 7, 8 ]
          , [ 0, 3, 6 ]
          , [ 1, 4, 7 ]
          , [ 2, 5, 8 ]
          , [ 0, 4, 8 ]
          , [ 2, 4, 6 ]
          ]
      in
        fold $ lines
          <#> ( \line -> case line !! 0, line !! 1, line !! 2 of
                Just a, Just b, Just c ->
                  let
                    sa = join $ self.state.squares !! a

                    sb = join $ self.state.squares !! b

                    sc = join $ self.state.squares !! c
                  in
                    if (isJust sa && sa == sb && sa == sc) then sa else Nothing
                _, _, _ -> Nothing
            )
