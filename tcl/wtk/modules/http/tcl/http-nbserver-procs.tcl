# Http Server procs for non-blocking reads

# Assumes chan is in non-blocking mode
proc ::wtk::http::server::nbReadHeader { connId } {

    namespace upvar [getConnNamespace $connId] conn conn

    set chan [set conn(chan)]

    # Use temporary storage for new header line
    set conn(prevLine) $conn(line)
    set conn(line) ""
    set numChars [gets $chan conn(line)]

    if {![chan blocked $chan]} {
        # got full line
        if {[addRequestHeader $conn]} {
            #finished Headers
        }
    } else {
        # partial line
    }
}

proc ::wtk::http::server::nbReadRequestBody { connId } {

    namespace upvar [getConnNamespace $connId] conn conn

    set chan $conn(chan)

    chan configure $chan -translation binary ;#-blocking false -encoding binary

    # Note that this will be changed to makeSecureFd!
    set filename [makeSecureName XXXXXXX.data]
    set fd [open /tmp/$filename w+]
    log Notice "writing data to file $filename"

    fconfigure $fd -translation binary -encoding binary ;#-blocking false -buffering full
    #set data [read $chan]
    #puts -nonewline $fd $data

    chan copy $chan $fd -command [list nbCloseFd $fd]
    close $fd

}

proc ::wtk::http::server::nbCloseFd { fd {bytesRead 0} {errorMsg ""} } {

    log Notice "nbCloseFd: closing $fd after $bytesRead bytes read"

    if { !( $errorMsg eq "" ) } {
        log Error "nbCloseFd: error writing $fd: '$errorMsg'"
    }

    close $fd
}



proc ::wtk::http::server::getRequestContentLength { connId } {

    namespace upvar [getConnNamespace $connId] conn conn

    if {![string is integer -strict\
              [set conn(requestContentLength) [::wtk::nv::nvGet conn(HeaderSet) content-length]]]
    } {
        set conn(requestContentLength) 0
    }

    return $conn(requestContentLength)
}

# proc: addRequestHeader
# args:
#    connId -- Input connId, to access data structure
# return value:
#
#    boolean value indicating end of headers
#    1 = end of headers

proc ::wtk::http::server::addRequestHeader { connId } {

    namespace upvar [getConnNamespace $connId] conn conn

    set returnValue 0
    #following line needs tcl 8.6
    #switch -regexp -matchvar headerList -- $conn(line)
    switch -regexp -- $conn(line) {

        "([-_a-zA-Z0-9]+): (.*)" {
            regexp {([-_a-zA-Z0-9]+): (.*)} $conn(line) match headerName headerValue
            #log Notice "Well Formed line: key = '[lindex $headerList 1]' value = '[lindex $headerList 2]'"
            #set key [lindex $headerList 1]
            #set value [lindex $headerList 2]
            log Notice "Well Formed line: key = '$headerName' value = '$headerValue'"
            #nvPut conn(HeaderSet) $key [string trim $value]
            nvPut conn(HeaderSet) [string tolower $headerName] [string trim $headerValue]
        }
        " (.*)" {
            regexp { (.*)} $conn(line) match
            #log Notice "Continuation line: headerList = '[lindex $headerList 0]'"
            log Notice "Continuation line: headerList = '$match'"
            # somehow append this to the last header.
            set headerIndex [expr [size conn(HeaderSet)] -1]
            set currLine [nvValue conn(HeaderSet) $headerIndex]
            #append currLine [lindex $headerList 1]
            append currLine $match
            nvUpdateValue conn(HeaderSet) $headerIndex $currLine
            log Notice "New HeaderValue: '$currLine'"

        }
        "[ \t\r\n]*" {
            log Notice "found document start '[set conn(line)]'"
            # this exits the while, not the switch
            set returnValue 1
        }
        default {
            log Warning "Malformed Line = [set conn(line)]"
            continue
        }
    }

    return $returnValue
}

proc ::wtk::http::server::nbReadHeaderContinue { connId } {



}
