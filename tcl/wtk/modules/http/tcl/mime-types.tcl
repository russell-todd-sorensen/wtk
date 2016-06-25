set fileDirectory [file dirname [info script]]

set fd [open [file join [file dirname $fileDirectory] mime-types mime.types] r]

while {![eof $fd] && [gets $fd line] > -1} {

    set type [lindex $line 0]
    foreach extension [lrange $line 1 end] {
	set ::wtk::http::mimeType($extension) $type
    }
}
    
catch {
    close $fd
}
