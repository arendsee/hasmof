module Header
(
      Header(..)
    , tHeader
) where

import Classes

data Header = Header String String deriving (Eq, Read, Show)

instance Ord Header where
    (<=) (Header i1 d1) (Header i2 d2)
        | i1 <  i2  = True
        | d1 <= d2  = True
        | otherwise = False

instance FRead Header where
    fread s = Header name desc where
        w = words s
        name = (unwords . take 1) w
        desc = (unwords . drop 1) w

instance FShow Header where
    fshow (Header i "") = ">" ++ i
    fshow (Header i d)  = ">" ++ i ++ " " ++ d

tHeader :: (String -> String) -> (String -> String) -> Header -> Header
tHeader f g (Header i d) = Header (f i) (g d)
