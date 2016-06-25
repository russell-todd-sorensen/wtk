set array_list {1 DEBUG 2 INFO 4 WARNING 8 ERROR 16 NOTICE}
append __string "

"
append __string [array set my_array $array_list]
append __string "

"
set array_list2 [array get my_array]
append __string "

array_list = "

append __string $array_list
append __string "

"
set keys [array names my_array]
append __string "
"
set keys [lsort -integer -increasing $keys]
append __string "

"
foreach key $keys {

append __string my_array($key)
append __string " = "

append __string $my_array($key)
append __string "
"
}
append __string "


"
