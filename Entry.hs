module Entry
(
    Entry(..)
    , Header(..)
    , Sequence(..)
    , readFasta
    , write
) where

import Data.List.Split

data Header = Header String String deriving Show

data Sequence = Sequence String | AA String | DNA String | RNA String deriving Show

data Entry = Entry Header Sequence deriving Show

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


writeEntry :: (Header -> String) -> (Sequence -> String) -> Entry -> String
writeEntry f g (Entry h q) = f h ++ "\n" ++ g q

-- most simple write functions
class Write a where
    write :: a -> String

instance Write Header where
    write (Header i d) = ">" ++ i ++ " " ++ d

instance Write Sequence where
    write (Sequence s) = wrap 60 s

instance Write Entry where
    write (Entry d s)  = (write d) ++ "\n" ++ (write s)

-- header write alternatives
write_header_clean :: Header -> String
write_header_clean (Header i _) = ">" ++ i

-- sequence write alternatives
write_seq_wrap :: Int -> Sequence -> String
write_seq_wrap i (Sequence s) = wrap i s

write_seq_reverse :: Sequence -> String
write_seq_reverse (Sequence s) = reverse s


wrap :: Int -> String -> String
wrap _ [] = []
wrap 0 s  = s
wrap n s  = take n s ++ "\n" ++ wrap n (drop n s)


readFasta :: String -> [Entry]
readFasta [] = []
readFasta xs = (map parse . splitRecords) xs where
    -- This function is not quite correct, entries should be split only if '>' is
    -- at the beginning of the line. It is perfectly legal inside a header.
    splitRecords :: String -> [String]
    splitRecords [] = []
    splitRecords s = (drop 1 . splitOn ">") s
