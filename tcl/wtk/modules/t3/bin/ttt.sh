#!/bin/bash

if /srv/www/geek-tools/wtk/tcl/wtk/modules/t3/bin/t3 < $1.tmpl > $1.tmp ; then
 ln -f $1.tmp $1.cmp;
fi


