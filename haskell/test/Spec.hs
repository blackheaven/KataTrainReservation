{-# LANGUAGE OverloadedStrings, QuasiQuotes #-}
import           Json
import           Web.Scotty (scottyApp)

import           Test.Hspec
import           Test.Hspec.Wai
import           Test.Hspec.Wai.JSON

main :: IO ()
main = hspec spec


spec :: Spec
spec = with (scottyApp routes) $ do
  describe "GET /" $ do
    it "responds with 200" $ do
      get "/" `shouldRespondWith` 200

    it "responds with 'hello'" $ do
      get "/" `shouldRespondWith` "hello"

    it "responds with 200 / 'hello'" $ do
      get "/" `shouldRespondWith` "hello" {matchStatus = 200}

    it "has 'Content-Type: text/plain; charset=utf-8'" $ do
      get "/" `shouldRespondWith` 200 {matchHeaders = ["Content-Type" <:> "text/plain; charset=utf-8"]}

  describe "GET /some-json" $ do
    it "responds with some JSON" $ do
      get "/some-json" `shouldRespondWith` [json|{foo: 23, bar: 42}|] {matchHeaders = ["Content-Type" <:> "application/json; charset=utf-8"]}
