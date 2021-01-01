namespace eval ::wtk::node {
    variable requestId 0
    variable requests
    variable initialized 0
    variable defaultHost localhost
    variable defaultPort 3000
    variable tmpDir [file join $::wtk::approot tcl wtk config node tmp]
    variable reqTmpl "req-%4.4d"
    variable jsonFileTmpl "%s.json"
    variable reqFileTmpl  "%s.request"
    variable resFileTmpl  "%s.response"
    variable reqNsTmpl {
        variable reqId $reqId
        variable reqName $reqName
        variable host $host
        variable port $port
        variable tmpPath "$tmpPath"
        variable reqFile "$reqFile"
        variable resFile "$resFile"
        variable reqFd [expr {[info exists reqFile] ? [open [file join "$tmpPath" "$reqFile"] w+] : 0}]
        variable resFd [expr {[info exists resFile] ? [open [file join "$tmpPath" "$resFile"] w+] : 0}]
    }
    namespace import -force ::wtk::log::log
    namespace import -force ::wtk::util::setArgs
}

proc ::wtk::node::post { } {

}

proc ::wtk::node::get { } {

}

proc ::wtk::node::init { } {
    variable requestId
    variable requests
    variable initialized
    variable requestTemplate
    variable reqTmpl

    if {!$initialized} {
        set requestId 0
        set requestTemplate $reqTmpl
        set requestNames [array names requests]
        if {[llength $requestNames]} {
            set initialzed [::wtk::node::cleanUpAll]
        } else {
            foreach ns [namespace children [namespace current]] {
                namespace delete $ns
            }
            set initialized 1
        }
    }
    return $initialized
}

proc ::wtk::node::cleanUpAll {} {
    variable requests
    set success 1
    foreach reqName [array names requests] {
        if {![cleanUp $reqName]} {
            set success 0
        }
    }
    return $success
}

proc ::wtk::node::cleanUpReqNamespace { reqName } {
    variable requests

    set success 1

    if {[info exists requests($reqName)]} {
        try {
            namespace delete [namespace current]::$reqName
        } on {res dict} {
            log Warning \
                "::wtk::node::init unable to delete namespace $reqName error: $res"
            set success 0
        }
    }
    return $success
 }

proc ::wtk::node::cleanUp {reqName} {

    variable requests

    set success [cleanUpReqNamespace $reqName]
    if {$success} {
        unset [namespace current]::requests($reqName)
    }
    return $success
}

proc ::wtk::node::getTmpDir {} {
    variable tmpDir
    return $tmpDir
}

proc ::wtk::node::getDefaultHost {} {
    variable defaultHost
    return $defaultHost
}

proc ::wtk::node::getDefaultPort {} {
    variable defaultPort
    return $defaultPort
}

proc ::wtk::node::newRequest { path args} {
    variable requests
    variable requestId
    variable initialized
    variable defaultHost
    variable defaultPort
    variable reqTmpl
    variable jsonFileTmpl
    variable reqFileTmpl
    variable resFileTmpl
    variable reqNsTmpl

    if {![init]} {
        log Error "::wtk::node Unable to initialize "
        return code -error "Unable to initialize"
    }

    setArgs {
        {tmpPath [::wtk::node::getTmpDir] - {file isdirectory $tmpPath}}
        {reqId 0 - {string is integer -strict $reqId}}
        {host [::wtk::node::getDefaultHost] - {}}
        {port [::wtk::node::getDefaultPort] - {string is integer -strict $port}}
    } {
        {set reqId [expr {$reqId?$reqId:[incr requestId]}]}
    }

    set reqName [format $reqTmpl $reqId]

    set jsonFile [format $jsonFileTmpl $reqName]
    set reqFile  [format $reqFileTmpl  $reqName]
    set resFile  [format $resFileTmpl  $reqName]

    if {[info exists requests($reqName)]} {
        return -code error "Request $reqName already Exists!"
    } else {
        set evalBody [subst -nocommands $reqNsTmpl]
        log Notice ":twt::node::newRequest evalBody='$evalBody'"
        namespace eval [namespace current]::$reqName $evalBody
    }
    set requests($reqName) $reqName
}
