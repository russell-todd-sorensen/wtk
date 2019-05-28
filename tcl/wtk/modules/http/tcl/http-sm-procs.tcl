# Http state machine procs

namespace eval ::wtk::http::sm {

    variable version 1.0

    namespace import -force ::wtk::log::log
}

proc ::wtk::http::sm::getRequest { connId } {

    namespace upvar [::wtk::http::server::getConnNamespace $connId] conn conn

    switch -exact -- $conn(state) {

        headers {

        }
        document {

        }
        request {
            #getRequestLine $connId
            getWholeRequest $connId
        }
        finished {
            cleanupRequest
        }
        default {
            log Error "getRequest: Unexpected state '$conn(state)'"
            return -code return
        }
    }
}

proc ::wtk::http::sm::getRequestLine { connId } {

    namespace upvar [::wtk::http::server::getConnNamespace $connId] conn conn

    #after 20000

    if {[gets $conn(chan) conn(request)] == -1 } {
        if {[chan blocked $conn(chan)]} {
            chan read $conn(chan) 0
            # just return and see what happens
            set pending [chan pending input $conn(chan)]
            log Notice "getRequestLine: waiting for input on $connId pending: '$pending'"

        } else {
            set conn(state) error
            log Error "getRequestLine: badRequest on $connId"
            ::wtk::http::server::respondBadRequest $connId
        }
    } else {
        set conn(state) headers
        log Notice "Got request $conn(request)"
    }
}

proc ::wtk::http::sm::getWholeRequestOld { connId } {

    namespace upvar [::wtk::http::server::getConnNamespace $connId] conn conn

    if {![eof $conn(chan)]} {
        set buff [read $conn(chan)]

        log Notice "getWholeRequest: read buff: '$buff'"
        log Notice ""

        puts -nonewline $conn(requestFd) $buff
        flush $conn(requestFd)

    } else {
        set conn(state) finished
    }
}

proc ::wtk::http::sm::getWholeRequest { connId } {

    namespace upvar [::wtk::http::server::getConnNamespace $connId] conn conn

    chan copy $conn(chan) $conn(requestFd) -command [list ::wtk::http::sm::finishRequest $connId]
}

proc ::wtk::http::sm::finishRequest { connId copyLength} {

      namespace upvar [::wtk::http::server::getConnNamespace $connId] conn conn
      log Notice "finishRequest: finished reading $conn(chan) to $conn(requestFilename) with $copyLength bytes"
      chan event $conn(chan) readable
      chan event $conn(chan) writable [list ::wtk::http::sm::handleRequest $connId]
}


proc ::wtk::http::sm::handleRequest { connId } {

      namespace upvar [::wtk::http::server::getConnNamespace $connId] conn conn

      log Notice "handleRequest: working on $conn(chan)"
}

proc ::wtk::http::sm::cleanupRequest { connId } {

    # what to do here?
    log Notice "cleanupRequest: Finished with $connId"
    # unconfigure the reader
    fileevent $conn(chan) readable
}