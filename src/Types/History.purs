module Types.History where

import Prelude
import Data.Array as Array
import Data.Foldable (fold)
import Data.Maybe (Maybe(..))
import Types.Square (Square)

type History
  = Array { squares :: Array Square }

range :: Int -> Int -> History
range start end = [ { squares: start Array... end <#> (\_ -> Nothing) } ]

last :: History -> { squares :: Array Square }
last history = fold $ Array.last history

insert :: { squares :: Array Square } -> History -> History
insert n h = Array.insert n h
