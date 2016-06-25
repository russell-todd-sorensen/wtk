switch -glob $x {
   x* {
      }
   bbac {
   append __string "
  This is case 'bbac'
  "

set a b
append __string "
 "
   }
   abc {
   append __string "
  This is case 'abc'
  "

set a abc
append __string "
 "
   }
   default {
   append __string "
  This is the default
  "

set a $x
append __string "
 "
   }
}
append __string "

The result a = "

append __string $a
append __string "

Goodbye!

"
