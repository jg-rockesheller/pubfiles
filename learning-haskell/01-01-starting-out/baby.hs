doubleUs x y = doubleMe x + doubleMe y
doubleMe x = x + x

doubleUsMulDoubleMe x y = doubleUs x y * doubleMe x

doubleSmallNumber x = if x > 100
                      then x
                      else x * 2

tripleSmallNumber x = if x > 100 then x else x * 3

aString = "This is not a variable assignment, just a function that returns this expression (this string)."
