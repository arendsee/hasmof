module Classes
(
      FShow(..)
    , FRead(..)
) where

class FShow a where
    fshow :: a -> String

class FRead a where
    fread :: String -> a
