module Types.Turn where

import Prelude
import Data.HeytingAlgebra (ff)

data Turn
  = First
  | Second

derive instance eqTurn :: Eq Turn

instance showTurn :: Show Turn where
  show First = "X"
  show Second = "O"

instance heytingAlgebraTurn :: HeytingAlgebra Turn where
  ff = Second
  tt = First
  implies Second _ = First
  implies First x = x
  conj First x = x
  conj x First = x
  conj Second Second = Second
  disj First _ = First
  disj _ First = First
  disj Second Second = Second
  not First = ff
  not Second = First
