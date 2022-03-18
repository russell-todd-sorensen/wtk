# Tcl Templating Tool: ttt

namespace eval ::wtk::ttt {

    variable binDir [file join [file dirname [file dirname [info script]]] bin]

    namespace import -force ::wtk::log::log
}

proc ::wtk::ttt::applyTemplate {{template ""}} {

    variable binDir
    set script [info script]
    set directory [file dirname $script]

    if {$template eq ""} {
        set template [file tail [file rootname $script]]
    }

    set tmplFile  [file join $directory $template.tmpl]
    set cmpFile   [file join $directory $template.cmp]
    set tmpFile   [file join $directory $template.tmp]
    
    if {![file exists $tmplFile]} {
        log Error "::wtk::ttt::applyTemplate $tmplFile does not exist"
        return [list 500 "Internal Server Error" "::wtk::ttt::applyTemplate $tmplFile does not exist"]
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
            global errorInfo
            set msg "ttt::respond: '$err', errorInfo:'$errorInfo'"
            log Error $msg
            return [list 500 "Internal Server Error" $msg]
        }
    }

    uplevel 1 [list source $cmpFile]
    upvar __string __string

    return [list 200 ok $__string]
}

proc ::wtk::ttt::applyTemplateNS {{template ""}} {

    variable binDir
    set script [ns_url2file [ns_conn url]]
    set directory [file dirname $script]

    if {$template eq ""} {
        set template [file tail [file rootname $script]]
    }

    set tmplFile  [file join $directory $template.tmpl]
    set cmpFile   [file join $directory $template.cmp]
    set tmpFile   [file join $directory $template.tmp]
    
    if {![file exists $tmplFile]} {
        log Error "::wtk::ttt::applyTemplate $tmplFile does not exist"
        return [list 500 "Internal Server Error" "::wtk::ttt::applyTemplate $tmplFile does not exist"]
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
            global errorInfo
            set msg "ttt::respond: '$err', errorInfo:'$errorInfo'"
            log Error $msg
            return [list 500 "Internal Server Error" $msg]
        }
    }

    uplevel 1 [list source $cmpFile]
    upvar __string __string

    return [list 200 ok $__string]
}