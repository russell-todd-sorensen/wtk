#!/usr/bin/tclsh

source /www/tcl/wtk/init.tcl

set fd [makeSecureFd XXXXXXXX.XXX "/home/russell"]

if {$fd == 0} {
    puts "problem creating $fd"
    return
}

puts "created fd $fd"


chan puts $fd "this file does not exist but I'm putting stuff into it"
chan flush $fd
set position [chan tell $fd]
puts "fd is in position $position"
chan seek $fd 0 start
puts "fd is in position [chan tell $fd]"
set data [chan read $fd]
puts "read '$data' from fd"
puts "fd is in position [chan tell $fd]"

chan close $fd

puts "finished"