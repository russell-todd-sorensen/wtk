#!/bin/bash

if /web/servers/ns/modules/tcl/wtk/tcl/wtk/modules/ttt/c-bug/t3 < $1.tmpl > $1.tmp ; then
 ln -f $1.tmp $1.cmp;
fi


