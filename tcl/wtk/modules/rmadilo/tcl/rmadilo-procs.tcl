# rmadilo data language API

namespace eval ::rmadilo {
    variable parentId2Ns ;# instId2Ns maps unique doc id to tcl namespace
    variable idCounter 0
    variable instParent ::rdlDoc
}

proc ::rmadilo::nextId {} {
    variable idCounter
    incr idCounter
}

proc ::rmadilo::mapId2Ns {id ns} {
    variable instId2Ns 
    set instId2Ns($id) $ns
}
# autogenerate the default parent container:
namespace eval ::rDoc {
    variable nextId -1
}


proc ::rmadilo::new {{text ""} {parent ""}} {
    variable parentId2Ns
    variable idCounter 
    variable instParent

    if {$parent ne ""} { 
        if {![namespace exists $parent]} {
            namespace eval $parent {
                variable nextId -1
            }
            proc ${parent}::nextId {
                variable nextId
                incr nextId
            }
            set parentId2Ns([nextId]) $parent
        }
    }

}

proc ::rmadilo::parseRHF { rhf } {

} 

