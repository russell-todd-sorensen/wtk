set list {a b c d e f g h i j k}
append __string "

"
set list2 [lrange $list 4 7]
append __string "

list = "

append __string $list
append __string "
list2 = "

append __string $list2
append __string "

list is "
append __string [llength $list]
append __string " elements long

"
set listlength [llength $list]
append __string "

list is "

append __string $listlength
append __string " elements long

"
set list2length [llength $list2]
append __string "

list2 is "

append __string $list2length
append __string " elements long

list2 = "
append __string [lrange $list 4 7]
append __string " ("

append __string $list2)
append __string "

"
