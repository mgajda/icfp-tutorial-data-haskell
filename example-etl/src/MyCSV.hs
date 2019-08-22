{-# LANGUAGE TemplateHaskell #-}
module MyCSV where
import Frames.TH
import Data.Vinyl.Derived
import Frames                                                                                 
import Frames.Categorical (declareCategorical)                                   
import qualified Pipes.Prelude as P

--tableTypes' (rowGenCat "input/data.csv") { rowTypeName = "Small", tablePrefix = "S" }
tableTypes  (rowGenCat "input/items.csv") -- { rowTypeName = "Small", tablePrefix = "S" }

showCSV = do
  print <$> runSafeEffect loader
  where
     loader :: MonadSafe m => Producer Small m ()
     loader = readTable "input/data.csv"
