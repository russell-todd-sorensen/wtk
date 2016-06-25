set list {a b c d e f g h i j k}
append __string "

"
set list2 [linsert $list 5 t u v w z y z]
append __string "
list = "

append __string $list
append __string "
list2 = "
append __string [set list2]
append __string "

"
set list3 [lsort $list2]
append __string "
list3 = "

append __string $list3
append __string "

"
set remainder [lassign $list3 first second third fourth]
append __string "
first = "

append __string $first
append __string "
second = "

append __string $second
append __string "
third = "

append __string $third
append __string "
fourth = "

append __string $fourth
append __string "
remainder = "

append __string $remainder
append __string "

"
lassign $remainder fifth sixth seventh eighth
append __string "
fifth = "

append __string $fifth
append __string "
sixth = "

append __string $sixth
append __string "
seventh = "

append __string $seventh
append __string "
eighth = "

append __string $eighth
append __string "

"
set ninth [lindex $list3 8]
append __string "

ninth = "

append __string $ninth
append __string " ("
append __string [lindex $list3 8]
append __string ")

"
