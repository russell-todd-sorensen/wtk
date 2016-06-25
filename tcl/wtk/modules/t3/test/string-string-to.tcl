set string1 "Now is the time for all good men..."
set string2 $string1
set string3 time
set first_time [string first $string3 $string1 5]
append __string "

first_time = "

append __string $first_time
append __string " ("
append __string [string first $string3 $string1 5]
append __string ")

"
