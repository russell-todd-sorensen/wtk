
set urls {
    http://www.x.com/
    /x.htmp
    /x.html?y=2
    http://www.x.com/x.html
    http://www.x.com:8080/x.html
    https://www.x.com:8080/x.html
    https://www.x.com:8080/path1/path2/x.html?p=t;r=s
    /\#myref
    /
    something.html
}


foreach url $urls {
    array unset x
    regexp -expanded -nocase -- {
	(http(s)?://)?
	([a-zA-Z0-9\.\:]+)?
        (/)
	([^\?\#]{0,})?
	(([?\#])((.){0,})?)?
    } $url x(match) x(proto) x(https) x(host) x(slash) x(path)\
	x(query+) x(qorh) x(query-) x(extra1) x(extra2) x(extra3)

    puts "***********************************\n"
    puts "**** [format %7s url] = $url  *****"
    if {[array exists x]} {

	foreach key {url match proto https host slash path query+ qorh query- extra1 extra2 extra3} {

	    if {[info exists x($key)]} {
		puts "[format %12s $key] = $x($key)"
	    }

	}

	#puts " *** about = [regexp -about -expanded -nocase -- {(http(s)?://)?([a-zA-Z0-9\.\:]+)?((/)([^\?\#])+)([?\#]?(.)*)?} $url]"
    } else {
	puts "url = $url"
	puts "No Match!"
    }
    
}