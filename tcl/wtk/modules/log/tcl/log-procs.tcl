# ::wtk::log module


namespace eval ::wtk::log {

    variable logChannel stderr
    variable debug 0
    variable SUPPORTS_MICROSECONDS [expr {[catch {clock microseconds}]} ? 0 : 1]
}

proc ::wtk::log::log {level message} {

    variable logChannel
    variable debug
    variable SUPPORTS_MICROSECONDS

    if {!$debug && $level eq "Debug"} {
        return
    }

    # NOTE ON CLOCK FORMAT:
    # including the microseconds into the clock format causes ::tcl::clock::format
    # to create a new proc for every invocation. Fix is to use a placeholder \$microseconds
    # and then to substitute the microseconds value into the string after [clock format] is
    # finished.
    if {$SUPPORTS_MICROSECONDS} {
        # log Notice "REALLY SUPPORTS MICROSECONDS!!!"
        set time [clock microseconds]
        set seconds [string range $time 0 end-6]
        # this is really microseconds
        set microseconds ".[string range $time end-3 end]"
    } else {
        set seconds [clock seconds]
        set microseconds ""
    }
    set dateTimeFormatted [clock format $seconds -format "%Y-%m-%d %T\$microseconds GMT" -gmt true]
    set dateTimeSubst [subst $dateTimeFormatted]
    puts $logChannel "\[$dateTimeSubst\] $level \"$message\""
}

namespace eval ::wtk::log {
    namespace export log
}

::wtk::log::log Notice "Finished Loading log-procs.tcl"