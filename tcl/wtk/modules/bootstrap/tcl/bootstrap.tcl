

namespace eval ::wtk {

    variable approot $::dirname
    variable initscript $::script
    variable WTKLibrary $::WTKLibrary
    variable WTKBootstrapFile $::WTKBootstrapFile
    variable loaded 0
}

puts stderr "Loading log-procs.tcl..."
source [file join $::wtk::WTKLibrary modules     log tcl log-procs.tcl]
::wtk::log::log Notice "Finished loading log-procs.tcl"


source [file join $::wtk::WTKLibrary modules modules tcl modules-procs.tcl]


#::wtk::modules::loadModule log procs
#::wtk::modules::loadModule log init

#::wtk::modules::loadModule modules procs
#::wtk::modules::loadModule modules init

#::wtk::modules::addModule log {procs config init}
#::wtk::modules::addModule modules {procs config init}
#::wtk::modules::addModuleOutline xyz {init config procs}
#::wtk::modules::addModuleOutline log config
#::wtk::modules::addModuleOutline modules config
#::wtk::modules::addModuleOutline util {procs config init}
#::wtk::modules::addModuleOutline oop {procs config init}
#::wtk::modules::addModule xyz [list init sed procs config gddkryl]
#::wtk::modules::addModule sudoku [list procs init]
#::wtk::modules::addModuleOutline db   [list config procs init]
#::wtk::modules::addModuleOutline cor  [list procs config]
#::wtk::modules::addModule oop  [list init procs config]
#::wtk::modules::addModule db   [list procs init]
#::wtk::modules::addModule pg   [list procs config init]
#::wtk::modules::addModule cor  [list procs config init]
::wtk::modules::addModule url [list procs init]
::wtk::modules::addModule form [list procs]
::wtk::modules::addModule conn [list procs]
::wtk::modules::addModule http [list procs init]

#::wtk::modules::addModule t3   [list procs]
# Finally load all the modules:
::wtk::modules::loadModules

