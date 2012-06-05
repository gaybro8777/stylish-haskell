--------------------------------------------------------------------------------
module StylishHaskell
    ( runStep
    , runSteps
    ) where


--------------------------------------------------------------------------------
import           StylishHaskell.Parse
import           StylishHaskell.Step


--------------------------------------------------------------------------------
runStep :: Maybe FilePath -> Step -> Lines -> Lines
runStep mfp f ls = case parseModule mfp (unlines ls) of
    Left err      -> error err  -- TODO: maybe return original lines?
    Right module' -> f ls module'


--------------------------------------------------------------------------------
runSteps :: Maybe FilePath -> [Step] -> Lines -> Lines
runSteps mfp = foldr (flip (.)) id . map (runStep mfp)
