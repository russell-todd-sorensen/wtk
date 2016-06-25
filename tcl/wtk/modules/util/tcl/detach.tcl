# Procedure to open files exclusively and detach before writing/reading:
# Returns file descriptor fd, which can be used row rd/wr, but isn't
# attached to the filesystem.
# Caller should use [chan close $fd] when finished with fd.

# add this back in when math is available
#package require math

proc ::detachFile {filename {directory "/tmp"} } {

    # Open non-existing file for reading and writing
    # Set permissions to rw only for current user
    if {[catch {
      set filename [file join $directory $filename]
			# reset when running linux
      #set fd [open $filename [list CREAT EXCL RDWR BINARY] 00600 ]
      set fd [open $filename [list CREAT EXCL RDWR] 00600 ]
			fconfigure $fd -translation binary 
			# this should eventually delete when on linux
      #file delete $filename
    } err ]} {
      ::wtk::log::log Error "detach_file failed with $filename error:\n'$err'"
      return 0
    }

    return $fd
}

proc ::makeSecureName { {template XXXXXXXX} } {

    set charSet [list 0 1 2 3 4 5 6 7 8 9 0 _ \
		     a b c d e f g h i j k l m n o p q r s t u v w x y z \
		     A B C D E F G H I J K L M N O P Q R S T U V W X Y Z]

    set length [llength $charSet]
		     
    set filename ""

    foreach char [split $template ""] {
	if {$char eq "X"} {
	    #append filename [lindex $charSet [::math::random $length]]
			append filename [lindex $charSet [expr {int(ceil(rand()*$length))}]]
	} else {
	    append filename $char
	}
    }
    return $filename
}

proc ::makeSecureFd {{template XXXXXXXX} {directory "/tmp"} } {


    set filename [makeSecureName $template]

    set fd [detachFile $filename $directory]

    if {$fd == 0} {
      ::wtk::log::log Error "makeSecureFd failed with $filename"
      return 0
    }

    return $fd
}

