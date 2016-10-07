module Sequence
(
    Sequence(..)
    , qtrans
    , qread
    , qshow
) where

data Sequence = Sequence String | AA String | DNA String | RNA String

qread :: String -> Sequence
qread s = Sequence s

qshow :: Sequence -> String
qshow (Sequence s) = s

qtrans :: (String -> String) -> Sequence -> Sequence
qtrans f (Sequence s) = Sequence (f s)
