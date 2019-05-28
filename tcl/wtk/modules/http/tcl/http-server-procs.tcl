# http-server-procs.tcl

namespace eval ::wtk::http::server {

    variable version 1.0
    variable port 80
    variable address *
    variable hostname ""
    variable pageroot "/srv/www/htdocs"
    variable addrToServerMap
    variable serverCounter 0
    variable conns    ;# this is an array
    variable connCounter 0
    variable connData ;# This is an array
    namespace import -force ::wtk::log::log
    namespace import -force ::wtk::nv::*
}

proc ::wtk::http::server::listen { address_ port_ {hostname_ ""} {pageroot_ ""} {async 0} } {

    variable address
    variable port
    variable hostname
    variable pageroot
    variable addrToServerMap
    variable serverCounter

    if {$hostname_ eq ""} {
        set hostname_ $address_
    }

    if {$port_ ne "80"} {
        append hostname_ :$port_
    }
    if {$pageroot_ eq ""} {
        set pageroot_ $pageroot
    }
    set serverId ht_$serverCounter
    incr serverCounter

    set addrToServerMap($address_:$port_) $serverId

    # Create child namespace for server:
    namespace eval $serverId {
        variable address
        variable port
        variable hostname
        variable pageroot
    }

    set ${serverId}::hostname $hostname_
    set ${serverId}::port $port_
    set ${serverId}::address $address_
    set ${serverId}::pageroot $pageroot_

    log Notice "http::listen setup pageroot for $serverId to $pageroot_"
    if {$async} {
        socket -myaddr $address_ -server ::wtk::http::server::acceptAsync $port_
    } else {
        socket -myaddr $address_ -server ::wtk::http::server::accept $port_
    }
}

proc ::wtk::http::server::getServerId { chan } {

    variable addrToServerMap

    set sockNameList [fconfigure $chan -sockname]
    log Notice "getServerId: sockNameList: '$sockNameList'"
    set key [lindex $sockNameList 0]:[lindex $sockNameList 2]

    return $addrToServerMap($key)
}

proc ::wtk::http::server::registerConn { serverId } {

    variable conns
    variable connCounter

    set connId conn$connCounter
    incr connCounter

    set conns($connId) $serverId
    return $connId
}

proc ::wtk::http::server::getPageroot { connId } {

    variable conns

    set $conns($connId)::pageroot
}

proc ::wtk::http::server::getServerIdFromConnId { connId } {

    variable conns

    set conns($connId)
}

proc ::wtk::http::server::getConnNamespace { connId } {

    variable conns

    return [namespace current]::$conns($connId)::$connId
}


proc ::wtk::http::server::accept { chan clientAddress clientPort } {

    set serverId [getServerId $chan]

    set connId [registerConn $serverId]

    log Notice "chan $chan \[getServerId $chan \] '$serverId', \[registerConn $serverId\] '$connId'"

    namespace eval ${serverId}::$connId {

      variable conn
      ::wtk::log::log Notice "in conn namespace '[namespace current]'"
    }

    #variable $conn
    namespace upvar ${serverId}::$connId conn conn

    # Create a header set:
    set conn(HeaderSet) [create conn(HeaderSet)]
    set conn(namespace) [getConnNamespace $connId]

    # Initial configuration requires -translation crlf to handle
    #   headers correctly. Later when reading the body, translation
    #   is changed to "binary" (i.e. lf).
    #
    # Set chan to blocking mode (-blocking true)
    # Until this is fixed, [gets] might run too quickly so as not to
    # get any data, and thus return -1.
    #
    # temp: start out with eol translation of auto!
    chan configure $chan -translation auto -encoding binary -blocking 1 -buffering full

    log Notice "$connId clientAddress: $clientAddress clientPort: $clientPort"
    set conn(clientAddress) $clientAddress
    set conn(clientPort) $clientPort
    set conn(content) ""
    set conn(contentType) "text/plain"
    set conn(date) [clock format [clock seconds] -format "%a, %d %b %G %T GMT" -gmt 1]
    set conn(chan) $chan

    # setup a temp file to read request into. parse later:
    set conn(requestFilename) [makeSecureName XXXXXXX.request]
    set conn(requestFd) [open [file join [getPageroot $connId] forms data $conn(requestFilename)] w+]

    # request/headers Fd will start out as translation crlf/auto:
    fconfigure $conn(requestFd) -translation auto -encoding binary -buffering full -blocking 1

    if {[gets $chan conn(request)] == -1} {
        log Error "bad request"
        log Error "chan pending = [chan pending input $chan]"
        respondBadRequest $connId
        return -code return
    } else {
        log Notice "Got request '$conn(request)'"
        puts $conn(requestFd) $conn(request)
    }

    log Notice "About to read rest of document"

    while {![eof $chan]} {

        gets $chan conn(line)

        if {[addRequestHeader $connId]} {
            break
        }
        # add to requestFd:
        puts $conn(requestFd) $conn(line)
    }

    # cleanup requestFd
    flush $conn(requestFd)
    close $conn(requestFd)

    # Look for Content-Length header:
    set requestContentLength [getRequestContentLength $connId]

    log Notice "got document of Content-Length: '$requestContentLength'"

    if {$requestContentLength > 0} {

        # We are going to read the document body, so we need to switch to full
        #   binary/non-blocking mode:
        # Note that non-blocking mode works here, because we use [chan copy]

        chan configure $chan -translation binary -blocking true -encoding binary

        # Note that this will be changed to makeSecureFd!
        set filename [makeSecureName XXXXXXX.data]
        set fd [open [file join [getPageroot $connId] forms data $filename] w+]

        log Notice "writing data to file $filename"

        #set fd [makeSecureFd XXXXXXXXXX /home/russell/www/forms/data]
        fconfigure $fd -translation binary -encoding binary -blocking true -buffering full
        set data [read $chan $requestContentLength]
        puts -nonewline $fd $data

        set conn(formFd) $fd
        set conn(formFile) $filename
        set conn(formFileLink) data/$filename
        set copyLength [string length $data]
    } else {
        set copyLength "N/A (no data)"
    }

    log Notice "accept: finished with request document copyLength: $copyLength"

    chan configure $chan -translation binary -blocking true -encoding binary

    ::wtk::http::server::handleRequest $connId
}

# acceptAsync

proc ::wtk::http::server::acceptAsync { chan clientAddress clientPort } {

    log Notice "::wtk::http::server::acceptAsync for $chan"

    set serverId [getServerId $chan]

    set connId [registerConn $serverId]

    log Notice "chan $chan \[getServerId $chan \] '$serverId', \[registerConn $serverId\] '$connId'"

    namespace eval ${serverId}::$connId {

      variable conn
      ::wtk::log::log Notice "acceptAsync: in conn namespace '[namespace current]'"
    }

    log Notice "before namespace upvar for $connId"

    if {[catch {
        namespace upvar ::wtk::http::server::${serverId}::$connId conn conn
    } err ]} {
       log Error "namespace upvar error: $err"
       return -code return
    }

    # Create a header set:
    set conn(HeaderSet) [create conn(HeaderSet)]
    set conn(namespace) [getConnNamespace $connId]

    log Notice "$connId clientAddress: $clientAddress clientPort: $clientPort"
    set conn(clientAddress) $clientAddress
    set conn(clientPort) $clientPort
    set conn(content) ""
    set conn(contentType) "text/plain"
    set conn(date) [clock format [clock seconds] -format "%a, %d %b %G %T GMT" -gmt 1]
    set conn(chan) $chan

    set pending [chan pending input $conn(chan)]
    log Notice "acceptAsync: pending on $conn(chan): $pending bytes"

    # setup a temp file to read request into. parse later:
    #set conn(requestFilename) [makeSecureName XXXXXXX.request]
    #set conn(requestFd) [open [file join [getPageroot $connId] forms data $conn(requestFilename)] w+]
    set conn(requestFd) [makeSecureFd XXXXXXX.request [file join [getPageroot $connId] forms data]]
    # Initial configuration requires -translation crlf to handle
    #   headers correctly. Later when reading the body, translation
    #   is changed to "binary" (i.e. lf).

    # Configure client socket (chan) to read any line ending (<CR>, <CR><LF> or <LF>)
    # RequestFd will fix line endings (but the data isn't used in Async mode).
    chan configure $chan -translation {auto binary} -encoding binary -blocking 0 -buffering full
    chan configure $conn(requestFd) -translation binary -encoding binary -buffering full -blocking 0

    chan event $conn(chan) readable [list ::wtk::http::server::processRequestLineAsync $connId]
    log Notice "acceptAsync: finished setting up events"
}

proc ::wtk::http::server::processRequestLineAsync { connId } {

    namespace upvar [getConnNamespace $connId] conn conn

    if {[gets $conn(chan) conn(request)] == -1} {
        set delay 1
        log Notice "delaying request $delay ms on $conn(chan) ..."
        after $delay

        if {[gets $conn(chan) conn(request)] == -1} {
            log Error "bad request"
            respondBadRequest $connId
            close $conn(chan)
            return -code return
        }
    } else {
        log Notice "processRequestLineAsync: Got request line '$conn(request)'"
        if {[catch {
            puts  -nonewline $conn(requestFd) $conn(request)\r\n
            flush $conn(requestFd)
            #flush $conn(chan)
        } err ]} {
            log Error "processRequestLineAsync: failed to puts/flus to $conn(requestFd)"
            log Error $err
            set error [list 500 $err]
            respondInternalError $connId $err
            close $conn(requestFd)
            return -code return
        }

        log Notice "processRequestLineAsync: flushed request to $conn(requestFd)"
    }

    log Notice "processRequestLineAsync: about to configure event proc processHeaderAsync"
    # Replace event handler, moving on to headers:
    chan event $conn(chan) readable [list ::wtk::http::server::processHeaderAsync $connId]
    log Notice "processRequestLineAsync: finished with conn $connId, moving on to processHeaderAsync"
}



proc ::wtk::http::server::processHeaderAsync { connId } {

    namespace upvar [getConnNamespace $connId] conn conn

    log Notice "processHeaderAsync starting for conn $connId..."
    if {![eof $conn(chan)]} {
        log Notice "processHeaderAsync about to get header line for conn $connId..."
        gets $conn(chan) conn(line)
        log Notice "processHeaderAsync got header line for conn $connId: $conn(line)"

        global errorInfo
        set errorInfo ""
        if {[catch {
            if {[addRequestHeader $connId]} {

                log Notice "processHeaderAsync: end of headers found"

                # cleanup requestFd
                #flush $conn(requestFd)
                #close $conn(requestFd)

                # Remove event handler:
                chan event $conn(chan) readable ""

                # Look for document following headers:
                set requestContentLength [getRequestContentLength $connId]
                log Notice "got document of Content-Length: '$requestContentLength'"

                if {$requestContentLength > 0} {

                    set conn(formFile) [makeSecureName XXXXXXX.data]
                    set conn(formFd) [open [file join [getPageroot $connId] forms data $conn(formFile)] w+]
                    set conn(formFileLink) data/$conn(formFile)

                    log Notice "processHeaderAsync: Found Form Document. Background Copy to: '$conn(formFile)'"

                    # Get ready to fcopy document to file, read data as binary
                    fconfigure $conn(chan) -translation {binary binary} -encoding binary -blocking false -buffering full
                    fconfigure $conn(formFd) -translation binary -encoding binary -blocking false -buffering full

                    # Client guaranteed requestContentLength bytes to follow:
                    chan copy $conn(chan) $conn(formFd) -size $requestContentLength \
                         -command [list ::wtk::http::server::finishDocumentAsync $connId ]

               } else {
                    chan event $conn(chan) writable [list ::wtk::http::server::handleRequestAsync $connId ]
                    log Notice "processHeaderAsync: requestContentLength = 0, scheduled handleRequestAsync $connId"
               }
               # return before appending blank line:
               log Notice "processHeaderAsync: returning before blank line"
               return -code return
            }
        } err]} {
            if {$err == "" && $errorInfo == ""} {
               # do nothing, not really an error
            } else {
                log Error "Unable to read headers..."
                log Error $err
                log Error "errorInfo: $errorInfo"
                set error [500 "$err\n$errorInfo"]
                respondInternalError $connId "$err\r\n$errorInfo"
            }
        }
        # add to requestFd:
        log Notice "processHeaderAsync: appending blank line to requestFd for $conn(chan)"
        puts -nonewline $conn(requestFd) $conn(line)\r\n
    }
}

# This proc is necessary to re-enable channel event after chan copy
# Also allows \[chan copy] to return outBytes and errorString
proc ::wtk::http::server::finishDocumentAsync { connId outBytes {errorString ""} } {

    namespace upvar [getConnNamespace $connId] conn conn
    log Notice "finishDocument: finished copying document to $conn(formFile) outBytes = $outBytes errorString = '$errorString'"
    chan event $conn(chan) writable [list ::wtk::http::server::handleRequestAsync $connId ]
}

# Old Async proc
proc ::wtk::http::server::processRequestAsync2 { connId } {

    namespace upvar [getConnNamespace $connId] conn conn

    # setup a temp file to read request into. parse later:
    set conn(requestFilename) [makeSecureName XXXXXXX.request]
    set conn(requestFd) [open [file join [getPageroot $connId] forms data $conn(requestFilename)] w+]

    # request/headers Fd will start out as translation crlf/auto:
    fconfigure $conn(requestFd) -translation {auto binary} -encoding binary -buffering full -blocking 1

    if {[gets $conn(chan) conn(request)] == -1} {
        set delay 1
        log Notice "delaying request $delay ms on $conn(chan) ..."
        after $delay
        if {[gets $conn(chan) conn(request)] == -1} {
            log Error "bad request"
            log Error "chan pending: [chan pending input $conn(chan)]"
            respondBadRequest $connId
            close $conn(chan)
            return -code return
        }
    } else {
        log Notice "Got request '$conn(request)'"
        puts $conn(requestFd) $conn(request)
    }

    log Notice "About to read rest of document"

    while {![eof $conn(chan)]} {

        gets $conn(chan) conn(line)

        if {[addRequestHeader $connId]} {
            break
        }
        # add to requestFd:
        puts $conn(requestFd) $conn(line)
    }

    # cleanup requestFd
    flush $conn(requestFd)
    close $conn(requestFd)

    # Look for Content-Length header:
    set requestContentLength [getRequestContentLength $connId]

    log Notice "got document of Content-Length: '$requestContentLength'"

    if {$requestContentLength > 0} {

        # We are going to read the document body, so we need to switch to full
        #   binary/non-blocking mode:
        # Note that non-blocking mode works here, because we use [chan copy]

        chan configure $conn(chan) -translation binary -blocking true -encoding binary

        # Note that this will be changed to makeSecureFd!
        set filename [makeSecureName XXXXXXX.data]
        set fd [open [file join [getPageroot $connId] forms data $filename] w+]

        log Notice "writing data to file $filename"

        #set fd [makeSecureFd XXXXXXXXXX /home/russell/www/forms/data]
        fconfigure $fd -translation binary -encoding binary -blocking true -buffering full
        set data [read $conn(chan) $requestContentLength]
        puts -nonewline $fd $data

        set conn(formFd) $fd
        set conn(formFile) $filename
        set conn(formFileLink) data/$filename
        set copyLength [string length $data]
    } else {
        set copyLength "N/A (no data)"
    }

    log Notice "accept: finished with request document copyLength: $copyLength"

    chan configure $conn(chan) -translation binary -blocking true -encoding binary

    ::wtk::http::server::handleRequest $connId
}


proc ::wtk::http::server::handleRequestAsync { connId } {

    namespace upvar [getConnNamespace $connId] conn conn

    log Notice "handleRequestAsync...starting for connId conn(request) = $conn(request)"
    # Now look for file the user wants (assume spaces separate parts):
    global errorInfo
    set errorInfo ""

    if {[catch {

        lassign [split $conn(request)] conn(method) conn(url) conn(httpVersion)

        #set requestList [split $conn(request)]
        #set conn(method) [lindex $requestList 0]
        #set conn(url) [lindex $requestList 1]
        #set conn(httpVersion) [lindex $requestList 2]

        # validate url and pull into useful parts:
        ::wtk::http::urlValidate $conn(url) URL
        set conn(URL) [array get URL]
    } err]} {
        if {$err == "" && $errorInfo == ""} {
            # do nothing, not really an error
        } else {
            log Error "handleRequestAsync: $err"
            log Error "errorInfo: $errorInfo"
            respondInternalError $connId "$err\n$errorInfo"
        }
    }
    log Notice "$connId method = [set conn(method)] url = [set conn(url)]\
                httpVersion = [set conn(httpVersion)]"
    log Notice "handleRequestAsync: pageRoot = [getPageroot $connId]"
    #set conn(localFile) [::wtk::http::normalizePath [getPageroot $connId] $URL(path)]
    #set conn(localFile) [file join [getPageroot $connId] $URL(path)]
    set conn(localFile) [file join [getPageroot $connId] [::wtk::url::decode $URL(path)]]

    log Notice "localFile = $conn(localFile)"

    set error [list 0 ""]

    if {![file exists $conn(localFile)] && [string match */pages/* $conn(localFile)]} {
        set conn(localFile) [string map {/pages/ /} $conn(localFile)]
    }

    if {[file exists $conn(localFile)]} {

        log Notice "File $conn(localFile) exists"

        if {[file isfile $conn(localFile)]} {

            # regular file
            log Notice "File is regular file"

            set tail [file tail $conn(localFile)]
            set extension [string tolower [file extension $tail]]

            switch -exact -- $extension {
                .htm - .html {

                    # html, just return
                    log Notice "Got HTML File"
                    set htmlFd [open $conn(localFile) r]
                    fconfigure $htmlFd -translation binary -encoding binary -buffering full

                    set conn(contentLength) [file size $conn(localFile)]
                    set conn(contentType) "text/html"

                    set conn(content) [read $htmlFd $conn(contentLength)]
                    close $htmlFd

                    chan event $conn(chan) writable [list ::wtk::http::server::respondOK $connId]
                    log Notice "handleRequestAsync:html: $conn(contentLength) bytes to $connId"
                }
                .tcl {

                    log Notice "Got Tcl File"

                    if {[catch {
                        source $conn(localFile)
                    } err ]} {
                        set msg $err
                        log Error "[set ::errorInfo]"
                        set error [list 1 $msg]
                    }
                }
                .cmp {
                    log Error "User trying to access compiled template file $conn(localFile)"
                    set error [list 1 "Unauthorized access to compiled template"]
                }
                default {
                    log Notice "Got Other File Type '$extension'"
                    set extension [string tolower [string trimleft $extension .]]
                    # Lookup the extension and return:
                    if {[info exists ::wtk::http::mimeType($extension)]} {
                        set mimeType $::wtk::http::mimeType($extension)
                    } else {
                        set mimeType "*/*"
                    }

                    log Notice "handleRequestAsync:default: Mime-Type = '$mimeType'"
                    global errorInfo
                    set errorInfo ""
                    if {[catch {
                        # return file
                        set mimeFd [open $conn(localFile) r]
                        chan configure $mimeFd -translation binary -encoding binary -buffering full

                        set conn(contentLength) [file size $conn(localFile)]
                        set conn(contentType) $mimeType
                        set conn(content) [read $mimeFd $conn(contentLength)]

                        close $mimeFd

                        chan event $conn(chan) writable [list ::wtk::http::server::respondOK $connId]
                    } err]} {
                        if {$err == "" && $errorInfo == ""} {
                            # do Nothing
                        } else {
                            log Error "handleRequestAsync:default: $err"
                            log Error $errorInfo
                            set error [list 500 "$err\n$errorInfo"]
                            respondInternalError $connId "$err\n$errorInfo"
                            return -code return
                        }
                    }

                    log Notice "handleRequestAsync:default: $conn(contentLength) bytes to $connId"
                }
            }
        } elseif {[file type $conn(localFile)] eq "directory"} {
            # directory
            log Notice "File is directory $conn(localFile)"
            #set conn(localFile) [file join $pageroot glob-to.tcl]
            set handler [file join [getPageroot $connId] showIndex.tcl]
            set dir $conn(localFile)

            if {[catch {
                source $handler
            } err ]} {
                set msg $err
                log Error "[set ::errorInfo]"
                set error [list 1 $msg]
            }
        } elseif {[file type $conn(localFile)] eq "link"} {
            set linkedFile [file link $conn(localFile)]
            if {[file type $linkedFile] eq "directory"} {

                log Notice "Linked file is directory '$conn(localFile)' --> '$linkedFile'"
                set handler [file join [getPageroot $connId] showIndex.tcl]
                set dir $linkedFile

                if {[catch {
                    source $handler
                } err ]} {
                    set msg $err
                    log Error "[set ::errorInfo]"
                    set error [list 1 $msg]
                }
            } else {
                set msg "Link to to non-directory file not allowed"
                log Error $msg
                set error [list 1 $msg]
            }
        } else {
            set msg "File is type [file type $conn(localFile)], cannot handle it."
            log Error $msg
            set error [list 1 ...$msg]
        }

    } else {
        # This should generate a 404, not a 500!
        set msg "Unknown file $conn(localFile)"
        log Error $msg
        set error [list 404 $msg]
    }

    # Send out error message if necessary
    # error = [list num "msg"]

    if {[lindex $error 0]} {

        set conn(contentType) text/html

        switch -exact -- [lindex $error 0] {
            "404" {
                respondNotFound $connId [lindex $error 1]
            }
            default {
                respondInternalError $connId [lindex $error 1]
            }
        }
    }
}


proc ::wtk::http::server::handleRequest { connId } {

    namespace upvar [getConnNamespace $connId] conn conn

    # Now look for file the user wants (assume spaces separate parts):
    lassign $conn(request) conn(method) conn(url) conn(httpVersion)

    # validate url and pull into useful parts:
    ::wtk::http::urlValidate $conn(url) URL
    set conn(URL) [array get URL]

    log Notice "$connId method = [set conn(method)] url = [set conn(url)]\
                httpVersion = [set conn(httpVersion)]"

    set conn(localFile) [::wtk::http::normalizePath [getPageroot $connId] $URL(path)]

    log Notice "localFile = $conn(localFile)"

    set error [list 0 ""]

    if {[file exists [set conn(localFile)]]} {

        log Notice "File $conn(localFile) exists"

        if {[file isfile [set conn(localFile)]]} {

            # regular file
            log Notice "File is regular file"

            set tail [file tail [set conn(localFile)]]
            set extension [string tolower [file extension $tail]]

            switch -exact -- $extension {
                .htm - .html {

                    # html, just return
                    log Notice "Got HTML File"
                    set htmlFd [open [set conn(localFile)] r]
                    fconfigure $htmlFd -translation binary -encoding binary -buffering full

                    set conn(contentLength) [file size [set conn(localFile)]]
                    set conn(contentType) "text/html"

                    set conn(content) [read $htmlFd [set conn(contentLength)]]
                    close $htmlFd

                    #fileevent [set conn(chan)] writable [list ::wtk::http::server::respondOK $connId]
                    log Notice "Sending $conn(contentLength) bytes to $connId"
                    ::wtk::http::server::respondOK $connId
                }
                .tcl {
                    log Notice "Got Tcl File"
                    # source the file, which must write to chan?
                    #source $conn(localFile)
                    if {[catch {
                        source $conn(localFile)
                    } err ]} {
                        set msg $err
                        log Error "[set ::errorInfo]"
                        set error [list 1 $msg]
                    }
                }
                .cmp {
                    log Error "User trying to access compiled template file $conn(localFile)"
                    set error [list 1 "Unauthorized access to compiled template"]
                }
                default {
                    log Notice "Got Other File Type '$extension'"
                    set extension [string tolower [string trimleft $extension .]]
                    # Lookup the extension and return:
                    if {[info exists ::wtk::http::mimeType($extension)]} {
                        set mimeType $::wtk::http::mimeType($extension)
                    } else {
                        set mimeType "*/*"
                    }

                    log Notice "Mime-Type = '$mimeType'"

                    # return file
                    set mimeFd [open $conn(localFile) r]
                    chan configure $mimeFd -translation binary -encoding binary -buffering full

                    set conn(contentLength) [file size $conn(localFile)]
                    set conn(contentType) $mimeType
                    set conn(content) [read $mimeFd $conn(contentLength)]

                    close $mimeFd

                    chan event $conn(chan) writable [list ::wtk::http::server::respondOK $connId]

                    log Notice "handleRequest:default: $conn(contentLength) bytes to $connId"
                }

            }
        } elseif {[file type $conn(localFile)] eq "directory"} {
            # directory
            log Notice "File is directory $conn(localFile)"
            #set conn(localFile) [file join $pageroot glob-to.tcl]
            set handler [file join [getPageroot $connId] showIndex.tcl]
            set dir $conn(localFile)
            if {[catch {
                source $handler
            } err ]} {
                set msg $err
                log Error "[set ::errorInfo]"
                set error [list 1 $msg]
            }
        } elseif {[file type $conn(localFile)] eq "link"} {
            set linkedFile [file link $conn(localFile)]
            if {[file type $linkedFile] eq "directory"} {
                log Notice "Linked file is directory '$conn(localFile)' --> '$linkedFile'"
                set handler [file join [getPageroot $connId] showIndex.tcl]
                set dir $linkedFile
                if {[catch {
                    source $handler
                } err ]} {
                    set msg $err
                    log Error "[set ::errorInfo]"
                    set error [list 1 $msg]
                }
            } else {
                set msg "Link to to non-directory file not allowed"
                log Error $msg
                set error [list 1 $msg]
            }
        } else {
            set msg "File is type [file type $conn(localFile)], cannot handle it."
            log Error $msg
            set error [list 1 ...$msg]
        }

    } else {
        set msg "Unknown file $conn(localFile)"
        log Error $msg
        set error [list 1 $msg]
    }

    # Send out error message if necessary
    # error = [list num "msg"]

    if {[lindex $error 0]} {
        set conn(contentType) text/html
        chan event $conn(chan) writable [list ::wtk::http::server::respondInternalError $connId [lindex $error 1]]
    }
}

proc ::wtk::http::server::respond { connId responseCode description } {

    namespace upvar [getConnNamespace $connId] conn conn
    set chan $conn(chan)

    chan configure $chan -translation binary -encoding binary
    if {[info exists conn(contentLength)]} {
        set contentLength $conn(contentLength)
    } else {
        set contentLength [string bytelength $conn(content)]
    }
    puts $chan "HTTP/1.1 $responseCode $description
Date: [set conn(date)]
Connection: Close
Content-Length: $contentLength
Content-Type: $conn(contentType)
"

    puts -nonewline $chan $conn(content)
    flush $chan
    cleanup $connId
}

proc ::wtk::http::server::respondBadRequest { connId } {

    namespace upvar [getConnNamespace $connId] conn conn
    namespace upvar ::wtk::http::server Codes HttpResponseCodes

    set code 400
    set description [::wtk::http::getResponseCodeDescription $code]

    set conn(content) "<!DOCTYPE html>
<html>
<head>
 <title>Bad Request</title>
</head>
<body>
 <h2>Bad Request</h2>
 <p>Your request:</p>
 <pre>[set conn(request)]</pre>
 <p>Was not valid</p>
</body>
</html>"

    respond $connId $code $description
}

proc ::wtk::http::server::respondNotFound { connId {errorMsg ""} } {

    namespace upvar [getConnNamespace $connId] conn conn
    namespace upvar ::wtk::http::server Codes HttpResponseCodes

    set code 404
    set description [::wtk::http::getResponseCodeDescription $code]

    set conn(content) "<!DOCTYPE html>
<html lang='en_US'>
<head>
 <title>$description</title>
</head>
<body>
 <h2>$description</h2>
 <p>The url you requested was not found:</p>
 <pre>$errorMsg</pre>
</body>
</html>"

    respond $connId $code $description
}

proc ::wtk::http::server::respondOK { connId } {

    namespace upvar [getConnNamespace $connId] conn conn

    # Content is already set

    respond $connId 200 OK

}

proc ::wtk::http::server::respondInternalError { connId {errorMsg ""} } {

    namespace upvar [getConnNamespace $connId] conn conn

    if {$errorMsg eq ""} {
        set errorMsg [set errorInfo]
    }
    set conn(content) "<!DOCTYPE html>
<html>
<head>
 <title>Internal Server Error</title>
</head>
<body>
 <h2>Internal Server Error</h2>
 <p>Your request:</p>
 <pre>$conn(request)</pre>
 <p>could not be completed due to an internal server error</p>
 <pre>$errorMsg</pre>
</body>
</html>"

    respond $connId 500 "Internal Server Error"

}

proc ::wtk::http::server::cleanup { connId } {

    namespace upvar [getConnNamespace $connId] conn conn

    variable conns

    set cns $conn(namespace)

    log Notice "server::cleanup: Cleaning up $cns"

    flush $conn(chan)
    close $conn(chan)
    # also close open files?

    if {[info exists conn(formFd)]} {
        flush $conn(formFd)
        close $conn(formFd)
    }
    unset conns($connId)

    namespace delete $cns

    log Notice "server::cleanup: Cleaned up $cns"
}
