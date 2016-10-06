module Entry
(
    Entry(..)
    , Header(..)
    , Sequence(..)
    , readFasta
    , write
    , etrans
    , qtrans
    , htrans
    , wrap
    , blank
) where

import Data.List.Split

data Header = Header String String deriving Show

data Sequence = Sequence String | AA String | DNA String | RNA String deriving Show

data Entry = Entry Header Sequence deriving Show

-- String to Object -------------------------------------------------
class Parse a where
    parse :: String -> a

instance Parse Entry where
    parse s = Entry header sequence where
        ss = lines s
        header   = (parse . concat . take 1) ss
        sequence = (parse . concat . drop 1) ss

instance Parse Header where
    parse s = Header name desc where
        w = words s
        name = (unwords . take 1) w
        desc = (unwords . drop 1) w

instance Parse Sequence where
     parse s = Sequence s


-- Object to String -------------------------------------------------
class Write a where
    write :: a -> String

instance Write Header where
    write (Header i "") = ">" ++ i
    write (Header i d)  = ">" ++ i ++ " " ++ d

instance Write Sequence where
    write (Sequence s) = wrap 60 s

instance Write Entry where
    write (Entry d s)  = (write d) ++ "\n" ++ (write s)


-- Transform functions ----------------------------------------------
etrans :: (Header -> Header) -> (Sequence -> Sequence) -> Entry -> Entry
etrans f g (Entry h q) = Entry (f h) (g q)

qtrans :: (String -> String) -> Sequence -> Sequence
qtrans f (Sequence s) = Sequence (f s)

htrans :: (String -> String) -> (String -> String) -> Header -> Header
htrans f g (Header i d) = Header (f i) (g d)


-- utilities --------------------------------------------------------
wrap :: Int -> String -> String
wrap _ [] = []
wrap 0 s  = s
wrap n s  = take n s ++ "\n" ++ wrap n (drop n s)

blank :: String -> String
blank _ = ""

readFasta :: String -> [Entry]
readFasta [] = []
readFasta xs = (map parse . splitRecords) xs where
    -- This function is not quite correct, entries should be split only if '>' is
    -- at the beginning of the line. It is perfectly legal inside a header.
    splitRecords :: String -> [String]
    splitRecords [] = []
    splitRecords s = (drop 1 . splitOn ">") s
