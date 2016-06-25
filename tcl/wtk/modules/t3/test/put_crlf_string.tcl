chan configure stdin  -translation crlf
chan configure stdout -translation crlf

source svg.tcl

puts -nonewline stdout $__string

