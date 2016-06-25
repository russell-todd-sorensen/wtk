namespace eval ::ext::resource {

    variable resources [list]
    
}

proc ::ext::resource::init { } {

    variable resources [list]

}

proc ::ext::resource::add { name command args } {

    variable resources
    lappend resources [list $name [list $command {*}$args]]

}

proc ::ext::resource::exists { name } {

    variable resources
    expr {[lsearch -index 0 -exact $resources $name] > -1 ? 1 : 0}
}

proc ::ext::resource::eval { name args } {

    variable resources
    set command [lindex [lsearch -inline -index 0 -exact $resources $name] 1]
    uplevel 1 [list {*}$command {*}$args]
}

proc echo { args } {
    #puts "args = '$args'"
    uplevel 1 [list append __string $args]

}

::ext::resource::init

::ext::resource::add myEcho echo a b c
::ext::resource::add myEcho2 echo e f g

source xr.tcl