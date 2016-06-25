set string "(5.2,-4e-2)"
set count [scan  $string " (%f ,%f %c" x y last]
if {$count != 3 || $last != 0x0029 } {
append __string "invalid coordinate string"
 } else {
append __string "X="

append __string $x
append __string ", Y="

append __string $y
}
append __string "
"
