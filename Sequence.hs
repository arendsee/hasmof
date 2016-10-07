module Sequence
(
      Sequence(..)
    , tSequence
    , qlength
) where

import Classes

data Sequence = Sequence String | AA String | DNA String | RNA String deriving (Ord, Eq, Read, Show)

instance FRead Sequence where
    fread s = Sequence s

instance FShow Sequence where
    fshow (Sequence s) = s

tSequence :: (String -> String) -> Sequence -> Sequence
tSequence f (Sequence s) = Sequence (f s)

qlength :: Sequence -> Int
qlength (Sequence s) = length(s)
