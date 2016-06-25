set list {a b c d}
append __string "

"
set list2 [lreplace $list 1 2 r g]
append __string "

list = "

append __string $list
append __string "
list2 = "

append __string $list2
append __string " ("
append __string [lreplace $list 1 2 r g]
append __string ")

"
set list3 [lrepeat 5 $list2]
append __string "

list3 = "

append __string $list3
append __string " ("
append __string [lrepeat 5 $list2]
append __string ")


"
