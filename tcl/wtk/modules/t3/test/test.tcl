append __string "I am "

set x 5
incr x 1
append __string [set x]
append __string " years old!

"
if $x<5 {
append __string "
 I am less than five
"

} elseif $x==5 {
append __string "
 I am five years old
"
 } else {
append __string "
 I amd older than five
"
}
append __string "

I am exactly "

append __string $x
append __string " years old


Here is something else to consider:
 {45 + 5 = 50}
 "
append __string {"Pretty Cool, Huh?"


}

while {$x<30} {
append __string "
 x = "

append __string $x
append __string " "
incr x 1
append __string "
"

}
