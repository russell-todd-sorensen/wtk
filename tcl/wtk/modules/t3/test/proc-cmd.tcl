namespace eval ::t3::s {
variable x 100
variable y "Hello, World!"

}
if {[llength [info procs ::t3::s::myProc]] == 0} {
	proc ::t3::s::myProc {a b {c 2}} {
variable x
variable y
set x $a
set y $b
set z $c
append __string "a="

append __string $a
append __string " b="

append __string $b
append __string " c="

append __string $c
append __string "

"

		return $__string
	}
}
if {[llength [info procs ::t3::s::showVars]] == 0} {
	proc ::t3::s::showVars { } {
variable x
variable y
append __string "x = "

append __string $x
append __string "
y = "

append __string $y

		return $__string
	}
}
