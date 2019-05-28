# procs to use PgTcl

namespace eval ::wtk::pg {

    variable version 1.0
    variable Databases
    variable handleToDbMap

    # An array of db handles indexed by dbName
    variable dbHandles

    variable argList [list handles minHandles maxHandles host port conninfo connlist]
    namespace import -force ::wtk::log::log
}


proc ::wtk::pg::addDatabase { dbName args } {

    variable Databases

    ::wtk::util::setArgs {
        {handles 1 - {expr {[string is integer -strict $handles] ? $handles : 1}} }
        {minHandles 0 - {expr {[string is integer -strict $minHandles] ? $minHandles : 0}} }
        {maxHandles 1 - {expr {[string is integer -strict $maxHandles] ? $maxHandles : 1}} }
        {host "" - {}}
        {port "" - {}}
        {conninfo "" - {}}
        {connlist "" - {}}
    }

    if {$handles > $maxHandles} {
        set handles $maxHandles
    }

    if {$handles < $minHandles} {
        set handles $minHandles
    }

    set Databases($dbName) [list $handles $minHandles $maxHandles $host $port $conninfo $connlist]
}

proc ::wtk::pg::connectAllDatabases { } {

    variable Databases

    foreach dbName [array names Databases] {
        log Notice "connectAllDatabases connecting $dbName"
        connectByName $dbName
    }
}


proc ::wtk::pg::connectByName { dbName } {

    variable Databases
    variable dbHandles
    variable handleToDbMap
    variable argList

    if {[info exists Databases($dbName)]} {
        lassign $Databases($dbName) {*}$argList
    } else {
        lassign {0 0 0 "" "" "" ""} {*}$argList
    }

    log Notice "connectByName: connecting to dbName minHandles = ($minHandles)"
    for {set i 0} {$i < $minHandles} {incr i} {

        if {[catch {
            set dbHandle [connectOne $dbName]
        } err ]} {
            log Error "connectByName: unable to connect $dbName error: '$err'"
            return -code error $err
        }

        switch -exact -- $dbHandle {
            "" {
                log Warning "connectByName: unable to connect $dbName"
                lappend dbHandles($dbName) $dbHandle
                set handleToDbMap($dbHandle) $dbName
            }
            default {
                log Notice "connectByName: connected $dbName handle: '$dbHandle'"
                lappend dbHandles($dbName) $dbHandle
                set handleToDbMap($dbHandle) $dbName
            }
        }
    }
    if {[info exists dbHandles($dbName)]} {
        log Notice "connectByName: connections to $dbName : '$dbHandles($dbName)'"
        log Notice "connectByName handle = '[lindex $dbHandles($dbName) 0]'"
    }
}

proc ::wtk::pg::connectOne { dbName } {

    variable Databases
    variable dbHandles
    variable argList

    lassign $Databases($dbName) {*}$argList

    if {$conninfo ne ""} {
        set dbHandle [pg::connect -conninfo $conninfo]
    } elseif {$connlist ne ""} {
        set dbHandle [pg::connect -connlist $connlist]
    } elseif {$host ne ""} {
        if {$port eq ""} {
            set port 5432
        }
        set dbHandle [pg::connect $dbName -host $host -port $port]
    } else {
        set dbHandle [pg::connect $dbName]
    }

    return $dbHandle
}

proc ::wtk::pg::getHandle { dbName } {

    variable Databases
    variable dbHandles

    set dbHandle ""
    if {[info exists dbHandles($dbName)] &&
        [llength $dbHandles($dbName)] > 0
    } {
        set dbHandle [lindex $dbHandles($dbName) 0]
        set dbHandles($dbName) [lrange $dbHandles($dbName) 1 end]
        log Notice "pg::getHandle from $dbName dbHandles = '$dbHandles($dbName)'"
    }

    return $dbHandle
}

proc ::wtk::pg::releaseHandle {dbHandle } {

    variable dbHandles
    variable handleToDbMap

    # Clear any results assoc with handle
    set results [pg_dbinfo results $dbHandle ]

    foreach result $results {
        ::pg::result $result -clear
    }

    set dbName $handleToDbMap($dbHandle)
    lappend dbHandles($dbName) $dbHandle
    log Notice "pg::releaseHandle to $dbName dbHandles = '$dbHandles($dbName)'"
}
