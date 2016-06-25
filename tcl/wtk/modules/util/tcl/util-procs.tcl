# Utility Procs
set fileDirectory [file dirname [info script]]
::wtk::modules::sourceFile [file join $fileDirectory arg-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory nv-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory nsset-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory detach.tcl]


namespace eval ::wtk::util {

    variable version 1.0

}

proc ::wtk::util::showVars { {ns {}} } {

    if {$ns eq ""} {
	set ns [namespace current]
    }

    set vars [lsort [info vars ${ns}::*]]

    foreach var $vars {
	set var [namespace tail $var]
	namespace upvar $ns $var $var
	if {[info exists $var]} {
	    log Notice "$var = '[set $var]'"
	} else {
	    log Notice "$var = undefined"
	}
    }
}

namespace eval ::wtk::util {
    namespace export *
}