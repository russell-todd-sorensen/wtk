set list1 {{a b c} {d e f} {g h i} {j k l} {m n o} {p q r}}
append __string "

"
set list2 $list1
append __string "

list1 = "

append __string $list1
append __string "
list2 = "

append __string $list2
append __string "

"
lset list2 1 1 x
append __string "
(lset list2 1 1 x)

list1 = "

append __string $list1
append __string "
list2 = "

append __string $list2
append __string "

"
lset list2 2 2 x
append __string "
(lset list2 2 2 x)

list1 = "

append __string $list1
append __string "
list2 = "

append __string $list2
append __string "

"
lset list2 0 0 x
append __string "
(lset list2 0 0 x]

"
lset list2 3 {x x x}
append __string "
(lset list2 3 {x x x})

list1 = "

append __string $list1
append __string "
list2 = "

append __string $list2
append __string "


"
