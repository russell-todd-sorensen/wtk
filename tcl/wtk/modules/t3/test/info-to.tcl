set tclprocs [info procs ::tcl::*]
append __string "

"
foreach proc $tclprocs {
set args [info args $proc]
append __string "
"

append __string $proc
append __string " { "
foreach arg $args {
set has_default [info default $proc $arg default]
if {$has_default} {
append __string "{"
append __string [list $arg $default]
append __string "} "
 } else {

append __string $arg
append __string " "
}
}
append __string "} {"
append __string [info body $proc]
append __string "}
"
}
append __string "

"
