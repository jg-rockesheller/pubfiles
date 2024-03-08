-- this is how modules are defined

module Geometry (
  sphereVolume,
  sphereArea,
  cubeVolume,
  cubeArea,
) where

sphereVolume :: Float -> Float
sphereVolume radius = (4.0 / 3.0) * pi * (radius ^ 3)

sphereArea :: Float -> Float
sphereArea radius = 4 * pi * (radius ^ 2)

cubeVolume :: Float -> Float
cubeVolume sideLen = sideLen ^ 3

cubeArea :: Float -> Float
cubeArea sideLen = 6 * (sideLen ^ 2)

