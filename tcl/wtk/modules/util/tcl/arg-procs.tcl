# Procs used to set and validate proc arguments
namespace eval ::wtk::util {

    namespace import -force ::wtk::log::log
}

# Use this to initialize a proc:
proc ::wtk::util::setArgs { argSpec {initCode {{}}} } {

    set argCodeList [list]

    foreach argList $argSpec {
        lassign $argList var val type code
        if {$code ne ""} {
            lappend argCodeList $code
        }

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
                log Notice "lappend $var $val"
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
    foreach code $argCodeList {
        #lassign $argList var val type code
        uplevel 1 $code
    }

    # run initialization code/global validation
    foreach codeBlock $initCode {
        uplevel 1 $codeBlock
    }
}
