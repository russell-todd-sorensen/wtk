#!/usr/bin/sh
# the next line restarts using tclsh \
exec /web/servers/devel/bin/tclsh8.7 "$0" ${1+"$@"}

set ::myvars [info vars]

foreach var $::myvars {
    puts "$var = '[set $var]'"
}