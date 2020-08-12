#!/usr/bin/env /web/servers/devel/bin/tclsh8.7

#if /srv/www/geek-tools/wtk/tcl/wtk/modules/t3/bin/t3 < $1.tmpl > $1.tmp ; then
# ln -f $1.tmp $1.cmp;
#fi
#!/bin/sh
# the next line restarts using tclsh \
exec /web/servers/devel/bin/tclsh8.7 "$0" ${1+"$@"}

puts [info vars]