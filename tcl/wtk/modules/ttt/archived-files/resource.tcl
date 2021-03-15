# resource proc

namespace eval resource {
    variable resourceList
}

proc resource::init { } {

    variable resourceList
    set resourceList [list]

}

proc resource::exists { type name } {
    
    variable resourceList
    set index [lsearch $resource::resourceList "${type}::${name}"]

    return [expr ($index > -1) ? 1 : 0]
}

proc resource::eval { type name args } {
    
    set cmd [list "resource::$type" "$name"]
    foreach arg $args {
        lappend cmd $arg
    }

    return [::eval $cmd]
}

proc resource::add { type name } {

    variable resourceList
    lappend resourceList "${type}::${name}"
}

# Test resources
proc resource::echo { name args } {

    # discard args
    return $name
}

proc resource::args { name args } {

    return "name: $name args: $args"
}

proc resource::fileRead { name } {

    set contents ""
    if {[::file exists $name] && [::file readable $name]} {
        if {[catch {
            set fd [open $name r]
            set contents [read $fd]
            close $fd
        } err ]} {
            if {[info exists fd]} {
                close $fd
            }
            puts stderr "File read error on $name '$err'"
        }
    } else {
        puts stderr "File read error. \
            $name doesn't exist or isn't readable"
    }

    return "$contents"
}

proc resource::fileWrite { name mode contents } {

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

proc matrix { inList outList cols } {

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

proc resource::include { name args } {

    if {![string match "/*" "$name"]} {
        # relative path
        # warning: single threaded apps only!
        set fileroot [pwd]/$name
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

proc resource::command { args } {
    
    #note: must be called by resource::eval
    ::uplevel 2 $args
}
