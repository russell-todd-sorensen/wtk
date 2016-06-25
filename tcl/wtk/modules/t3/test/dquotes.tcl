
set x "this is a command \[set x y]"
append __string "

"

append __string $x
append __string "

Now what?

"
lappend x "some more stuff" "\\a\b\t what" "nothing"
append __string "

"
