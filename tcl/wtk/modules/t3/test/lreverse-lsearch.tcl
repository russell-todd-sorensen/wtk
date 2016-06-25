set list {a b c d e f g h i j k l m}
append __string "

"
set list2 [lreverse $list]
append __string "

list = "

append __string $list
append __string "
list2 = "

append __string $list2
append __string " ("
append __string [lreverse $list]
append __string ")

"
set list3 {cat can curve bears badguys bees cabs naps tabs waps labs}
append __string "
"
set pattern "\[a-z]+(a(b|p))\[a-z]+"
append __string "
regexp pattern = "
append __string [set pattern]
append __string "
"
set list4 [lsearch -inline -all -regexp $list3 $pattern]
append __string "

list3 = "

append __string $list3
append __string "
list4 = "

append __string $list4
append __string " ("
append __string [lsearch -inline -all -regexp $list3 $pattern]
append __string ")

"
