
namespace eval ::lock {
    variable mutexArray mutex
    variable mutexNameGen 0
    variable condArray cond
    variable condMutexMap conditionToMutex
    variable initArray mutexInit
}

proc ::lock::init {mutexName} {
    variable initArray
    variable mutexArray

    if {![nsv_exists $initArray $mutexName]} {
        if {![nsv_exists mutexArray $mutexName]} {
            nsv_set $mutexArray $mutexName [ns_mutex create]
        }
        nsv_set initArray $mutexName 1
    }
    return [nsv_get $mutexArray $mutexName]
}

proc ::lock::getMutexNameGen {} {
    variable mutexNameGen
    return [nsv_incr $mutexNameGen gen]
}

proc ::lock::condInit {condName} {
    variable condArray
    variable mutexArray
    variable mutexNameGen
    variable condMutexMap 
    variable initArray

    if {![nsv_exists $condMutexMap $condName]} {
        while {true} {
            set int [getMutexNameGen]
            set mutexName "condMutex$int"
            ns_log Notice "trying to create mutex $mutexName"
            if {[nsv_exists $mutexArray $mutexName]} {
                continue;
            }
            break;
        }

        nsv_set $mutexArray $mutexName [ns_mutex create]
        nsv_set $condArray $condName [ns_cond create]

        nsv_set $condMutexMap $condName $mutexName
        nsv_set $initArray $mutexName 1
        ns_log Notice "Created mutex $mutexName for cond $condName"
    }
    return [nsv_get $condMutexMap $condName]
}

proc ::lock::Lock {mutexName} {
    set mutexHandle [init $mutexName]
    ns_mutex lock $mutexHandle
}

proc ::lock::cLock {condName} {

    Lock [condInit $condName]
}

proc ::lock::cUnLock {condName} {
    variable condMutexMap
    set mutexName [nsv_get $condMutexMap $condName]
    UnLock $mutexName
}

proc ::lock::Wait {condName} {
    variable mutexArray
    variable condArray
    variable condMutexMap
    set mutexName [nsv_get $condMutexMap $condName]

    ns_log Notice "About to wait on cond [nsv_get $condArray $condName] with mutex [nsv_get $mutexArray $mutexName]"
    set result [ns_cond wait [nsv_get $condArray $condName] [nsv_get $mutexArray $mutexName]]
    ns_log Notice "::lock::Wait result = $result"
    return $result
}

proc ::lock::Broadcast {condName} {
    variable condArray
    ns_cond broadcast [nsv_get $condArray $condName]
}

proc ::lock::UnLock {mutexName} {
    variable mutexArray
    set mutexHandle [nsv_get $mutexArray $mutexName]
    ns_mutex unlock $mutexHandle
}

proc ::getArrayElement {} {
    if {![nsv_exists TEST123 MYLIST]} {
        nsv_lappend TEST123 MYLIST a b c d e f g h i j k
    }
    ::lock::Lock one

    set currList [nsv_get TEST123 MYLIST]
    set len [llength $currList]
    set first [lindex $currList 0]
    
    nsv_set TEST123 MYLIST [lrange $currList 1 end]

    ::lock::UnLock one

    return $first
}

proc ::getArrayElementCond {resultArray resultKey} {

    ns_log Notice "Running ::getArrayElementCond resultArray = $resultArray resultKey = $resultKey"
    ns_log Notice "::getArrayElementCond about to lock condOne"
    ::lock::cLock condOne

    ns_log Notice "::getArrayElementCond locked condOne"

    nsv_set $resultArray $resultKey "NOT DONE YET"
    set first "LIST IS EMPTY"

    if {![nsv_exists COND123 MYLIST]} {
        nsv_lappend COND123 MYLIST a b c d e f g h i j k
    }

    while {[nsv_exists COND123 MYLIST] && [llength [nsv_get COND123 MYLIST]] > 0} {

        if {[::lock::Wait condOne]} {
            if {[nsv_exists COND123 MYLIST] && [llength [nsv_get COND123 MYLIST]] > 0} {
                set currList [nsv_get COND123 MYLIST]
                set len [llength $currList]
                set first [lindex $currList 0]
                ns_log Notice "Got first=$first length now $len"
                nsv_set COND123 MYLIST [lrange $currList 1 end]
                nsv_set $resultArray $resultKey $first
                break;
            } else {
                ::lock::Broadcast condOne
                continue;
            }
        }
    }
    ::lock::Broadcast condOne
    ::lock::cUnLock condOne

    return $first
}

proc ::addArrayElementCond {elementToAdd resultArray resultKey} {

    ns_log Notice "::addArrayElementCond $elementToAdd"
    ::lock::cLock condOne

    set fullList "LIST IS EMPTY"

    if {![nsv_exists COND123 MYLIST]} {
        nsv_lappend COND123 MYLIST a b c d e f g h i j k
    }

    ns_log Notice "::addArrayElementCond about to Wait"

    if {[::lock::Wait condOne]} {
        ns_log Notice "::addArrayElementCond inside Wait"
        nsv_lappend COND123 MYLIST $elementToAdd
        nsv_set $resultArray $resultKey [nsv_get COND123 MYLIST]
    }

    ns_log Notice "::addArrayElementCond after Wait"

    ::lock::Broadcast condOne
    ::lock::cUnLock condOne 

    return [nsv_get $resultArray $resultKey]
}