module Entry
(
      Entry(..)
    , tEntry
    , ewrite
    , readFasta
    , e2q
) where

import Data.List.Split
import Header
import Sequence
import Classes

data Entry = Entry Header Sequence deriving (Eq, Read, Show)

instance Ord Entry where
    (<=) (Entry h1 _) (Entry h2 _)
        | h1 <= h2  = True
        | otherwise = False

instance FRead Entry where
    fread s = Entry header sequence where
        ss = lines s
        header   = (fread . concat . take 1) ss
        sequence = (fread . concat . drop 1) ss

instance FShow Entry where
    fshow (Entry d s) = (fshow d) ++ "\n" ++ (fshow s)

-- A transform constructor that takes a function on each field
tEntry :: (Header -> Header) -> (Sequence -> Sequence) -> Entry -> Entry
tEntry f g (Entry h q) = Entry (f h) (g q)

-- instance Applicative Entry where
--     pure = \h q -> Entry h q
--     (<*>) = [f



ewrite :: (Header -> String) -> (Sequence -> String) -> Entry -> String
ewrite f g (Entry h q) = (f h) ++ "\n" ++ (g q) ++ "\n"

e2q :: (Sequence -> a) -> Entry -> a
e2q f (Entry _ s) = f s

readFasta :: String -> [Entry]
readFasta [] = []
readFasta xs = (map fread . splitRecords) xs where
    -- This function is not quite correct, entries should be split only if '>' is
    -- at the beginning of the line. It is perfectly legal inside a header.
    splitRecords :: String -> [String]
    splitRecords [] = []
    splitRecords s = (drop 1 . splitOn ">") s
