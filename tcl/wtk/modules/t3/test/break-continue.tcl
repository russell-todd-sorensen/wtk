set list {6 5 3 7 8 1 2 6 3 0 4 6 3 9}
append __string "
"
set i 1
append __string "items in list = '"
append __string [set list]
append __string "'

"
foreach item $list {
append __string " "
append __string [format %0.2i $i]
append __string " "
incr i 1
if {$item < 5} {
append __string "item "

append __string $item
append __string " less than 5
"

} elseif {$item == 5} {
append __string "
"
continue

} elseif {$item < 8} {
append __string "item "

append __string $item
append __string " less than 8 greater than 5
"

} elseif {$item == 8} {
append __string "item "

append __string $item
append __string " equal to 8
"

} elseif {$item == 9} {
append __string "
  "
break
}
}
append __string "

"
