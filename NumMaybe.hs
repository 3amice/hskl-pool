import qualified Data.Monoid (Monoid, mappend, mempty)
import Data.Monoid (mappend, mempty)
{-
instance (Eq a, Show a, Num a) => Num (Maybe a) where
  (Just a) + (Just b)   = Just (a+b)
  _ + _                 = Nothing
  (Just a) * (Just b)   = Just (a*b)
  _ * _                 = Nothing
  (Just a) - (Just b)   = Just (a+b)
  _ - _                 = Nothing
  abs (Just a)          = Just (abs a)
  abs _                 = Nothing
  signum (Just a)       = Just (signum a)
  signum _              = Nothing
  fromInteger a         = Just (fromInteger a)
-}

instance Data.Monoid.Monoid (Maybe a) where
  mempty = Nothing
  Nothing `mappend` _ = Nothing
  _ `mappend` Nothing = Nothing
  (Just x) `mappend` (Just y) = Just (x `mappend` y)

x = Just 5
y = Just 3
z = Nothing

