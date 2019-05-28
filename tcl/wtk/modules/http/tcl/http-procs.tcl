# HTTP Server and Client Procs
set fileDirectory [file dirname [info script]]
::wtk::modules::sourceFile [file join $fileDirectory http-server-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory http-nbserver-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory http-client-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory mime-types.tcl]
::wtk::modules::sourceFile [file join $fileDirectory response-codes.tcl]
::wtk::modules::sourceFile [file join $fileDirectory http-sm-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory http-sm-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory sha-procs.tcl]
namespace eval ::wtk::http {

    variable version 1.0

    # urlRegularExpression is used to pull an http(s) url
    # into the following parts:
    #
    #     url = https://www.x.com:8080/path1/path2/x.html?p=t;r=s&top=no
    #***
    #   match = https://www.x.com:8080/path1/path2/x.html?p=t;r=s&top=no
    #  proto+ = https://
    #   proto = https
    #    host = www.x.com:8080
    #   slash = /
    #   path = path1/path2/x.html
    #  query+ = ?p=t;r=s&top=no
    #     ?/# = ?
    #  query- = p=t;r=s&top=no

    # Note1: The one required component is the slash /
    # Note2: The input should be trimmed of whitespace

    variable urlRegularExpression {
        \A((http(?:s)?)://)?
        ([a-zA-Z0-9\.\:]+)?
        (/)
        ([^\?\#]{0,})?
        (([?\#])((?:.){0,}))?\Z
    }

    namespace import -force ::wtk::log::log
    namespace import -force ::wtk::nv::*
}

proc ::wtk::http::urlValidate { url {returnArray URL} } {

    variable urlRegularExpression

    upvar 1 $returnArray x

    return [regexp -expanded -nocase -- {
        \A((http(?:s)?)://)?
        ([a-zA-Z0-9\.\:]+)?
        (/)
        ([^\?\#]{0,})?
        (([?\#])((?:.){0,}))?\Z
    } $url x(match) x(proto+) x(proto) x(host) x(slash) x(path)\
        x(query+) x(?/\#) x(query-)]
}

# Following takes a given pageroot and path and makes sure that
# Path is under pageroot.
# Example: pageroot = /x/y/z
#
#       path  = ../b/c/x.html
#       first = b/c/x.html          <= after inner join and normalization
#       lastl = /x/y/z/b/c/x.html   <= after final join
#********************
#
#        path  = t/u/v/w/x/../../..//.///x.html
#       first = t/u/x.html          <= after inner join and normalization
#       lastl = /x/y/z/t/u/x.html   <= after final join

proc ::wtk::http::normalizePath { pageroot path } {

    file join $pageroot\
        [string trimleft\
            [file normalize\
            [file join / $path] ] /]
}


proc ::wtk::http::getResponseString { responseCode } {

    variable HttpResponseCodes

    nviGet $HttpResponseCodes $responseCode
}
