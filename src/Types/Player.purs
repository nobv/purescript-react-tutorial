module Types.Player where

import Prelude
import Data.HeytingAlgebra (ff)

data Player
  = First
  | Second

derive instance eqPlayer :: Eq Player

derive instance ordPlayer :: Ord Player

instance showPlayer :: Show Player where
  show First = "X"
  show Second = "O"

instance heytingAlgebraPlayer :: HeytingAlgebra Player where
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

instance semigroupPlayer :: Semigroup Player where
  append First _ = First
  append Second _ = Second
