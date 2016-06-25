# conn procs
# Setup http connection information 
# and handle the request

namespace eval ::wtk::conn {

    variable version 1.0
    variable form ;# form as an nvlist
    variable formdata ;# fd to form data file
    variable formfiles ;# dictionary of file uploads in a form
    variable initialized 0
    variable ifd NULL
    variable ofd NULL
    variable method ;# GET or POST
    variable queryString ""
    variable inputCookies  [list]
    variable outputCookies [list]
    variable outputHeaders [list]
    variable inputCookieCount 0
    variable content
    variable contentLength
    variable contentType
    variable requestContentLength
    variable requestContentType

    namespace import ::wtk::log::log

}

proc ::wtk::conn::init { {iolist {stdin stdout}} } {

    variable initialized

    if {$initialized} {
	return $initialized
    }
    
    global env

    variable ifd [lindex $iolist 0]
    variable ofd [lindex $iolist 1]
    variable method
    variable queryString
    variable form
    variable inputCookies [list]
    variable contentType NULL
    variable content ""
    variable requestContentLength 0
    variable requestContentType ""
    variable formdata

    #
    # Do other setup as required
    #

    # Extract request method
    if {[info exists env(REQUEST_METHOD)]} {
	set method $env(REQUEST_METHOD)
    } else {
	set method "GET"
    }
    
    # get any query info:
    if {$method eq "POST"} {
	chan configure $ifd -translation binary -encoding binary
	set requestContentLength $env(CONTENT_LENGTH)
	set requestContentType $env(CONTENT_TYPE)
	set queryString [read $ifd $requestContentLength]
	log Notice "queryString '$queryString'"
	set formdata [makeSecureFd XXXXXXXX.XXX "/tmp"]
	puts $formdata "env: [join [array get ::env] \n]"
	puts -nonewline $formdata $queryString
	set filename /tmp/[makeSecureName XXXXXXXXXX]
	set fd [open $filename  wb+]
	fconfigure $fd -translation binary
	puts -nonewline $fd $queryString
	::wtk::log::log Notice "Created file $filename"
	close $fd
    } elseif {$method eq "GET" && [info exists env(QUERY_STRING)]} {
	set queryString $env(QUERY_STRING)
    } else {
	set queryString ""
    }

    # parse query
    parseQueryToNVSet form

    # get cookies
    ::wtk::conn::getCookies

    set initialized 1
    # Return success

    return $initialized
}

# Not to be called from anything bug conn::init
proc ::wtk::conn::getCookies { } {

    global env

    variable inputCookies
    variable inputCookieCount 0

    if {[info exists env(HTTP_COOKIE)]} {
	set cookieString [string trim $env(HTTP_COOKIE)]
    } else {
	set cookieString ""
    }

    # This is a simplified cookie monster
    set cookieList [split $cookieString ";"]

    ::wtk::nv::create inputCookies

    foreach cookie $cookieList {

	lassign [split $cookie =] key value
	::wtk::nv::nvPut inputCookies [string trim $key] [string trim $value]
	incr inputCookieCount
    }

    return $inputCookieCount
}

# user proc
proc ::wtk::conn::getCookie {cookieName} {

    variable initialized

    if {!$initialized} {
	init
    }

    variable inputCookies
    variable inputCookieCount

    if {!$inputCookieCount} {
	return NULL
    }
    
    return [::wtk::nv::nviGet form $cookieName]
}


proc ::wtk::conn::returnConn {
    {resultContent ""}
    {content_type "text/html"}
    {extraHeaderList {}}
}  {

    variable initialized

    if {!$initialized} {
	init
    }

    variable outputHeaders
    variable ofd
    variable contentType
    variable content

    if {[set size [::wtk::nv::size outputHeaders]] > -1} {
	for {set i 0} {$i < $size} {incr i} {
	    puts $ofd "[::wtk::nv::nvKey outputHeaders $i]: [::wtk::nv::nvValue outputHeaders $i]\r"
	}
    }
    
    # contentType variable overrides proc argument
    if {$contentType ne "NULL"} {
	set content_type $content_type
    } else {
	set contentType $content_type
    }
    
    if {$content ne ""} {
	set resultContent $content
    }
    
    # This will evolve quickly

    set date [clock format [clock seconds] -format "%a, %d %b %G %T GMT" -gmt 1]
    puts $ofd "Date: $date\r"
    puts $ofd "Content-Type: $contentType\r"
    puts $ofd "Set-Cookie: SessionID=\"1234567890\"; Path=/; max-age=600\r"
    puts $ofd "Length: [string length $resultContent]\r"
    puts $ofd "\r" ;# gap between headers and content
    puts -nonewline $ofd $resultContent

}


proc ::wtk::conn::parseQueryToNVSet {

 {nvSet QUERY}

} {

    upvar 1 $nvSet QUERY

    variable queryString
    variable requestContentLength
    variable requestContentType
    variable method

    if {$method eq "GET" ||
	$requestContentType eq "application/x-www-form-urlencoded"
    } {
	::wtk::nv::create $nvSet

	set length [string length $queryString]

	set queryTerms [split $queryString ";&"]
	    
	foreach term $queryTerms {
	    ::wtk::nv::nvPut QUERY {*}[split $term "="]
	    #log Notice "QUERYTERM=([split $term =])"
	}
    } else {
	::wtk::log::log Notice "............Content-Type: $requestContentType
method: $method"
    }

    return $nvSet
}





