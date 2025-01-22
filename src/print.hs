{-# LANGUAGE ForeignFunctionInterface #-}

module Print where

import Foreign
import Foreign.C
import Foreign.C.Types

day_haskell_5 :: CString -> IO CString
day_haskell_5 so_far = do s <- (peekCString so_far)
                          free so_far
                          newCString (s ++ "Five pure functions\n")

foreign export ccall day_haskell_5 :: CString -> IO CString
