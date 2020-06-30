module Components.Game where

import Prelude
import Components.Board as Board
import Data.Array (length, take, (!!))
import Data.Foldable (fold)
import Data.Maybe (Maybe(..), isJust)
import Effect (Effect)
import React.Basic (Component, JSX, createComponent, make)
import React.Basic.DOM as R
import Types.History (History)
import Types.History as History
import Types.Player (Player(..))
import Types.Square (Square)
import Types.Square as Square

component :: Component Unit
component = createComponent "game"

game :: JSX
game = make component { initialState, render } unit
  where
  initialState ::
    { history :: History
    , player :: Player
    , stepNumber :: Int
    }
  initialState =
    { history: History.range 0 8
    , player: First
    , stepNumber: 0
    }

  render self =
    R.div
      { className: "game"
      , children:
          [ R.div
              { className: "game-board"
              , children:
                  [ Board.board
                      { squares: _.squares $ History.last self.state.history
                      , onClick: handleClick
                      }
                  ]
              }
          , R.div
              { className: "game-info"
              , children:
                  [ R.div
                      { className: "status"
                      , children:
                          [ R.text case caluculateWinner $ _.squares $ History.last self.state.history of
                              Nothing -> "Next player: " <> show self.state.player
                              Just winner -> "Winner: " <> show winner
                          ]
                      }
                  , R.ol
                      { className: "moves"
                      , children:
                          []
                      }
                  ]
              }
          ]
      }
    where
    handleClick :: Int -> Effect Unit
    handleClick index =
      let
        history = take (self.state.stepNumber + 1) self.state.history

        current = History.last history

        squares = _.squares $ current
      in
        case caluculateWinner squares, squares !! index of
          Nothing, Just _ -> do
            self.setState \state ->
              state
                { history = History.insert { squares: Square.update index (self.state.player) current.squares } state.history
                , player = not state.player
                , stepNumber = length state.history
                }
          _, _ -> mempty

    caluculateWinner :: Array Square -> Maybe Player
    caluculateWinner squares =
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
                    sa = join $ squares !! a

                    sb = join $ squares !! b

                    sc = join $ squares !! c
                  in
                    if (isJust sa && sa == sb && sa == sc) then sa else Nothing
                _, _, _ -> Nothing
            )

    jumpTo :: Int -> Effect Unit
    jumpTo step =
      self.setState \state ->
        state
          { stepNumber = step
          , player = if (step `mod` 2) == 0 then Second else First
          }
