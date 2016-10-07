module Util
(
      wrap
    , blank
    , cut
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

blank :: a -> String
blank _ = ""

cut :: [Int] -> [a] -> [a]
cut [] _ = []
cut (x:xs) v
    | n > i =  [v !! i] ++ cut xs v
    | otherwise = error "No can do, sir!\n"
    where
        n = length(v)
        i = x - 1
