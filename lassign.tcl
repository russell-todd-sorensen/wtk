
proc lassign {list args} {
    set i 0
    set argLength [llength $args]
    set listLength [llength $list]
    if {$argLength > $listLength} {
        return -code error "Input List shorter than number of variables to assign"
    }
    foreach arg $args {
        upvar 1 $arg __$arg
        set __$arg [lindex $list $i]
        incr i
    }

    lrange $list $i end
}

set list {1 2 3 4 5 6}
puts "[lassign $list a b c d] a=$a, b=$b, c=$c, d=$d"

rename ::namespace namespace_original

proc ::namespace {option args} {

    switch -exact -- $option {
        upvar {
            set namespace [lindex $args 0]
            set vars [lrange $args 1 end]
            if {[llength $vars]%2} {
                set msg "::namespace upvar each upvar'd variable requires two args"
                ::wtk::log::log Error $msg
                return -code error $msg
            }
            foreach {globalVar localVar} $vars {
                uplevel 1 upvar #1 ::${namespace}::$globalVar $localVar
            }
        }
        default {
            uplevel 1 ::namespace_original $option $args
        }
    }

}

proc ::testNamespaceUpvar {} {
    namespace eval ::test { variable x 5 }

    namespace upvar ::test x y
    puts stderr "testNamespaceUpvar y=$y"
    namespace eval ::test2 {
        variable x2 2
        variable y
        namespace upvar ::test x y
    }
    puts stderr "testNamespaceUpvar ::test2::y = $::test2::y"
}

#rename ::chan ::chan_original

proc ::chan {method args} {

    switch -exact -- $method {
        pending {
            return 1
        }
        configure {
            uplevel 1 fconfigure $args
        }
        event {
            ::wtk::log::log Notice "fake ::chan event calling 'fileevent $args'"
            uplevel 1 fileevent $args
        }
        copy {
            uplevel 1 fcopy $args
        }
        puts {
            uplevel 1 puts $args
        }
        close {
            uplevel 1 close $args
        }
        tell {
            uplevel 1 tell $args
        }
        seek {
            uplevel 1 seek $args
        }
        read {
            uplevel 1 read $args
        }
        gets {
            uplevel 1 gets $args
        }
        default {
            uplevel 1 ::chan_original $method $args
        }
    }
}