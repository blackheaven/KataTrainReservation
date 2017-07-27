{-# LANGUAGE DeriveGeneric #-}

module Train (
               Seats(..)
             , Seat(..)
             , shortNameSeat
             ) where

import Data.Aeson
import GHC.Generics
import Data.HashMap.Strict

data Seats = Seats { seats :: HashMap String Seat } deriving (Show, Generic)

instance FromJSON Seats
instance ToJSON Seats

data Seat = Seat {
           coach :: String
         , seat_number :: String
         , booking_reference :: String
         } deriving (Show, Generic)

instance FromJSON Seat
instance ToJSON Seat

shortNameSeat :: Seat -> String
shortNameSeat seat = coach seat ++ seat_number seat
