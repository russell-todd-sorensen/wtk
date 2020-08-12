#!/usr/bin/sh
# the next line restarts using tclsh \
exec /web/servers/devel/bin/tclsh8.7 "$0" ${1+"$@"}


if {false} {
    set ::myvars [info vars]

    foreach var $::myvars {
        if {[array exists $var]} {
            puts "$var -- Array"
            set keys [lsort [array names $var]]
            foreach key $keys {
                puts "${var}($key) = [set ${var}($key)]"
            }
        } elseif {[info exists $var]} {
            puts "$var = '[set $var]'"
        } else {
            puts "$var is not initialized"
        }
    }
    puts ">>>>>>>>>>>>>>>>> END VARS <<<<<<<<<<<<<<<<<<<<"
}

switch -exact -- $argc {
    1 {
        set infile [lindex $argv 0]
        set fdIn [open $infile rb]
        set fdOut stdout
    }
    2 {
        set infile [lindex $argv 0]
        set fdIn [open $infile rb]
        set outfile [lindex $argv 1]
        set fdOut [open $outfile wb]
    }
    0 {
        set fdIn stdin
        set fdOut stdout
    }
    default {
        puts "usage: $argv0 ?\[infile\]? ?\[outFile\]?"
        puts "Examples:"
        puts "$argv0 < my-logs.txt > my-processed-file.txt"
        puts "cat my-logs.txt | $argv0 > my-processed-file.txt"
        puts "$argv0 < my-logs.txt (output to stdout)"
        puts "$argv0 my-logs.txt my-processed-file.txt"

        return
    }
}

set threadList [list]
set lineId 0

while {![eof $fdIn] && [gets $fdIn line] > -1} {
    switch -glob -- $line {
        "*-conn:devel:test:*" {
            set type logLine
        }
        "*conn-devel-test-*" {
            set type statLine
        }
        "*Previously Deleted*" {
            set type deletedStatLine
        }
        "* total: *" {
            set type statTotalLine
        }
        "*-driver:nssock:*" {
            set type driverLine
        }
        default {
            set type noType
        }
    }

    if {$type == "noType"} {
        continue
    } else {
        incr lineId
    }

    set cols [split $line ","]
    set numCols [llength $cols]



    puts $fdOut "$numCols,$lineId,$type,[join $cols ,]"
}

#puts $fdOut $fdIn
#puts $fdOut $fdOut