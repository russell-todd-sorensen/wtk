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

::ext::resource::init

::ext::resource::add myEcho echo a b c
::ext::resource::add myEcho2 echo e f g

#::ext::resource::eval myEcho 1 2 3
#puts "--"

#::ext::resource::eval myEcho2
