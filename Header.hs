module Header
(
      Header(..)
    , htrans
    , hread
    , hshow
) where

data Header = Header String String

hread :: String -> Header
hread s = Header name desc where
    w = words s
    name = (unwords . take 1) w
    desc = (unwords . drop 1) w

hshow :: Header -> String
hshow (Header i "") = ">" ++ i
hshow (Header i d)  = ">" ++ i ++ " " ++ d

htrans :: (String -> String) -> (String -> String) -> Header -> Header
htrans f g (Header i d) = Header (f i) (g d)
