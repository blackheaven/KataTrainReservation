{-# LANGUAGE DeriveGeneric #-}

module AgentRoom (
               findSeats
              , Seat(..)
             ) where

import Data.Aeson
import GHC.Generics
import Data.List (sortBy)

data Seat = Seat {
            denomination :: String
          , isReserved :: Bool
          } deriving (Show)

findSeats :: Int -> [Seat] -> [String]
findSeats n = take n . sortBy compare . map denomination . filter (not . isReserved)
