# procedures to generate the complete config
# for an nsd server

namespace eval ::nsStart {
    variable textValue ""
    variable sectionIds [ns_configsections]
    variable nameToSetIdMap
    variable initialized 0
}

proc ::nsStart::init {} {
    variable textValue ""
    variable sectionIds
    variable nameToSetIdMap
    variable initialized

    if {$initialized} {
        return $initialized
    }

    for {set i 0} {$i < [llength $sectionIds]} {incr i} {
        set setId [lindex $sectionIds $i]
        lappend nameToSetIdMap [list [ns_set name $setId] $setId]
    }

    set nameToSetIdMap [lsort -index 0 $nameToSetIdMap]

    foreach map $nameToSetIdMap {
        set name [lindex $map 0]
        set setId [lindex $map 1]
        set size [ns_set size $setId]
        append textValue "\n\nns_section \"$name\"\n"

        for {set i 0} {$i < $size} {incr i} {
            set key [ns_set key $setId $i]
            set value [ns_set value $setId $i]
            set param "ns_param [format %29.29s \"$key\"]    \"$value\"\n"
            append textValue $param
        }
    }

    set initialized 1
    return $initialized
}

proc ::nsStart::writeToFd {{fdOrLog log} {level Notice}} {
    variable initialized
    variable textValue
    if {![init]} {
        ns_log Error "::nsStart::writeToFd failed to initialize fd=$fdOrLog level=$level"
        return
    }
    switch -exact -- $fdOrLog {
        "log" {
            ns_log $level \n$textValue\n
        }
        default {
            puts $fdOrLog "\n$textValue\n"
        }
    }
}