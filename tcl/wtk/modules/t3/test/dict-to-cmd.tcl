dict set employeeInfo 12345-A forenames "Joe"
dict set employeeInfo 12345-A surname "Schmoe"
dict set employeeInfo 12345-A street "147 Short Street"
dict set employeeInfo 12345-A city "Springfield"
dict set employeeInfo 12345-A phone "555-1234"
dict set employeeInfo 98372-J forenames "Anne"
dict set employeeInfo 98372-J surname "Other"
dict set employeeInfo 98372-J street "32995 Oakdale Way"
dict set employeeInfo 98372-J city "Springfield"
dict set employeeInfo 98372-J phone "555-8765"
set i 0
append __string "

There are "
append __string [dict size $employeeInfo]
append __string " employees

"
dict for {id info} $employeeInfo {
	append __string "
   Employee #"
incr i 1
append __string ": "

append __string $id
append __string "
   "
dict with info {
	append __string "
   Name: "

append __string $forenames
append __string " "

append __string $surname
append __string "
   Address: "

append __string $street
append __string ", "

append __string $city
append __string "
   Telephone: "

append __string $phone
append __string "
   "

}

}
set emp_keys [dict keys $employeeInfo]
foreach id $emp_keys {
append __string "
   Hello, "
append __string [dict get $employeeInfo $id forenames]
append __string "!
"
}
set myDict [dict create]
set capital [dict create C $myDict]
set letters [split {abcdefghijklmnopqrstuvwxyz} ""]
foreach c $letters {
set upper [string toupper $c]
dict set capital C $c $upper

append __string $c
append __string " = "
append __string [dict set capital C $c $upper]
append __string "
"
}
set en [dict get $capital C]
dict set capital en $en
dict set capital en_US $en
dict set capital en_US.UTF-8 $en
dict set capital en_GB $en
set string "Now is the Time for all good men to come to the aid of their country"
set upperCaseMap [dict get $capital $env(LANG)]
append __string "original = 
"

append __string $string
append __string "
upperCase = 
"
append __string [string map $upperCaseMap $string]
append __string "


Do dict-for/dict-with again without hyphens:

"
dict for {id info} $employeeInfo {
	append __string "
   Employee #"
incr i 1
append __string ": "

append __string $id
append __string "
   "
dict with info {
	append __string "
   Name: "

append __string $forenames
append __string " "

append __string $surname
append __string "
   Address: "

append __string $street
append __string ", "

append __string $city
append __string "
   Telephone: "

append __string $phone
append __string "
   "

}

}
append __string "

Do dict-filter-to:

"
set emps [dict filter $employeeInfo key "12345*"]
dict for {key value} $emps {
	
append __string $key
append __string "
 "
dict for {key2 value2} $value {
	
append __string $key2
append __string " = "

append __string $value2
append __string "
 "

}

}
append __string "

"
