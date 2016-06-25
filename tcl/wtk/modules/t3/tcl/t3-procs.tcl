# Tcl Templating Tool: T3

namespace eval ::t3 {

    variable version 1.0
    variable binDir [file join [file dirname [file dirname [info script]]] bin]

    namespace import -force ::wtk::log::log
}

proc ::t3::respond { connId template contentType { responseCode 200 } } {

    variable binDir
    
    namespace upvar [::wtk::http::server::getConnNamespace $connId] conn conn

    set directory [file dirname [info script]]
    set tmplFile  [file join $directory $template.tmpl]
    set cmpFile   [file join $directory $template.cmp]
    set tmpFile   [file join $directory $template.tmp]
    
    if {![file exists $tmplFile]} {
        log Error "t3::respond $tmplFile does not exist"
        return -code error "t3::respond $tmplFile does not exist"
    }
    set cmpExists [file exists $cmpFile]
    if {!$cmpExists || 
        ( $cmpExists &&
          [file mtime $tmplFile] > [file mtime $cmpFile]
          )
    } {
        # recompile tcl file
        if {[catch {
            exec -ignorestderr [file join $binDir ttt.sh] [file join $directory $template]
        } err]} {
            log Error "t3::respond: '$err'"
            return -code error $err
        }
    }

    uplevel 1 [list source $cmpFile]
    upvar __string __string

    set conn(contentType) $contentType
    set conn(content) $__string

    ::wtk::http::server::respond $connId $responseCode OK
    
}