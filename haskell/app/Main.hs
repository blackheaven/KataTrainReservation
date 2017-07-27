-- {-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE DeriveGeneric #-}
module Main where

-- -- import           Json
-- -- import           Web.Scotty

-- -- main :: IO ()
-- -- main = scotty 8080 routes
-- import Control.Applicative
-- import Database.SQLite.Simple
-- import Database.SQLite.Simple.FromRow

-- data TestField = TestField Int String deriving (Show)

-- instance FromRow TestField where
--   fromRow = TestField <$> field <*> field

-- main :: IO ()
-- main = do
--   conn <- open ":memory:"
--   execute_ conn "CREATE TABLE test (id INTEGER PRIMARY KEY, str text);"
--   execute_ conn "INSERT INTO test (str) VALUES ('test string');"
--   execute conn "INSERT INTO test (str) VALUES (?)" (Only ("test string 2" :: String))
--   r <- query_ conn "SELECT * from test" :: IO [TestField]
--   mapM_ print r


import Data.Aeson
import GHC.Generics
import qualified Data.ByteString.Lazy as B
import qualified Data.ByteString.Lazy.Char8 as B8
import Network.HTTP.Conduit (simpleHttp)
import Data.Maybe (fromJust)
import Data.HashMap.Strict(HashMap, elems)
import System.Environment

import qualified Train as T
import qualified Reservation as R
import qualified AgentRoom as A

getSeats :: String -> IO T.Seats
getSeats t = fromJust . decode <$> simpleHttp ("http://localhost:8081/data_for_train/" ++ t)

getRef :: IO String
getRef = B8.unpack <$> simpleHttp "http://localhost:8082/booking_reference"

main :: IO ()
main = do
    [trainName, seatsNbStr] <- getArgs
    ref <- getRef
    train <- getSeats trainName
    let seatsNb = read seatsNbStr :: Int
    let properSeats = map (\s -> A.Seat (T.shortNameSeat s) (not $ null $ T.booking_reference s)) $ elems $ T.seats train
    let reservedSeats = A.findSeats seatsNb properSeats
    B8.putStrLn $ R.makeReservation trainName reservedSeats ref
