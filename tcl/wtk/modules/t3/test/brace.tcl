
set x {this is a test}
append __string "

"
append __string [set x]
append __string "

"
foreach {a b c} {{ab cd} {ef gh} {ij kl}} {
append __string "

a = "
append __string [set a]
append __string "
b = "
append __string [set b]
append __string "
c = "
append __string [set c]
append __string "

"
}
append __string "

"

set y 10
append __string "

"

while {$y > 0} {
append __string "countdown "

append __string $y
incr y -1
append __string "
"

}
