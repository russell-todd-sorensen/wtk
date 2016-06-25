namespace eval ::wtk::form {

    variable version 1.0

    namespace import -force ::wtk::nv::*
    namespace import -force ::wtk::log::log

}

proc ::wtk::form::getPostedData { connArray {queryArray QS} {fileList FILES} } {

    upvar $connArray conn
    upvar $queryArray QS
    upvar $fileList FILES

    set contentTypeHeader [::wtk::nv::nvGet conn(HeaderSet) "content-type"]
    set FILES [list]

    if {[regexp -nocase\
	     {(multipart/form-data;)[ \t]*boundary=[ \t]*([-0-9A-Za-z]+)}\
	     $contentTypeHeader match type boundary x y z]
    } {

	log Debug "getPostedData: boundary: '$boundary'"

	::wtk::form::parseMultipartFormData $conn(formFd) $boundary QS FILES
	
	log Debug "getPostedData: QS = [array get QS] FILES = $FILES"
	
	set files $FILES

    } else {

	log Debug "processForm.tcl: didn't find boundary"

    }
}


proc ::wtk::form::parseQueryToArray { {queryString ""} {queryArrayName QUERY} } {

    global env
    upvar 1 $queryArrayName QUERY

    if {[info exists env(QUERY_STRING)] &&
	$queryString eq ""
    } {
	set queryString $env(QUERY_STRING)
    }

    set length [string length $queryString]

    set queryTerms [split $queryString ";&"]

    foreach term $queryTerms {
	lassign [split $term "="] _key _value
	set QUERY($_key) $_value
	log Noitce "parseQueryToArray found $_key with value $_value"
    }
}

proc ::wtk::form::parseQueryToNVSet {

 {queryString ""} 
 {nvSet QUERY}

} {

    global env
    upvar 1 $nvSet QUERY

    if {[info exists env(QUERY_STRING)] &&
	$queryString eq ""
    } {
	set queryString $env(QUERY_STRING)
	if {[exists QUERY]} {
	    return $nvSet
	} else {
	    create $nvSet
	}
    } else {
	set queryString ""
	return NULL
    }

    set length [string length $queryString]

    set queryTerms [split $queryString ";&"]

    foreach term $queryTerms {
	nvPut QUERY {*}[split $term "="]
        #log Notice "QUERYTERM=([split $term =])"
    }
    return $nvSet
}


proc ::wtk::form::parseMultipartFormData { fd boundary {qs QUERY} {files FILES} } {

    # boundary line has two extra -- at the beginning
    set boundary "--$boundary"
    log Notice "starting parseMultipartFormData"

    chan seek $fd 0
    chan configure $fd -translation crlf

    upvar 1 $qs QUERY
    upvar 1 $files FILES

    set FILES [list]

    log Notice "Looking for boundry\n$boundary"
    while {![eof $fd] && [gets $fd line] >= 0} {

	log Notice "got line \n$line"
     
	if {$line eq $boundary} {
	    log Notice "Found boundary at [chan tell $fd]"
	    array unset cdArray
	    array unset ctArray
	    # Start of a new query var or file
	    if {[gets $fd ContentDispositionLine] == -1} {
		log Error "ParseIt: Premature end of file"
		return
	    }

	    set CDStartString "Content-Disposition: "

	    if {[string match -nocase "$CDStartString*" $ContentDispositionLine]} {
		set cdList [split [string range $ContentDispositionLine [string length $CDStartString] end] ";"]
	    } else {
		log Error "ParseIt: Missing Content-Disposition Header"
		return
	    }
	    
	    foreach item $cdList {
		set item [string trim $item]
		if {$item eq "form-data"} {
		    set cdArray(cdType) form-data
		} else {
		    set itemEqualIndex [string first "=" $item]
		    set itemName [string range $item 0 [expr {$itemEqualIndex - 1}]]
		    set itemValue [string trim [string range $item [expr {$itemEqualIndex + 1}] end] "\""]
		    set cdArray($itemName) $itemValue
		}
	    }


	    if {[info exists cdArray(filename)]} {
		#handle file
		if {[gets $fd ContentTypeLine] == -1} {
		    log Error "ParseIt: Premature end of file at [chan tell $fd]"
		    return
		}

		set CTStartString "Content-Type: " 

		if {[string match -nocase "$CTStartString*" $ContentTypeLine]} {
		    log Notice "Found Content Type Header: '$ContentTypeLine'"
		    set ctList [split [string range  $ContentTypeLine [string length $CTStartString] end] ";"]
		} else {
		    log Error "ParseIt: Missing Content-Type Header"
		}
		
		set binary 0
		foreach item $ctList {
		    set item [string trim $item]
		    if {[string match "text/*" $item]} {
			set ctArray(ctType) $item
			set binary 0
		    } elseif {0} {
			set itemEqualIndex [string first "=" $item]
			set itemName [string range $item 0 [expr {$itemEqualIndex - 1}]]
			set itemValue [string trim [string range $item [expr {$itemEqualIndex + 1}] end] "\""]
			set ctArray($itemName) $itemValue
		    } else {
			set ctArray(ctType) $item
			set binary 1
		    }
		}
		if {[array exists ctArray]} {
		    array set cdArray [array get ctArray]
		}
		log Notice "Got file [array get cdArray] binary? = $binary"

		# remove <CR><LF>

		if {[get_eol $fd]} {
		    set cdArray(file_start) [chan tell $fd]
		} else {
		    log Warning "Unexpected data at [chan tell $fd]"
		}

		while {![eof $fd]} {

		    set file_end [expr {[chan tell $fd] -2}]

		    if {[chan gets $fd line] == -1} {
			# found eof
			log Warning "Found EOF before boundary at [chan tell $fd]"
			break
		    }
		    
		    if {$line eq $boundary} {
			#found boundary for file

			set cdArray(file_end) $file_end
			set cdArray(file_length) [expr {$file_end - $cdArray(file_start)}]

			log Notice "Found boundary of file"

			lappend FILES [array get cdArray]

			# backup past boundary and then remove eol to get to boundary again
			chan seek $fd $file_end
			get_eol $fd

			break

		    } elseif {$line eq "${boundary}--" } {

			# found boundary and end of file
			set cdArray(file_end) $file_end
			set cdArray(file_length) [expr {$file_end - $cdArray(file_start)}]

			log Notice "Found boundary and end of content data file"

			lappend FILES [array get cdArray]

			return
		    }
		    # else loop
		}

		continue

	    } elseif {[info exists cdArray(name)]} {

		# get value of item
		log Notice "Got regular query var [set cdArray(name)]"

		if {![get_eol $fd]} {
		    log Error "Unexpected data at [chan tell $fd]"
		} else {
		    set cdArray(file_start) [chan tell $fd]
		}
		# Now get possibly multiple lines of data for the value!
		while {![eof $fd]} {

		    # file_end_tmp is used to hold position of last
		    # crlf or lf, before boundary
		    set file_end [expr {[chan tell $fd] -2}]

		    if {[chan gets $fd line] == -1} {
			# found unexpected eof
			log Warning "Found EOF before boundary at [chan tell $fd]"
			break
		    }
		    if {$line eq $boundary} {
			#found boundary for value

			# Back up to get end of value:
			#chan seek $fd $file_end_tmp
			#backupOverLfCr $fd
			
			set cdArray(file_end) $file_end
			log Notice ">>>$cdArray(name) file_end = $cdArray(file_end) file_start = $cdArray(file_start)"
			set cdArray(file_length) [expr {$cdArray(file_end) - $cdArray(file_start)}]

			log Notice "Found boundary of file"

			chan seek $fd $cdArray(file_start)
			chan configure $fd -translation binary
			lappend QUERY($cdArray(name)) [read $fd $cdArray(file_length)]
			chan configure $fd -translation crlf

			# backup past boundary and then remove eol to get to boundary again
			chan seek $fd $file_end
			get_eol $fd

			break

		    } elseif {$line eq "${boundary}--" } {

			# found boundary and end of file
			set cdArray(file_end) $file_end
			set cdArray(file_length) [expr {$cdArray(file_end) - $cdArray(file_start)}]

			log Notice "Found boundary and end of content data file"

			chan seek $fd $cdArray(file_start)
			chan configure $fd -translation binary
			lappend QUERY($cdArray(name)) [read $fd $cdArray(file_length)]
			chan configure $fd -translation crlf
			return
		    }
		    # else loop
		}
		
	    } else {
		log Warning "Unknown Content Disposition format '$ContentDispositionLine' at [chan tell $fd]"
	    }
	} else {
	    #log Notice "line does not match bounary at [chan tell $fd]"
	    puts -nonewline stderr "."
	}
    }
}

proc ::wtk::form::backupOverLfCr { fd } {

    # Note this is the reverse of get_eol
    set got_cr 0
    set got_lf 0
    set got_lfcr 0

    set position [chan tell $fd]
    set seekIndex 0

    while {![eof $fd]} {

	incr seekIndex
	chan seek $fd [expr {$position - $seekIndex}] start
	set char [chan read $fd 1]

	switch -exact $char {
	    "\n" {
		set got_lf 1
	    }
	    "\r" {
		if {$got_lf} {
		    set got_lfcr 1
		    set got_cr 0
		} else {
		    set got_cr 1
		}
	    }
	    default {
		log Error "Unexpected chars '$char' at [chan tell $fd]"
		break
	    }
	}
	
	if {$got_lfcr || $got_cr} {
	    chan seek $fd [expr {$position - $seekIndex}] start
	    return 1
	}
    }
    
    return 0
}

proc ::wtk::form::get_eol {fd} {

    set got_cr 0
    set got_lf 0
    set got_crlf 0

    while {![eof $fd]} {
	
	set char [chan read $fd 1]
	switch -exact $char {
	    "\r" {
		set got_cr 1
	    }
	    "\n" {
		if {$got_cr} {
		    set got_crlf 1
		    set got_cr 0
		} else {
		    set got_lf 1
		}
	    }
	    default {
		log Error "Unexpected chars '$char' at [chan tell $fd]"
		break
	    }
	}
	
	if {$got_crlf || $got_lf} {
	    return 1
	}
    }
    
    return 0
}


