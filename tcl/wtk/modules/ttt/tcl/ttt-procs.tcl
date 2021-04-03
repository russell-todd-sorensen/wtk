set fileDirectory [file dirname [info script]]
::wtk::modules::sourceFile [file join $fileDirectory compile-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory xresource-procs.tcl]
