module Types.Square where

import Prelude
import Data.Array as Array
import Data.Foldable (fold)
import Data.Maybe (Maybe)
import Types.Player (Player)

type Square
  = Maybe Player

update :: Int -> Player -> Array Square -> Array Square
update i p s = fold $ Array.updateAt i (pure p) s
