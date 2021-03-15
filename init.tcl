# Run this script from the application root directory

# Load web toolkit
namespace eval :: {
    set ::pwd     [pwd]
    set ::script  [info script]
    set ::dirname [file normalize [file join $::pwd [file dirname $script]]]

    if {![llength [info commands lassign]]} {
        source [file join $::dirname tcl wtk modules util tcl compat.tcl]
    }

    puts stderr "script = [file join $::dirname $::script]"

    #set WTKDirectory
    set ::WTKLibrary [file join $::dirname tcl wtk]
    set ::WTKBootstrapFile [file join ${::WTKLibrary} modules bootstrap tcl bootstrap.tcl]

    puts stderr "WTKLibrary = $::WTKLibrary"

    puts stderr "WTKBootstrapFile = $::WTKBootstrapFile"

    puts stderr "Loading bootstrap $::WTKBootstrapFile"

    source $::WTKBootstrapFile

    ::wtk::log::log Notice "Loaded bootstrap $::WTKBootstrapFile"
}
