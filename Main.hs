{-# LANGUAGE TypeFamilies #-}

import System.Environment (getArgs)
import Data.List (sort)
import Util
import Entry
import Header
import Sequence
import Classes


-- Borrowed from Real World Haskell ---------------------------------
interactWith function inputFile outputFile = do
  input <- readFile inputFile
  writeFile outputFile (function input)

main = mainWith $ make_function
  where mainWith function = do
          args <- getArgs
          case args of
            [cmd] -> interactWith (function cmd) "/dev/stdin" "/dev/stdout"
            _ -> putStrLn "error: exactly 1 arguments needed"
---------------------------------------------------------------------

cmd :: ( String  -> [Entry] ) ->    -- d divide          1 -> m
       ( [Entry] -> [Entry] ) ->    -- f filter          m -> n
       ( Entry   -> a       ) ->    -- m map transform   n -> n
       ( [a]     -> b       ) ->    -- j join            n -> p
       ( b       -> String  ) ->    -- s stringify       p -> 1
       ( String  -> String  )       -- composition
cmd d f m j s = (s . j . map m . f . d)

-- parse an argument string to determine function
make_function :: String -> (String -> String)
make_function "id"      = id'
make_function "reverse" = reverse'
make_function "head"    = head'
make_function "cut"     = cut'
make_function "tail"    = tail'
make_function "wc"      = wc'
make_function "sort"    = sort'
make_function _         = error "Invalid subcommand name"

-- A command that does nothing except resetting columns
id' :: String -> String
id' = (cmd d f m j s) where
    d = readFasta
    f = id
    m = ewrite fshow fshow
    j = id
    s = concat 

-- reverse each sequence (NOT reverse complement)
reverse' :: String -> String
reverse' = (cmd d f m j s) where
    d = readFasta
    f = id
    m = ewrite fshow fshow . tEntry id (tSequence (wrap 60 . reverse))
    j = id
    s = concat

-- head writes the first sequences in a file
head' :: String -> String
head' x = (cmd d f m j s) x where
    d = readFasta
    f = take 1
    m = ewrite fshow fshow
    j = id
    s = concat

-- head writes the first sequences in a file
tail' :: String -> String
tail' x = (cmd d f m j s) x where
    d = readFasta
    f = (take 1 . reverse)
    m = ewrite fshow fshow
    j = id
    s = concat

-- select a given set of entries
k=[1,3]
cut' :: String -> String
cut' x = (cmd d f m j s) x where
    d = readFasta
    f = cut k
    m = ewrite fshow fshow
    j = id
    s = concat

-- count sequences and total size
wc' :: String -> String
wc' x = (cmd d f m j s) x where
    d = readFasta
    f = id
    m = e2q qlength
    j = (\x -> (length x, sum x))
    s = (\x -> (show . fst) x ++ "\t" ++ (show . snd) x ++ "\n")

sort' :: String -> String
sort' x = (cmd d f m j s) x where
    d = readFasta
    f = sort
    m = ewrite fshow fshow
    j = id
    s = concat
