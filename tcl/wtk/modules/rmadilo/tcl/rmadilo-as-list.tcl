# why not use tcl code to contain and display documentation?
global errorInfo 

proc ::var {args} {
    uplevel 1 variable {*}$args
}

namespace eval ::docs {
    var documents [list [list]]
}

namespace eval ::docs::topics {
    var topics {}
}

namespace eval ::docs::chapters {
    var chapters [list]
}

proc ::docs::new {key subject descr} {
    var documents

    set count [getCount $key]
    set next ${key}:${count}
    lappend documents [list $next $subject $descr]
    return $next
}



proc ::docs::getAll {key} {
    variable documents

    set matches [lsearch -regexp -inline -all -index 0 $documents "\\A${key}:\[0-9]+\\Z"]
}

proc ::docs::getCount {key} {
    variable documents

    set count [llength [getAll $key]]
}

lappend testDocs [::docs::new test "just a test" "really just a test"]
lappend testDocs [::docs::new test "just a second test" "really just a second test"]

lappend docsDocs [::docs::new ::docs documents "Documents is a list of all doc strings added"]
lappend docsDocs [::docs::new ::docs::topics "Document Topic" "Topic for doc string."]
lappend docsDocs [::docs::new ::docs::topics "Document Topics" "Not Sure"]

puts "testDocs keys = '[join $testDocs "', '"]'"

puts "docsDocs using ::docs::topics = '[join [::docs::getAll ::docs::topics] "', '"]'"

