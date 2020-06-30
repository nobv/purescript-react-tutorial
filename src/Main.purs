module Main where

import Prelude
import Components.Game (game)
import Data.Maybe (Maybe(..))
import Effect (Effect)
import Effect.Exception (throw)
import React.Basic.DOM (render)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML (window)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)

main :: Effect Unit
main = do
  root <- getElementById "container" =<< (map toNonElementParentNode $ document =<< window)
  case root of
    Nothing -> throw "Container element not found"
    Just r -> render game r
