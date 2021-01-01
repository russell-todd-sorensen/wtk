#!/usr/bin/env /usr/bin/sh
# the next line restarts using tclsh \
exec /web/servers/devel/bin/tclsh8.7 "$0" ${1+"$@"}

if {0} {
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
}

source /web/servers/devel2/servers/devel2/tcl/wtk/init.tcl


namespace eval ::wtk::node {
    variable requestId 0
    variable initialized 0
    variable host localhost
    variable port 3000
    variable tmpDir
    variable jsonFile
    variable reqFile
    variable resFile
    variable jsonFd
    variable reqFd
    variable resFd
}

proc ::wtk::node::post { } {

}

proc ::wtk::node::get { } {

}

proc ::wtk::node::init { argv } {

}

puts stderr "command = $argv0 args=$argv"