# ::wtk::modules module

namespace eval ::wtk::modules {

    namespace import -force ::wtk::log::*

}

namespace eval ::wtk::modules {

    variable bootModules      [list log modules]
    variable moduleConfigDir  [file join $::wtk::WTKLibrary config]
    variable moduleConfigFile [file join $moduleConfigDir modules modules-config.tcl]
    variable moduleDir        [file join $::wtk::WTKLibrary modules]

    # Load order for modules
    variable loadPhases       [list procs config init]

    variable modulesToLoad    [list [list util [list procs config init]] \
                                    [list log [list config init]] \
                                    [list modules [list config init]]]
    # List to store module load progress:
    variable moduleLoaded     [list]

    # moduleCount is used during dynamic loading of
    # the module list, which can grow in place
    variable moduleCount       3

    # moduleIndex is an iterator into the module list
    variable moduleIndex       0
}

proc ::wtk::modules::loadModule {module loadPhase} {

    variable moduleDir
    variable moduleLoaded
    variable moduleConfigDir

    
    switch -exact -- $loadPhase {
        config {
            set directory [file join $moduleConfigDir $module]
        }
        procs - init {
            set directory [file join $moduleDir $module tcl]
        }
        default {
            log Error "Unknown module loadPhase '$loadPhase' for module '$module'"
            return -code return
        }
    }

    set file [file join $directory ${module}-${loadPhase}.tcl]
    sourceFile $file $module $loadPhase
}

# Use this proc inside module files to load additional files:
proc ::wtk::modules::sourceFile { file {module " submodule"} {loadPhase "procs"} } {

    log Notice "Loading $file..."

    if {[catch {
        source $file
    } err ]} {
        log Error "'$err', Unable to load $file,"
        lappend moduleLoaded [list $module $loadPhase false]
        log Error "errorInfo: '[set ::errorInfo]'"
    }  else {
        log Notice "Loaded  $file."
        lappend moduleLoaded [list $module $loadPhase true]
    }
}

proc ::wtk::modules::addModuleOutline { module phaseList } {

    foreach phase $phaseList {
	addModuleFile $module $phase
    }

}

proc ::wtk::modules::addModuleFile { module loadPhase } {

    variable moduleDir
    variable moduleLoaded
    variable moduleConfigDir

    namespace import ::wtk::log
    
    switch -exact -- $loadPhase {
        config {
            set directory [file join $moduleConfigDir $module]
        }
        procs - init {
            set directory [file join $moduleDir $module tcl]
        }
        default {
            ::wtk::log::log Error "Unknown module loadPhase '$loadPhase' for module '$module'"
            return -code return
        }
    }

    set file [file join $directory ${module}-${loadPhase}.tcl]
    
    if {![file exists $file]} {
        exec mkdir -p [file dirname $file]
        exec echo "\n" > $file
        ::wtk::log::log Notice "Added module file $file."
    }
}


proc ::wtk::modules::addModule { module phaseList } {

    variable modulesToLoad
    variable loadPhases
    variable moduleCount
    variable moduleLoaded

    while {1} {

	set i 0

	# trim the phaseList
	foreach phase $phaseList {
	    if { [lsearch $loadPhases $phase] == -1 } {
		set phaseList [lreplace $phaseList $i $i]
	    } else {
		incr i
	    }
	}

	foreach phase $phaseList {
	    if { [lsearch $modulesToLoad [list $module [list *$phase*]]] > -1 } {
		log Error "addModule: attempt to add module $module phase $phase, which already exists!"
		set phaseList [list]
		break
	    }
	}

	if {![llength $phaseList]} {
	    log Warning "Module '$module' added without phaseList, module will not be loaded."
	    break
	}

	lappend modulesToLoad [list $module $phaseList]
	incr moduleCount

	log Notice "addModule: module: $module phaseList: $phaseList"
	break
    }
    return [list $module $phaseList]
}

# Modules are loaded in the following phase order:
# 1. procs
# 2. config
# 3. init
proc ::wtk::modules::loadModules { } {

    variable loadPhases
    variable moduleLoaded
    variable modulesToLoad
    variable moduleCount
    variable moduleIndex ;# should be zero


    # Load procs first:
    set moduleIndex 0

    while {$moduleIndex < $moduleCount} {

	lassign [lindex $modulesToLoad $moduleIndex] module phaseList

	if {[lsearch -exact $phaseList procs] > -1} {
	    loadModule $module procs
	} else {
	    log Notice "loadModules: phase procs not found in module '$module'"
	}

	incr moduleIndex
    }

    # reset moduleIndex for config:
    set moduleIndex 0

    while {$moduleIndex < $moduleCount} {

	lassign [lindex $modulesToLoad $moduleIndex] module phaseList

	if {[lsearch -exact $phaseList config] > -1} {
	    loadModule $module config
	}

	incr moduleIndex
    }

    # reset moduleIndex for init
    set moduleIndex 0

    while {$moduleIndex < $moduleCount} {

	lassign [lindex $modulesToLoad $moduleIndex] module phaseList

	if {[lsearch -exact $phaseList init] > -1} {
	    loadModule $module init
	}

	incr moduleIndex
    }

}
