append __string "About:"
set about [regexp  -about "\[0-9]+" 34523 match extraResult]
append __string " 
"

append __string $about
append __string "
"
regexp "\[0-9]+" 34523 match extraResult
append __string "

match = "
append __string [set match]
append __string "
extraResult = "
append __string [set extraResult]
append __string "

About:"
set about [regexp  -about "\[0-9]+" 34abc match2 extraResult2]
append __string " 
"

append __string $about
append __string "
"
regexp "\[0-9]+" 34abc match2 extraResult2
append __string "

match2 = "
append __string [set match2]
append __string "
extraResult2 = "
append __string [set extraResult2]
append __string "

"
set count [regexp  -all "\[0-9]+" 24ab35cd66et3309 match3]
append __string "
Matches: "

append __string $count
append __string "
match3 = "

append __string $match3
append __string "

"
set matches [regexp  -inline -all "\[0-9]+" 24ab35cd66et3309]
append __string "

"
set i 1
foreach match $matches {
append __string "
match "

append __string $i
append __string " = '"

append __string $match
append __string "' "
incr i 1
}
append __string "

"
set data 24ab35cd66et3309
append __string "

"
if {[regexp "\[x-z]+"  $data match]} {
append __string "

  match = "

append __string $match
append __string "

"

} elseif {[regexp "\[0-9]+"  $data match]} {
append __string "

  match = "

append __string $match
append __string "

"
 } else {
append __string "

  no match

"
}
