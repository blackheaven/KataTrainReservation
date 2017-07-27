{-# LANGUAGE OverloadedStrings #-}
module Json
    ( routes
    ) where

import           Web.Scotty
import           Data.Aeson (Value(..), object, (.=))

routes :: ScottyM ()
routes = do
  get "/" $ do
    text "hello"

  get "/some-json" $ do
    json $ object ["foo" .= Number 23, "bar" .= Number 42]

