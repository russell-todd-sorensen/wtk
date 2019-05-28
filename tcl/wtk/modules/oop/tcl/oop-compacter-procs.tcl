# Procs to compact objects of a class into one namespace
# This is to be used on existing classes
# Usage: << ClassName.compact >> ?? or << ClassName!compact >>
#
## Compacting a class has the following effects:
##
## 1. All objects are stored in a single namespace (or one of several)
## 2. "this" arg is added as first arg to proc definition
## 3. ?? variable command is redefined ?? to mean:
##    variable x == upvar 1 x_$this x
##
## 4. proc is executed in the storage namespace, where upvar means the
##    namespace.


### LOOKS like I need to change initNamespaceVars:
#PUBLIC_new_object = 'args {
#
#    set type [namespace current]
#    set ObjectId [apply [concat [set ::CLASSES::PUBLIC_nextObjectId] $type]]
#
#    ::wtk::oop::initNamespaceVars $type $ObjectId ;# <------ change initNamespaceVars to initCompactVars
#
#    ::OBJECTS::registerObject $type $ObjectId
#
#    namespace eval $type [list lappend OBJECTS $ObjectId]
#
#    return $ObjectId
#}
# Then replace the PUBLIC_new_object proc.

proc ::CLASSES::Class::compacter { classToCompact } {

    namespace upvar ::${classToCompact} METHODS METHODS VARIABLES VARIABLES
}

# use this to initalize a namespace or apply block
proc ::wtk::oop::initCompactVars {classType id {ns {} } } {

    if {$ns eq ""} {
        set ns $classType
    }

    set varSpec [set ${classType}::VARIABLES]
    set initCode [set ${classType}::InitCode]

    #log Debug "initNamespaceVars varSpec = $varSpec"

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
                #puts stderr "setting $var to $val"
                set $var $val
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
                lappend $var $val
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

    log Notice "initNamespaceVars running InitCode for classType '$classType' in ns: '$ns'"

    foreach codeBlock $initCode {
        namespace eval $ns $codeBlock
    }
}
