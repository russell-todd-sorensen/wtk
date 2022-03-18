# Setup minutely updates for workbox's sw.js
# Reason: this is a development server and cached files suck
#

namespace eval ::wtk::workbox {
    variable version 0.1
    variable initialized false
    variable interval 60 ;# seconds
    variable binary "workbox"
    variable server [ns_info server]
    variable serverRoot [ns_server -server $server serverdir]
    variable pageroot [ns_server -server $server pagedir]
    variable swDirectory "$serverRoot/workbox"
    variable config "$swDirectory/workbox-config.js"
    variable swFile "$pageroot/sw.js"

    namespace import -force ::wtk::log::log
}

proc ::wtk::workbox::init {} {
    variable config
    variable swDirectory
    variable swFile
    variable initialized
    variable pageroot
    variable interval

    if {[file readable $config] 
        && [file type $swDirectory] == "directory"
        && [file writable $swDirectory]
        && (
            ![file exists $swFile] 
            ||
            [file writable $swFile]
        )
    } {
        set initialized true
    } else {
        log Error "::workbox::init Unable to initialize workbox at $swFile"
        log Notice "file readable $config = [file readable $config]"
        log Notice "file type $swDirectory = [file type $swDirectory]"
        log Notice "file writable $swDirectory = [file writable $swDirectory]"
        log Notice "file exists $swFile = [file exists $swFile]"
        log Notice "file writable $swFile = [file writable $swFile]"
        
        return $initialized
    }
    log Notice "::workbox scheduling generateSW every $interval sec"
    ::ns_schedule_proc -thread $interval ::wtk::workbox::generate
    return $initialized
}

proc ::wtk::workbox::generate { {override {}} } {
    variable initialized
    variable binary
    variable pageroot
    variable swFile
    variable config

    if {[llength $override] > 0} {
        foreach {var val} $override {
            set $var $val
        }
    }

    if {!$initialized} {
        if {![init]} {
            log Error "workbox::generate unable to initialize"
            return -code error
        }
    }
    exec -ignorestderr $binary generateSW $config
}
