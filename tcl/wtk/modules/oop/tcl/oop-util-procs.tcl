
namespace eval ::wtk::oop {

    variable objects_namespace ::OBJECTS
    variable classes_namespace ::CLASSES

    namespace import -force ::wtk::log::log
}

proc ::wtk::oop::this {} {
    uplevel {namespace tail [namespace current]}
}


proc ::wtk::oop::useLocals { args } {

    uplevel upvar 1 {*}$args
}


# use this to initalize a namespace or apply block
proc ::wtk::oop::initNamespaceVars {classType id {ns {} } } {

    if {$ns eq ""} {
	set ns ${classType}::$id
    }

    set varSpec [set ${classType}::VARIABLES]
    set initCode [set ${classType}::InitCode]

    log Debug "initNamespaceVars varSpec = $varSpec"
    log Debug "NamespaceInitCode  for $ns = '[set ${classType}::NamespaceInitCode]'"

    namespace eval $ns [set ${classType}::NamespaceInitCode]

    foreach argList $varSpec {
	lassign $argList var val type code
	namespace upvar ::$ns $var $type$var
    }

    upvar 1 args tmpArgs
    set i 0
    
    foreach {var val} $tmpArgs {
	
	switch -glob -- $var {
	    "--" {
		incr i 1 ;# remove --
		break
	    }
	    "-?*" {
		#puts stderr "......setting $var to $val"
		set $var "$val"
		incr i 2
	    }
	    "@?*" {
		#puts stderr "adding array items $val to array [string trim @ $var] "
		array set $var $val
		incr i 2
	    }
	    "+?*" {
		#puts stderr "lappending $val to $var"
		#puts "new value = [lappend $var $val]"
		lappend $var "$val"
		incr i 2
	    }
	    default {
		break
	    }
	}
    }

    set tmpArgs [lrange $tmpArgs $i end]
    
    foreach argList $varSpec {
	lassign $argList var val type code
	namespace eval $ns $code
    }

    log Debug "initNamespaceVars running InitCode for classType '$classType' in ns: '$ns'"

    foreach codeBlock $initCode {
	namespace eval $ns $codeBlock
    }
}


# Use this to initialize a proc:
proc ::wtk::oop::setArgs { argSpec {initCode {{}}} } {

    foreach argList $argSpec {
	lassign $argList var val type code
	upvar 1 $var $type$var
	switch -exact -- $type {
	    "-" {
		set -$var $val
	    }
	    "@" {
		array set @$var $val
	    }
	    "+" {
		set +$var $val
	    }
	    default {
		break
	    }
	}
    }

    upvar 1 args tmpArgs
    set i 0
    
    foreach {var val} $tmpArgs {
	switch -glob -- $var {
	    "--" {
		incr i 1 ;# remove --
		break
	    }
	    "-?*" {
		set $var $val
		incr i 2
	    }
	    "@?*" {
		array set $var $val
		incr i 2
	    }
	    "+?*" {
		log Debug "lappend $var $val"
		lappend $var $val
		incr i 2
	    }
	    default {
		break
	    }
	}
    }

    # reassign left over args to args:
    set tmpArgs [lrange $tmpArgs $i end]
    
    # apply variable validation:
    foreach argList $argSpec {
	lassign $argList var val type code
	uplevel 1 $code
    }
    
    # run initialization code/global validation
    foreach codeBlock $initCode {
	uplevel 1 $codeBlock
    }
}

proc ::wtk::oop::testProc { args } {

    log Debug "args = $args"

    setArgs {
	{a 0 - {set a [expr {$a > 0 ? $a : 0}]}}
	{b 1 - {set b [expr {$b > 0 ? $b : 0}]}}
	{c 2 - {set c [expr {$c > 0 ? $c : $a}]}}
	{d 3 - {set d [expr {$d > 0 ? $d : [expr {$b * $c}]}]}}
	{aa {} + }
	{bb {x 1 y 2 z 3} @ }
    }

    log Debug "a = $a, b = $b, c = $c, d = $d aa = '$aa', bb = '[array get bb]'"

}

proc ::wtk::oop::writeNamespaceInit { varSpec } {

    set initCode "     "

    foreach varList $varSpec {

	lassign $varList var val type code
	append initCode "variable $var $val\n     "
    }
    ::wtk::log::log Debug ".......writeNamespaceInit: '$initCode'"
    return $initCode
}


proc ::wtk::oop::testNamespace { type id args } {

    set ns ${type}::$id

    log Debug "ns = '$ns', args = '$args'"

    initNamespaceVars $type $id 
}

proc ::wtk::oop::showVars { {ns {}} } {

    if {$ns eq ""} {
	set ns [namespace current]
    }

    set vars [lsort [info vars ${ns}::*]]

    foreach var $vars {
	set var [namespace tail $var]
	namespace upvar $ns $var $var
	if {[info exists $var]} {
	    log Debug "$var = '[set $var]'"
	} else {
	    log Debug "$var = undefined"
	}
    }
}

# First export, then import log:
namespace eval ::wtk::oop {
    namespace export *
}

namespace eval :: {
    namespace import ::wtk::oop::this
}
