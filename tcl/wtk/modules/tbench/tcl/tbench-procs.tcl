namespace eval ::tbench {
    variable server [ns_info server]
    variable pool test
    variable logStatsFrequency 50
    variable requestId 0
    variable prevReqId 0
    variable count 0
    variable configSetId [ns_set copy [ns_configsection "ns/server/${server}/pool/${pool}"]]
    variable connsPerThread [ns_set iget $configSetId connsPerThread]
    variable poolMapList [list]
    variable threadId
    variable name ; # this is the synthesized thread name see preAuthFilter
    variable threadRequests
    variable processGap 0
    variable requestGap 0

    namespace import -force ::wtk::log::log

}

proc ::tbench::init {} {
    variable server
    variable pool
    variable logStatsFrequency
    variable connsPerThread
    variable requestId
    variable count
    variable poolMapList
    variable configSetId
    variable connsPerThread

    for {set i 0} {$i < [ns_set size $configSetId]} {incr i} {
        if {[string tolower [ns_set key $configSetId $i]] == "map"} {
            lappend poolMapList [ns_set value $configSetId $i]
        }
    }

    if {[llength $poolMapList] == 0} {
        log Warning "::tbench loaded with no thread pool mappings"
        return
    }

    log Notice "::tbench Booting poolMapList = $poolMapList"

    foreach mp $poolMapList {
        lassign $mp method pattern
        ns_register_filter preauth $method $pattern ::tbench::preAuthFilter
        ns_register_filter trace $method $pattern ::tbench::traceFilter
        log Notice "::tbench mapped method $method and pattern $pattern"
    }

    # setup once per start all nsv variables
    nsv_set tbench count $count
    nsv_set tbench requestId $requestId ;# an ever increasing id for each request
    nsv_set tbench connsPerThread $connsPerThread
    nsv_set tbench mutex [ns_mutex create]
    nsv_set tbench deletedCount 0

    log Notice "::tbench::init active: connsPerThread=$connsPerThread stats every $logStatsFrequency"
}

proc ::tbench::preAuthFilter { why } {

    variable server
    variable count [nsv_incr tbench count]
    variable name [join [lrange [split [ns_thread name] ":"] 0 end-1] "-"]
    variable threadId [ns_thread id]
    variable threadRequests [nsv_incr tbench ${name}:${threadId}]
    variable requestId [nsv_incr tbench requestId]
    variable prevReqId
    if {[nsv_exists tbench prevReqId:${name}:${threadId}]} {
        set prevReqId [nsv_get tbench prevReqId:${name}:${threadId}]
        nsv_unset tbench prevReqId:${name}:${threadId}
    } else {
        set prevReqId $requestId
    }
    variable connsPerThread
    variable processGap
    variable requestGap

    log Notice ",tbench Start, tId:, $threadId, reqId:, $requestId,\
        count:, $count, tReq:, $threadRequests, procGap:, $processGap,\
        reqGap:, $requestGap"

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
        log Notice "::tbench::traceFilter about to logStats count=$count freq=$logStatsFrequency"
        catch {logStats}
        ns_mutex unlock [nsv_get tbench mutex]
    }

    log Notice ",tbench Trace, tId:, $threadId, reqId:, $requestId,\
        count:, $count, tReq:, $threadRequests, procGap:,\
        $processGap, reqGap:, $requestGap"

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
    set threads [ns_info threads]
    foreach key [lsort [array names statsCopy]] {
        set hilite ""
        if {($connsPerThread - $statsCopy($key)) <= 0 } {
            catch {
                set tId -[join [lrange [split [lindex [split $key :] 0] -] 1 end] :]:
                if {[lsearch -glob $threads $tId*] == -1} {
                    nsv_unset tbench $key
                    nsv_incr tbench deletedCount $statsCopy($key)
                    set hilite "(del)=>"
                }
                ns_log Notice "DELETE? $hilite$key"
            } 
        }
        append result "[format %40.40s $hilite$key][format %10i $statsCopy($key)]\n"
        incr total $statsCopy($key)
    }
    append result "[format %40.40s "Previously Deleted:"][format %10i $deleted]\n"
    append result "[format %40.40s "total:"][format %10i $total]"

    log Notice "::tbench::logStats: $threadId RESULTS UP TO $total\n$result\n"

    if {$returnResult} {
        return $result
    }
}