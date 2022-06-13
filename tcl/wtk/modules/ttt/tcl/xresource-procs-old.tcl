namespace eval ::ext {
    # future config of all extensions
}

namespace eval ::ext::resource {
    variable resourceList [list]
    namespace import -force ::wtk::log::log
}

proc ::ext::resource::init { } {
    variable resourceList [list]
}

if {0} {
    proc ::ext::resource::exists { type name } {
        
        variable resourceList

        set index [lsearch $resourceList "${type}::${name}"]
        expr {($index > -1) ? 1 : 0}
    }

    proc ::ext::resource::eval { type name args } {
        ::ext::resource::$type $name {*}$args
    }

    proc ::ext::resource::add { type name } {

        variable resourceList

        if {![exists $type $name]} {
            lappend resourceList "${type}::${name}"
        }
    }

    proc ::ext::resource::echo { name args } {
        # discard args
        return $name
    }
}

proc ::ext::resource::add { name command args } {

    variable resources
    lappend resources [list $name [list $command {*}$args]]
}

proc ::ext::resource::exists { name } {

    variable resources
    lsearch -index 1 -exact $resources $name
}

proc ::ext::resource::eval { name args } {

    variable resources
    set command [lindex [lsearch -inline -index 0 -exact $resources $name] 1]
    uplevel 1 [list {*}$command {*}$args]
}

proc echo { args } {
    #puts "args = '$args'"
    uplevel 1 [list puts [list append __string $args]]
}

proc ::ext::resource::args { name args } {

    return "name: $name args: $args"
}

proc ::ext::resource::fileRead { name } {

    set contents ""

    if {[::file exists $name] && [::file readable $name]} {
        if {[catch {
            set fd [::open $name r]
            set contents [::read $fd]
            close $fd
        } err ]} {
            if {[::info exists fd]} {
                ::close $fd
            }
            ::puts stderr "File read error on $name '$err'"
        }
    } else {
        ::puts stderr "File read error. \
            $name doesn't exist or isn't readable"
    }

    return "$contents"
}

proc ::ext::resource::fileWrite { name mode contents } {

    if {
        ![::file exists $name] || 
        ([::file exists $name] && [::file writable $name])
    } {
        if {[catch {
            set fd [open $name "$mode"]
            puts $fd "$contents"
            close $fd
        } err ]} {
            if {[info exists fd]} {
                close $fd
            }
            puts stderr $err
        }
    } else {
        puts stderr "File write error on $name $mode"
    }

    return ""
}

proc ::ext::resource::matrix { inList outList cols } {

    # procedure creates new list from input list
    # cols is the result set cols == input rows
    # cols is an artificial dimension, which along
    # with the length of the list determines the
    # dims of the matrix. The list is filled
    # with {} until the matrix is complete:
    # 1  2  3  4                1  5  9
    # 5  6  7  8  - cols = 3 -> 2  6 10
    # 9 10 11 {}                3  7 11
    #                           4  8 {}

    upvar $inList IL
    upvar $outList OL

    set rows [expr round(ceil([llength $IL].0/$cols))]
    # make matrix
    set Index [expr ($rows * $cols)] 
    set OL [list]
    
    for {set i 0} {$i < $Index} {incr i} {
        set x [expr  $i/$cols ]
        set y [expr  $i % $cols]
        # flip x y
        lappend OL [lindex $IL [expr $y * $rows + $x] ]
    }
}


proc ::ext::resource::include { name args } {

    if {![string match "/*" "$name"]} {
        # relative path
        # warning: single threaded apps only!
        set fileroot [file normalize $name]
    } else {
        set fileroot $name
    }
    
    # what type of file to source?
    # if .tcl file exists, do that
    # elseif .cmp file exists, do that
    # else if exact fileroot exists, that

    if {
        [file exists ${fileroot}.tcl] &&
        [file readable ${fileroot}.tcl]
    } {
        # do tcl
        set filename ${fileroot}.tcl
    } elseif {
        [file exists ${fileroot}.cmp] &&
        [file readable ${fileroot}.cmp]
    } {
        # do cmp
        set filename ${fileroot}.cmp
    } elseif {
        [file exists ${fileroot}] && 
        [file readable ${fileroot}]
    } {
        # do exact
        set filename $fileroot
    } else {
        puts "Include Error $name not found or not readable"
        return ""
    }

    # read args
    foreach {var value} $args {
        set var [string trimleft $var "-"]
        set $var $value
    }

    # source file, result is returned:
    ::source $filename
    uplevel 2 [list append string $string]
}

proc ::ext::resource::command { args } {
    
    #note: must be called by resource::eval
    ::uplevel 2 $args
}
