set ifd [open UTF-8-test.txt rb]
set ofd [open results.txt w+ ]
set lineNumber 0

while {![eof $ifd]} {
    set len [gets $ifd line]
    puts $ofd "[format %3.3d $lineNumber]: \
        [format %5.5d $len] \
        [format %5.5d [string length $line]] \
        [format %5.5d [string bytelength $line]] \
        [format %5.5d [string last "|" $line]] \
        >$line<"

    incr lineNumber
}

close $ofd
close $ifd

