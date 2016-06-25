set list {a b}
append __string "

"
lappend list2 {*}[lrepeat 3 $list]
append __string "

"
set list3 $list2
append __string "

"
lappend list3 {*}[lrepeat 5 x y z]
append __string "

list1 = '"

append __string $list
append __string "'
list2 = '"

append __string $list2
append __string "'
list3 = '"

append __string $list3
append __string "'"
