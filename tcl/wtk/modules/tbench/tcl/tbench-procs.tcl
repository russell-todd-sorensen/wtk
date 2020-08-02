namespace eval ::tbench {
    variable server [ns_info server]
    variable pool test
    variable logStatsFrequency 5
    variable requestId 0
    variable prevReqId 0
    variable count
    variable threadId
    variable name ; # this is the synthesized thread name see preAuthFilter
    variable threadRequests
    variable configSetId [ns_set copy [ns_configsection "ns/server/${server}/pool/${pool}"]]
    variable connsPerThread [ns_set iget $configSetId connsPerThread]
    variable poolMapList [list]

    for {set i 0} {$i < [ns_set size $configSetId]} {incr i} {
        if {[string tolower [ns_set key $configSetId $i]] == "map"} {
            lappend poolMapList [ns_set value $configSetId $i]
        }
    }

    namespace import -force ::wtk::log::log

    ns_log Notice "Booting ::tbench poolMapList = $poolMapList"
}

proc ::tbench::init {} {

    variable initialized

    if {$initialized} {
        return $initialized
    }

    variable threadRequests 0

    nsv_set tbench ${name}:${threadId} 0

    ns_log Notice "::tbench::init new thread ${name}:${threadId}"
    return [set intialized true]
}

proc ::tbench::preAuthFilter { why } {

    variable count [nsv_incr tbench count]
    variable name [join [lrange [split [ns_thread name] ":"] 0 end-1] "-"]
    variable threadId [ns_thread id]
    variable threadRequests [nsv_incr tbench ${name}:${threadId}]
    variable requestId [nsv_incr tbench requestId]
    variable prevReqId [expr {
        [nsv_exists tbench prevReqId:${name}:${threadId}]
        ? [nsv_get tbench  prevReqId:${name}:${threadId}]
        : $requestId
    }]
    variable server
    variable connsPerThread

    ns_log Notice "Starting tbench threadId: $threadId, requestId: $requestId, \
            totalCount: $count, threadRequests: $threadRequests"

    return filter_ok
}

# processGap == the number of threads starting since this thread started 
# requestGap == the number of requests run since this thread's last request
proc ::tbench::traceFilter { why } {

    variable count
    variable name
    variable threadId
    variable requestId 
    variable prevReqId
    variable threadRequests
    variable processGap [expr {[nsv_get tbench count]-$count}]
    variable requestGap [expr {$requestId - $prevReqId}]
    variable connsPerThread
    variable logStatsFrequency

    if {($count % $logStatsFrequency) == 0 
        &&  ([ns_mutex trylock [nsv_get tbench mutex]]) == 0
    } {
        ns_log Notice "::tbench::traceFilter about to logStats count=$count freq=$logStatsFrequency"
        catch {logStats}
        ns_mutex unlock [nsv_get tbench mutex]
    }

    ns_log Notice "Tracing  tBench threadId: $threadId, requestId: $requestId, \
            processGap: $processGap, threadRequests: $threadRequests, requestGap: $requestGap"

    nsv_set tbench prevReqId:${name}:${threadId} $requestId
    return filter_ok
}

proc ::tbench::logStats {{returnResult false}} {
    variable count
    variable name 
    variable threadId
    variable requestId
    variable prevReqId
    variable threadRequests
    variable processGap
    variable requestGap
    variable connsPerThread

    set result ""
    array set statsCopy [nsv_array get tbench "-conn-*:*"]
    set deleted [nsv_get tbench deletedCount]
    set total $deleted

    foreach key [lsort [array names statsCopy]] {
        if {($connsPerThread - $statsCopy($key)) <= 0 } {
            catch { 
                # it is possible that another thread has already done this,
                # if we wanted to be sure we would obtain a mutex lock before
                # copying the tbench array, I might have to do this anyway...
                nsv_unset tbench $key
                nsv_incr tbench deletedCount $statsCopy($key)
            } 
            set hilite "(del)=>"
        } else {
            set hilite ""
        }
        append result "[format %40.40s $hilite$key][format %10i $statsCopy($key)]\n"
        incr total $statsCopy($key)
    }
    append result "[format %40.40s "Previously Deleted:"][format %10i $deleted]\n"
    append result "[format %40.40s "total:"][format %10i $total]"
    ns_log Notice "thread: $threadId RESULTS UP TO $total\n$result\n"

    if {$returnResult} {
        return $result
    }
}