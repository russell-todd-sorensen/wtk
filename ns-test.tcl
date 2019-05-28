namespace eval ::x {

    variable myvar 5
    variable myvar2 10
}

namespace eval ::y {

    #namespace upvar ::x myvar myvar
    upvar 0 ::x::myvar myvar
}

namespace delete ::y

namespace eval ::y {
    variable myvar
    puts "::y::myvar = $myvar"
    puts "::x::myvar = '$::x::myvar'"
    unset ::y::myvar
    puts "::x::myvar = '$::x::myvar'"
    #namespace upvar ::x myvar ""
    variable myvar 4
}

puts "::x::myvar = '$::x::myvar'"
