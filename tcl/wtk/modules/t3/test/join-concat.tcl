set list1 {a b c d e f g h i j}
append __string "

"
set joined_list1 [join $list1 "-"]
append __string "

list1 = "

append __string $list1
append __string " "
set list2 $list1
append __string "
list2 = "

append __string $list2
append __string "

(join-to joined_list1 "

append __string $list1
append __string " "
append __string {"-")

joined_list1 = }

append __string $joined_list1
append __string "
              ("
append __string [join $list1 "-"]
append __string ")


"
set list3 {x y z}
append __string "

(concat "

append __string $list1
append __string " "

append __string $list3)
append __string "
       "
append __string [concat $list1 $list3]
append __string "



list1 = "

append __string $list1
append __string "

"
set list1 [concat $list1 $list3]
append __string "

(concat-to list1 "

append __string $list1
append __string " "

append __string $list3)
append __string "

list1 = "

append __string $list1
append __string "
list2 = "

append __string $list2
append __string "

"
set list4 [concat $list2 $list3]
append __string "
(concat-to list4 "

append __string $list2
append __string " "

append __string $list3)
append __string "

list1 = "

append __string $list1
append __string "
list2 = "

append __string $list2
append __string "
list3 = "

append __string $list3
append __string "
list4 = "

append __string $list4
append __string "


"
