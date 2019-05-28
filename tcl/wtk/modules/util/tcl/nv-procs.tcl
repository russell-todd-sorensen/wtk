# Name Value Data Structure: similar to ns_set

namespace eval ::wtk::nv {

    variable version 1.0
    namespace import -force ::wtk::log::*
}


proc ::wtk::nv::exists { nvName } {

    upvar 1 $nvName NV
    log Notice "nvList exists? = '[info exists NV]'"
    info exists NV
}

proc ::wtk::nv::size { nvName } {

    upvar 1 $nvName NV

    if {[exists NV]} {
        return [llength $NV]
    } else {
        return -1
    }
}


proc ::wtk::nv::create { nvName {nvList {} } } {

    upvar 1 $nvName NV

    log Debug "nvList = '$nvList'"
    set NV $nvList
}

proc ::wtk::nv::nvPut { nvName key value } {

    upvar 1 $nvName NV
    lappend NV [list $key $value]
}

proc ::wtk::nv::nvGet { nvName key } {

    upvar 1 $nvName NV
    lindex [lsearch -inline $NV [list $key *]] 1
}

proc ::wtk::nv::nviGet { nvName key } {

    upvar 1 $nvName NV
    lindex [lsearch -inline -nocase $NV [list $key *]] 1
}

# nvKey is the first element of the list
proc ::wtk::nv::nvKey { nvName index } {

    upvar 1 $nvName NV
    lindex $NV [list $index 0]
}

# nvValue is the rest of the list
proc ::wtk::nv::nvValue { nvName index } {

    upvar 1 $nvName NV
    lrange [lindex $NV $index] 1 end
}

proc ::wtk::nv::nvUpdateValue { nvName index value } {

    upvar 1 $nvName NV

    lset NV [list $index 1] $value
}

proc ::wtk::nv::nvGetAll { nvName key } {

    upvar 1 $nvName NV

    lsearch -inline -all -glob $NV [list $key *]
}

proc ::wtk::nv::nvSearch { nvName pattern args } {

    upvar 1 $nvName NV

    ::wtk::util::setArgs {
        {exact 0 - {string is boolean -strict $exact}}
        {glob  1 - {string is boolean -strict $glob}}
        {all   0 - {string is boolean -strict $all}}
        {regexp 0 - {string is boolean -strict $regexp}}
        {not 0 - {string is boolean -strict $not}}
        {start 0 - {string is integer -strict $start}}
        {nocase 0 - {string is boolean -strict $nocase}}
        {ascii 0 - {string is boolean -strict $ascii}}
        {integer 0 - {string is boolean -strict $integer}}
        {real 0 - {string is boolean -strict $real}}
        {dictionary 0 - {string is boolean -strict $dictionary}}
    }

    set searchString [list]

    foreach option {exact glob regexp} {
        if {[set $option]} {
            lappend searchString "-$option"
            break
        }
    }
    foreach option {all not nocase} {
        if {[set $option]} {
            lappend searchString "-$option"
        }
    }
    foreach option {ascii integer real dictionary} {
        if {[set $option]} {
            lappend searchString "-$option"
            break
        }
    }
    if {[set start] > 0} {
        lappend searchString -start $start
    }
    lappend searchString $NV $pattern

    log Debug "searchString = '$searchString'"
    lsearch -inline {*}$searchString
}

proc ::wtk::nv::nvEnumeration {nvName args} {

    upvar 1 $nvName NV

    switch -exact [llength $args] {
        0 {
            return [create NV]
        }
        1 {
            # Assume user packaged up all args into one:
            set args [lindex $args 0]
        }
        default {
            # use args as-is
        }
    }

    set len [llength $args]
    set value 0
    set nvArgs [list]
    for {set i 0} {$i < $len} {incr i} {
        set arg [lindex $args $i]
        set val [lindex $args [expr {$i + 1}]]
        if {[string is integer -strict $val]} {
            set value $val
            incr i
        }

        lappend nvArgs [list $arg $value]
        incr value
    }

    create NV $nvArgs
    ::wtk::log::log Notice "nvEnumeration: Created Enum '$nvArgs'"
}

proc ::wtk::nv::nvBitMap {nvName args} {

    upvar 1 $nvName NV

    switch -exact [llength $args] {
        0 {
            return [create NV]
        }
        1 {
            # Assume user packaged up all args into one:
            set args [lindex $args 0]
        }
        default {
            # use args as-is
        }
    }

    set len [llength $args]
    set value 1
    set nvArgs [list]
    for {set i 0} {$i < $len} {incr i} {
        set arg [lindex $args $i]
        set val [lindex $args [expr {$i + 1}]]
        if {[string is integer -strict $val] &&
            (($val eq "1") || (($val % 2) == 0))
        } {
            set value $val
            incr i
        }

        lappend nvArgs [list $arg $value]
        set value [expr {$value * 2}]
    }

    create NV $nvArgs
    ::wtk::log::log Notice "nvBitMap: Created BitMap '$nvArgs'"
}

namespace eval ::wtk::nv {

    variable version 1.0
    namespace export *
    log Notice "wtk::nv exports [namespace export]"
}
