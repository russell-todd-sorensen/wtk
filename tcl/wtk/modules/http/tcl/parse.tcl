#set fd [open "/tmp/bg,zrX.S09" rb]
#set fd [open "/tmp/P3u3kz51R9" rb]
#set fd [open "/tmp/1aYFyO38,K" rb]
set fd [open "/tmp/BQudE1T.data" rb]

source wtk/init.tcl
fconfigure $fd -translation crlf

#set boundary "-----------------------------8835670331634281765682377587"
set boundary "-----------------------------21329152221793534104881765449"
set boundary "-----------------------------50019127617306874602128418222"
set boundary "---------------------------1374499308685076915794640319"
set boundary "---------------------------1374499308685076915794640319"
proc parseIt { fd boundary {qs QUERY} {files FILES} } {

    # boundary line has two extra -- at the beginning
    set boundary "--$boundary"
    ::wtk::log::log Notice "starting parseIt"

    upvar 1 $qs QUERY
    upvar 1 $files FILES

    set FILES [list]

    ::wtk::log::log Notice "Looking for boundry\n$boundary"
    while {![eof $fd] && [gets $fd line] >= 0} {

	::wtk::log::log Notice "got line \n$line"
     
	if {$line eq $boundary} {
	    ::wtk::log::log Notice "Found boundary at [chan tell $fd]"
	    array unset cdArray
	    array unset ctArray
	    # Start of a new query var or file
	    if {[gets $fd ContentDispositionLine] == -1} {
		::wtk::log::log Error "ParseIt: Premature end of file"
		return
	    }

	    set CDStartString "Content-Disposition: "

	    if {[string match -nocase "$CDStartString*" $ContentDispositionLine]} {
		set cdList [split [string range $ContentDispositionLine [string length $CDStartString] end] ";"]
	    } else {
		::wtk::log::log Error "ParseIt: Missing Content-Disposition Header"
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
		    ::wtk::log::log Error "ParseIt: Premature end of file at [chan tell $fd]"
		    return
		}

		set CTStartString "Content-Type: " 

		if {[string match -nocase "$CTStartString*" $ContentTypeLine]} {
		    ::wtk::log::log Notice "Found Content Type Header: '$ContentTypeLine'"
		    set ctList [split [string range  $ContentTypeLine [string length $CTStartString] end] ";"]
		} else {
		    ::wtk::log::log Error "ParseIt: Missing Content-Type Header"
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

		::wtk::log::log Notice "Got file [array get cdArray] binary? = $binary"

		# remove <CR><LF>

		if {[get_eol $fd]} {
		    set cdArray(file_start) [chan tell $fd]
		} else {
		    ::wtk::log::log Warning "Unexpected data at [chan tell $fd]"
		}

		while {![eof $fd]} {

		    set file_end [expr {[chan tell $fd] -1}]

		    if {[chan gets $fd line] == -1} {
			# found eof
			::wtk::log::log Warning "Found EOF before boundary at [chan tell $fd]"
			break
		    }
		    
		    if {$line eq $boundary} {
			#found boundary for file

			set cdArray(file_end) $file_end
			set cdArray(file_length) [expr {$file_end - $cdArray(file_start)}]

			::wtk::log::log Notice "Found boundary of file"

			lappend FILES [array get cdArray]

			# backup past boundary and then remove eol to get to boundary again
			chan seek $fd $file_end
			get_eol $fd

			break

		    } elseif {$line eq "${boundary}--" } {

			# found boundary and end of file
			set cdArray(file_end) $file_end
			set cdArray(file_length) [expr {$file_end - $cdArray(file_start)}]

			::wtk::log::log Notice "Found boundary and end of content data file"

			lappend FILES [array get cdArray]

			return
		    }
		    # else loop
		}

		continue

	    } elseif {[info exists cdArray(name)]} {

		# get value of item
		::wtk::log::log Notice "Got regular query var [set cdArray(name)]"

		if {![get_eol $fd]} {
		    ::wtk::log::log Error "Unexpected data at [chan tell $fd]"
		}
		if {[gets $fd value] >= 0 } {
		    lappend QUERY($cdArray(name)) $value
		}

	    } else {
		::wtk::log::log Warning "Unknown Content Disposition format '$ContentDispositionLine' at [chan tell $fd]"
	    }
	} else {
	    #::wtk::log::log Notice "line does not match bounary at [chan tell $fd]"
	    puts -nonewline stderr "."
	}
    }
}


proc get_eol {fd} {

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
		::wtk::log::log Error "Unexpected chars '$char' at [chan tell $fd]"
		break
	    }
	}
	
	if {$got_crlf || $got_lf} {
	    return 1
	}
    }
    
    return 0
}
		   


parseIt $fd $boundary
