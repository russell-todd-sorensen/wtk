set port 8080
set address 192.168.1.23
source wtk/init.tcl

proc HttpServer {channel clientaddr clientport} {

    fconfigure $channel -translation crlf -encoding binary

    puts stderr "clientaddr: $clientaddr clientport: $clientport"

    set content "You sent us the following request line:\r\n"

    set date [clock format [clock seconds] -format "%a, %d %b %G %T GMT" -gmt 1]

    if {[gets $channel request] == -1} {
	puts stderr "bad request"
	puts $channel "HTTP/1.1 400 BAD REQUEST\r
Date: $date\r
Content-Length: 11\r
Content-Type: text/plain\r
\r
Bad Request"
	flush $channel
	close $channel
	return
    } else {
	puts stderr "Got request $request"
    }

    puts stderr "About to read rest of document"
    set contentLength 0
    while {![eof $channel]} {
	gets $channel line
	if {[regexp {\A[ \t\r\n]*\Z} $line]} {
	    puts stderr "found document start"
	    break
	} elseif {[string match "Content-Length: *" $line]} {
	    puts stderr "Found Content-Length line!"
	    set contentLength [string trim [lindex [split $line :] 1]]
	    puts stderr "Got contentLength = $contentLength"
	} else {
	    puts stderr "Line = $line"
	}
    }
	
    fconfigure $channel -translation binary
    set data [read $channel $contentLength]
    puts stderr "got document"


    append content "$request\r\n"
    set length [string length $content]
    puts -nonewline $channel "HTTP/1.1 200 OK\r
Date: $date\r
Content-Type: text/plain\r
Content-Length: $length\r
\r
$content"
    flush $channel
    close $channel

    # store away the data
    if {[string length $data] > 0} {
	set filename [makeSecureName XXXXXXX.data]
	::wtk::log::log Notice "writing data to file $filename"
	set fd [open /tmp/$filename wb+]
	fconfigure $fd -translation binary -encoding binary
	puts -nonewline $fd "$request\r\n$data"
	flush $fd
	close $fd
    } else {
	puts stderr "data length == 0 ($data)"
    }

}

socket -myaddr $address -server Server $port 
vwait forever
