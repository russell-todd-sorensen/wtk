set data "this|is|a|string|with&two|separators&Wow"
append __string "data = "

append __string $data
append __string "

(split-to list-var "

append __string $data
append __string " "
append __string {"|&")

}
set list-var [split $data "|&"]
append __string "list-var =  "

append __string ${list-var}
append __string " 
with split ("
append __string [split $data "|&"]
append __string ")

"
