namespace eval ::tbench {
    variable logStatsFrequency 
    variable connsPerThread
    variable requestId
    variable count 0
    variable poolMapList
    variable server
    # setup once per start all nsv variables
    nsv_set tbench count $count
    nsv_set tbench requestId $requestId ;# an ever increasing id for each request
    nsv_set tbench connsPerThread $connsPerThread
    nsv_set tbench mutex [ns_mutex create]
    nsv_set tbench deletedCount 0

    foreach mp $poolMapList {
        lassign $mp method pattern
        ns_register_filter preauth $method $pattern ::tbench::preAuthFilter
        ns_register_filter trace $method $pattern ::tbench::traceFilter
        ns_log Notice "::tbench mapped method $method and pattern $pattern"
    }
    if {[llength $poolMapList] == 0} {
        log Warning "::tbench loaded with no thread pool mappings"
    }
    ns_log Notice "::tbench started connsPerThread=$connsPerThread stats every $logStatsFrequency"
}
