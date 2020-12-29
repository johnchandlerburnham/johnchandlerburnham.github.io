import Text.Read
import System.Random

main :: IO ()
main = do
  secret <- getStdRandom (randomR (1,101))
  let loop :: IO ()
      loop = do
        putStrLn "Please input your guess"
        guess <- getLine
        case (readMaybe guess) :: Int of
          Nothing -> loop
          Just x -> continue x
  let continue guess = do
        case (compare guess secret) of
          GT -> (putStrLn "Too high"; loop)
          EQ -> (putStrLn "You win!"; return ())
          LT -> (putStrLn "Too low"; loop)
  loop
