{-# LANGUAGE DeriveGeneric #-}

module Reservation (
               Request(..)
             , makeReservation
             ) where

import Data.Aeson
import GHC.Generics
import qualified Data.ByteString.Lazy.Char8 as B8

data Request = Request {
               train_id :: String
             , seats :: [String]
             , booking_reference :: String
             } deriving (Show, Generic)

instance FromJSON Request
instance ToJSON Request

makeReservation :: String -> [String] -> String -> B8.ByteString
makeReservation t s r = encode $ Request t s r
