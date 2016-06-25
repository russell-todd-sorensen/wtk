set int 1
set float 5.5
set string "My string"
set intHead "Integer"
set floatHead "Float"
set stringHead "Strings and Stuff"
append __string [format "%8s%8s%18s" $intHead $floatHead $stringHead]
append __string "
"
append __string [format "%8.3i%8.3f \"%-15s\"" $int $float $string]
set i 1
append __string "
"
append __string " "
append __string [format %8s "Decimal"]
append __string " | "
append __string [format %5s Hex]
append __string " | "
append __string [format %6s ASCII]
append __string "
"

while {$i<128} {
append __string " "
append __string [format %8i $i]
append __string " | "
append __string [format %5X $i]
append __string " | "
append __string [format '%-c' $i /]
incr i 1
append __string "
"

}
append __string "

"
