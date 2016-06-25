set sock [socket 192.168.1.23 -port 8080]

puts $sock "GET /test.html HTTP/1.1\r
Host: 192.168.1.23:8080\r
Accept: nothing less\r
\r
"

flush $sock

set response [read $sock]

puts $response