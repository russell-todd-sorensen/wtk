proc unknown {args} {

    variable ::tcl::UnknownPending
    global auto_noexec auto_noload env tcl_interactive errorInfo errorCode

    if {[info exists errorInfo]} {
	set savedErrorInfo $errorInfo
    }
    if {[info exists errorCode]} {
	set savedErrorCode $errorCode
    }

    set name [lindex $args 0]
    if {![info exists auto_noload]} {
	#
	# Make sure we're not trying to load the same proc twice.
	#
	if {[info exists UnknownPending($name)]} {
	    return -code error "self-referential recursion in \"unknown\" for command \"$name\""
	}
	set UnknownPending($name) pending
	set ret [catch {
		auto_load $name [uplevel 1 {::namespace current}]
	} msg opts]
	unset UnknownPending($name)
	if {$ret != 0} {
	    dict append opts -errorinfo "\n    (autoloading \"$name\")"
	    return -options $opts $msg
	}
	if {![array size UnknownPending]} {
	    unset UnknownPending
	}
	if {$msg} {
	    if {[info exists savedErrorCode]} {
		set ::errorCode $savedErrorCode
	    } else {
		unset -nocomplain ::errorCode
	    }
	    if {[info exists savedErrorInfo]} {
		set errorInfo $savedErrorInfo
	    } else {
		unset -nocomplain errorInfo
	    }
	    set code [catch {uplevel 1 $args} msg opts]
	    if {$code ==  1} {
		#
		# Compute stack trace contribution from the [uplevel].
		# Note the dependence on how Tcl_AddErrorInfo, etc.
		# construct the stack trace.
		#
		set errInfo [dict get $opts -errorinfo]
		set errCode [dict get $opts -errorcode]
		set cinfo $args
		if {[string bytelength $cinfo] > 150} {
		    set cinfo [string range $cinfo 0 150]
		    while {[string bytelength $cinfo] > 150} {
			set cinfo [string range $cinfo 0 end-1]
		    }
		    append cinfo ...
		}
		set tail "\n    (\"uplevel\" body line 1)\n    invoked from within\n\"uplevel 1 \$args\""
		set expect "$msg\n    while executing\n\"$cinfo\"$tail"
		if {$errInfo eq $expect} {
		    #
		    # The stack has only the eval from the expanded command
		    # Do not generate any stack trace here.
		    #
		    dict unset opts -errorinfo
		    dict incr opts -level
		    return -options $opts $msg
		}
		#
		# Stack trace is nested, trim off just the contribution
		# from the extra "eval" of $args due to the "catch" above.
		#
		set last [string last $tail $errInfo]
		if {$last + [string length $tail] != [string length $errInfo]} {
		    # Very likely cannot happen
		    return -options $opts $msg
		}
		set errInfo [string range $errInfo 0 $last-1]
		set tail "\"$cinfo\""
		set last [string last $tail $errInfo]
		if {$last + [string length $tail] != [string length $errInfo]} {
		    return -code error -errorcode $errCode  -errorinfo $errInfo $msg
		}
		set errInfo [string range $errInfo 0 $last-1]
		set tail "\n    invoked from within\n"
		set last [string last $tail $errInfo]
		if {$last + [string length $tail] == [string length $errInfo]} {
		    return -code error -errorcode $errCode  -errorinfo [string range $errInfo 0 $last-1] $msg
		}
		set tail "\n    while executing\n"
		set last [string last $tail $errInfo]
		if {$last + [string length $tail] == [string length $errInfo]} {
		    return -code error -errorcode $errCode  -errorinfo [string range $errInfo 0 $last-1] $msg
		}
		return -options $opts $msg
	    } else {
		dict incr opts -level
		return -options $opts $msg
	    }
	}
    }

    if {([info level] == 1) && ([info script] eq "")
	    && [info exists tcl_interactive] && $tcl_interactive} {
	if {![info exists auto_noexec]} {
	    set new [auto_execok $name]
	    if {$new ne ""} {
		set redir ""
		if {[namespace which -command console] eq ""} {
		    set redir ">&@stdout <@stdin"
		}
		uplevel 1 [list ::catch  [concat exec $redir $new [lrange $args 1 end]]  ::tcl::UnknownResult ::tcl::UnknownOptions]
		dict incr ::tcl::UnknownOptions -level
		return -options $::tcl::UnknownOptions $::tcl::UnknownResult
	    }
	}
	if {$name eq "!!"} {
	    set newcmd [history event]
	} elseif {[regexp {^!(.+)$} $name -> event]} {
	    set newcmd [history event $event]
	} elseif {[regexp {^\^([^^]*)\^([^^]*)\^?$} $name -> old new]} {
	    set newcmd [history event -1]
	    catch {regsub -all -- $old $newcmd $new newcmd}
	}
	if {[info exists newcmd]} {
	    tclLog $newcmd
	    history change $newcmd 0
	    uplevel 1 [list ::catch $newcmd  ::tcl::UnknownResult ::tcl::UnknownOptions]
	    dict incr ::tcl::UnknownOptions -level
	    return -options $::tcl::UnknownOptions $::tcl::UnknownResult
	}

	set ret [catch {set candidates [info commands $name*]} msg]
	if {$name eq "::"} {
	    set name ""
	}
	if {$ret != 0} {
	    dict append opts -errorinfo  "\n    (expanding command prefix \"$name\" in unknown)"
	    return -options $opts $msg
	}
	# Filter out bogus matches when $name contained
	# a glob-special char [Bug 946952]
	if {$name eq ""} {
	    # Handle empty $name separately due to strangeness
	    # in [string first] (See RFE 1243354)
	    set cmds $candidates
	} else {
	    set cmds [list]
	    foreach x $candidates {
		if {[string first $name $x] == 0} {
		    lappend cmds $x
		}
	    }
	}
	if {[llength $cmds] == 1} {
	    uplevel 1 [list ::catch [lreplace $args 0 0 [lindex $cmds 0]]  ::tcl::UnknownResult ::tcl::UnknownOptions]
	    dict incr ::tcl::UnknownOptions -level
	    return -options $::tcl::UnknownOptions $::tcl::UnknownResult
	}
	if {[llength $cmds]} {
	    return -code error "ambiguous command name \"$name\": [lsort $cmds]"
	}
    }
    return -code error -errorcode [list TCL LOOKUP COMMAND $name]  "invalid command name \"$name\""
}


