module Util
(
    wrap
    , blank
) where

wrap :: Int -> String -> String
wrap _ [] = []
wrap 0 s  = s
wrap n s
    | rhs == [] = lhs 
    | otherwise = lhs ++ "\n" ++ wrap n (rhs)
    where
        rhs = drop n s
        lhs = take n s

blank :: String -> String
blank _ = ""
