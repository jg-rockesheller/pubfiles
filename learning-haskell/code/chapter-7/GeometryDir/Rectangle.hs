module GeometryDir.Rectangle (
  area,
  perimeter
) where

area :: Float -> Float -> Float
area width height = width * height

perimeter :: Float -> Float -> Float
perimeter width height = (width * 2) + (height * 2)
