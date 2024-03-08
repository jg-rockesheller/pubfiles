module GeometryDir.RightTri (
  area,
  hypotenuse
) where

area :: Float -> Float -> Float
area width height = (1 / 2) * width * height

hypotenuse :: Float -> Float -> Float
hypotenuse width height = sqrt ((width ^ 2) + (height ^ 2))
