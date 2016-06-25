set ms [clock milliseconds]
append __string "
ms = "

append __string $ms
append __string "
"
set sec [clock seconds]
append __string "
sec = "

append __string $sec
append __string "
"
set now [clock format $sec -format "%a %b %d %H:%M:%S %z %Y"]
append __string "

(clock-to now format "

append __string $sec
append __string " -format "
append __string {"%a %b %d %H:%M:%S %z %Y)

now = }

append __string $now
append __string " 
     ("
append __string [clock format $sec -format "%a %b %d %H:%M:%S %z %Y"]
append __string ")


"
