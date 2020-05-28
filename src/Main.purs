module Main where

import Prelude
import Effect (Effect)
import Web.DOM.NonElementParentNode (getElementById)
import Web.HTML.HTMLDocument (toNonElementParentNode)
import Web.HTML.Window (document)
import Web.HTML (window)
import Data.Maybe (Maybe(..))
import Effect.Exception (throw)
import React.Basic.DOM (render)
import Components.App (app)

main :: Effect Unit
main = do
  root <- getElementById "root" =<< (map toNonElementParentNode $ document =<< window)
  case root of
    Nothing -> throw "Root element not found"
    Just r -> render app r
