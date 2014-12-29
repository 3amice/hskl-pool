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

x = Just 5
y = Just 3
z = Nothing

a = x + y == Just 8
b = (x + z) == Nothing
c = sum [ n+n | n <- [x,y]] == Just 16 
