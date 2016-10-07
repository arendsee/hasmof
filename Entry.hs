module Entry
(
      Entry(..)
    , etrans
    , eread
    , eshow
    , ewrite
    , readFasta
    , e2q
) where

import Data.List.Split
import Header
import Sequence

data Entry = Entry Header Sequence

eread :: String -> Entry
eread s = Entry header sequence where
    ss = lines s
    header   = (hread . concat . take 1) ss
    sequence = (qread . concat . drop 1) ss

eshow :: Entry -> String
eshow (Entry d s)  = (hshow d) ++ "\n" ++ (qshow s)

etrans :: (Header -> Header) -> (Sequence -> Sequence) -> Entry -> Entry
etrans f g (Entry h q) = Entry (f h) (g q)

ewrite :: (Header -> String) -> (Sequence -> String) -> Entry -> String
ewrite f g (Entry h q) = (f h) ++ "\n" ++ (g q) ++ "\n"

e2q :: (Sequence -> a) -> Entry -> a
e2q f (Entry _ s) = f s

readFasta :: String -> [Entry]
readFasta [] = []
readFasta xs = (map eread . splitRecords) xs where
    -- This function is not quite correct, entries should be split only if '>' is
    -- at the beginning of the line. It is perfectly legal inside a header.
    splitRecords :: String -> [String]
    splitRecords [] = []
    splitRecords s = (drop 1 . splitOn ">") s
