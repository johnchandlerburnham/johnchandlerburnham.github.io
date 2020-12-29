module Main where

import           System.Random
import           Text.Read

main :: IO ()
main = do
  secret <- getStdRandom (randomR (1,101))
  putStrLn "secret is: "
  print secret
  let loop = do
        putStrLn "Please input your guess"
        guess <- getLine
        case (readMaybe guess) :: Maybe Int of
          Nothing -> loop
          Just x  -> case (compare guess secret) of
            GT -> (putStrLn "Too high" >> loop)
            EQ -> (putStrLn "You win!" >> return ())
            LT -> (putStrLn "Too low" >> loop)
  loop

