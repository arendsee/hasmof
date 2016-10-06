{-# LANGUAGE FlexibleContexts #-}
{-# LANGUAGE GADTs #-}
{-# LANGUAGE TypeFamilies #-}

import System.Environment (getArgs)
import Entry


-- Borrowed from Real World Haskell ---------------------------------
interactWith function inputFile outputFile = do
  input <- readFile inputFile
  writeFile outputFile (function input)

main = mainWith $ make_function
  where mainWith function = do
          args <- getArgs
          case args of
            [cmd, input] -> interactWith (function cmd) input "/dev/stdout"
            _ -> putStrLn "error: exactly 2 arguments needed"
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
make_function "id" = id' 

-- A command that does nothing except resetting columns
id' :: (String -> String)
id' = (cmd d f m j s) where
    d = readFasta
    f = id
    m = write
    j = id
    s = concat 

-- ----------- Smof subcommands ----------------------------------------
-- -- cut emulates UNIX cut command, where fields are entries
-- cut' :: String -> String
-- cut' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- clean cleans fasta files
-- clean' :: String -> String
-- clean' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- filter extracts sequences meeting the given conditions
-- filter' :: String -> String
-- filter' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- grep roughly emulates the UNIX grep command
-- grep' :: String -> String
-- grep' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- md5sum calculate an md5 checksum for the input sequences
-- md5sum' :: String -> String
-- md5sum' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- head writes the first sequences in a file
-- head' :: String -> String
-- head' x = (cmd d f m j s) x where
--     d = readFasta
--     f = take 1
--     m = write
--     j = id
--     s = unlines
--
-- -- permute randomly order sequence
-- permute' :: String -> String
-- permute' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- reverse reverse each sequence (or reverse complement)
-- reverse' :: String -> String
-- reverse' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- sample randomly select entries from fasta file
-- sample' :: String -> String
-- sample' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- sniff extract info about the sequence
-- sniff' :: String -> String
-- sniff' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- sort sort sequences
-- sort' :: String -> String
-- sort' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- split split a fasta file into smaller files
-- split' :: String -> String
-- split' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- stat calculate sequence statistics
-- stat' :: String -> String
-- stat' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- subseq extract subsequence from each entry (revcomp if a<b)
-- subseq' :: String -> String
-- subseq' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- tail writes the last sequences in a file
-- tail' :: String -> String
-- tail' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- uniq count, omit, or merge repeated entries
-- uniq' :: String -> String
-- uniq' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
--
-- -- wc roughly emulates the UNIX wc command
-- wc' :: String -> String
-- wc' x = (cmd d f m j s) x where
--     d = readFasta
--     f = id
--     m = write
--     j = id
--     s = unlines
