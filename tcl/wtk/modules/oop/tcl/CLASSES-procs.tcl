
namespace eval ::CLASSES {

    namespace import -force ::wtk::oop::*

    variable PUBLIC_nextObjectId [list {} {
    variable ObjCounter
    variable ObjNameFormat

    ::wtk::log::log Debug "nextObjectId ObjCounter = $ObjCounter"
    return [format $ObjNameFormat [incr ObjCounter]]
    }]

    variable PUBLIC_new_object [list {args} {

    set type [namespace current]
    set ObjectId [apply [concat [set ::CLASSES::PUBLIC_nextObjectId] $type]]

    ::wtk::oop::initNamespaceVars $type $ObjectId

    ::OBJECTS::registerObject $type $ObjectId

    namespace eval $type [list lappend OBJECTS $ObjectId]

    return $ObjectId
    }]

    variable PUBLIC_new_class [list {id args} {

    if {$id eq ""} {
        # Not sure why this would ever happen? unnamed class?
        set ObjectId [apply [concat $::CLASSES::PUBLIC_nextObjectId ::CLASSES::Class]]
    } else {
        set ObjectId $id
    }

    if {[string match "::*::*" $ObjectId]} {
        namespace eval $ObjectId {
        # do nothing
        }
        set type $ObjectId
        set ns $type
    } else {
        set type "::CLASSES::Class::$ObjectId"
        set ns ""
    }

    ::wtk::oop::initNamespaceVars ::CLASSES::Class $ObjectId $ns
    ::OBJECTS::registerObject $ObjectId $type
    namespace eval ::CLASSES::Class [list lappend OBJECTS $ObjectId]
    namespace eval $type [list namespace upvar ::CLASSES::Class PUBLIC_new_object PUBLIC_new_object]

    #lappend OBJECTS $ObjectId

    return $ObjectId
    }]

    variable PUBLIC_new_method [list {methodName argList methodBody {methodType "PUBLIC"}} {

    variable METHODS
    variable ${methodType}_$methodName

    if {[info exists ${methodType}_$methodName]} {
        # user is overriding defined method: this does not work as expected!
        # unset/resetting the variable still maintains the namespace upvar link!
        # this ends up replacing the method in the parent class, so we refuse to do it.
        # fix is to add '+METHODS method_name' to the Class definition.

        #unset -nocomplain ${methodType}_$methodName
        #variable ${methodType}_$methodName

        return -errorinfo "!!!!!!!Class.new_method: [namespace current]::${methodType}_$methodName exists!!!!,\
                to override, add +METHODS $methodName to Class definition" -code error
    } else {
        ::wtk::log::log Debug "Class.new_method: \[this\] might go away! Error ---v?"
        ::wtk::log::log Debug "new_method: adding new method ${methodType}_$methodName adding to [this]"
    }

    # Possibly add method to public methods:
    if {$methodType eq "PUBLIC" &&
        [lsearch "PUBLIC_$methodName" $METHODS] > -1
    } {
        lappend METHODS PUBLIC_$methodName
    }

    set ${methodType}_$methodName [list $argList $methodBody]

    }]
}

namespace eval ::CLASSES::Class {

    variable ObjCounter 1
    variable ObjNameFormat CLASS%0.3i
    variable Type
    variable Public [list] ;# base classes for public inheritance
    variable OBJECTS [list Class]
    variable METHODS [list PUBLIC_new_class PUBLIC_new_object PUBLIC_new_method]

    variable VARIABLES {
    {ObjCounter 0 - {
        set ObjCounter [expr {$ObjCounter > 0 ? $ObjCounter : 0}]}
    }
    {ObjNameFormat {%0.3i} - {}}
    {Type {{}} - {}}
    {METHODS {{}} + {}}
    {OBJECTS {{}} + {}}
    }

    # Demonstrate how to add new variables:
    lappend VARIABLES {VARIABLES {{}} - {}}
    lappend VARIABLES {
    NamespaceInitCode {{}} - {
        ::wtk::log::log Debug "++++setting variables for [namespace current]"
        set NamespaceInitCode [::wtk::oop::writeNamespaceInit $VARIABLES]
    }
    }
    lappend VARIABLES {InitCode {{}} - {}}
    lappend VARIABLES {Public {{}} + {}}
    variable NamespaceInitCode [::wtk::oop::writeNamespaceInit $VARIABLES]
    variable InitCode {
    {

        # Make sure methods begin with PUBLIC_:
        for {set __I 0} {$__I < [llength $METHODS]} {incr __I} {
        if {[string match PUBLIC_* [lindex $METHODS $__I]]} {
            continue
        } else {
            lset METHODS $__I PUBLIC_[lindex $METHODS $__I]
        }
        }


        foreach BASECLASS $Public {

        set BASETYPE $::OBJECTS::OBJECT_TYPE($BASECLASS)
        set VARIABLES [concat [set ${BASETYPE}::VARIABLES] $VARIABLES]
        set InitCode  [concat [set ${BASETYPE}::InitCode] $InitCode]

        foreach PUBLIC_METHOD [info vars ${BASETYPE}::PUBLIC_*] {

            set METHOD_NAME [namespace tail $PUBLIC_METHOD]

            if {[lsearch $METHODS $METHOD_NAME] > -1 } {
            # user is overriding a base class method
            # user must supply this method to use it
            continue
            }

            namespace upvar $BASETYPE $METHOD_NAME $METHOD_NAME
            lappend METHODS $METHOD_NAME
        }
        }

        # Remove used variables
        variable NamespaceInitCode [::wtk::oop::writeNamespaceInit $VARIABLES]
        unset -nocomplain BASECLASS BASETYPE PUBLIC_METHOD METHOD_NAME __I
    }

    }

    namespace upvar ::CLASSES PUBLIC_new_object PUBLIC_new_object \
    PUBLIC_new_class PUBLIC_new_class PUBLIC_new_method PUBLIC_new_method
}


proc ::CLASSES::<<  { object args } {

    namespace upvar ::OBJECTS OBJECT_TYPE object_type

    switch -exact -- $object {

        "Class" - "Class.new" {
            # Make a new class using new_class
            set type ::CLASSES::Class

            return [apply [concat $CLASSES::Class::PUBLIC_new_class ${type}] [lindex $args 0] {*}[lrange $args 1 end-1]]

        }

    }

    lassign [split $object .] id method mtype
    set type $object_type($id)

    switch -glob -- $object {

        "*.new" {
            # New object using new_object
            return [apply [concat [set ${type}::PUBLIC_new_object] ${type}] {*}[lrange $args 0 end-1]]
        }
        "*.method" {
            # New class method using new_method
            return [apply [concat $CLASSES::Class::PUBLIC_new_method ${type}] {*}[lrange $args 0 end-1]]
        }
        "*.*.*" {
            # Possible Non-Public method
            set mtype [string toupper $mtype]
            return [apply [concat [set ${type}::${mtype}_$method] ${type}] {*}[lrange $args 0 end-1]]
        }
        "*.*" {
            # Invoke public method
            set mtype PUBLIC
            return [apply [concat [set ${type}::${mtype}_$method] ${type}::$id] {*}[lrange $args 0 end-1]]
        }
        default {
            # assume that id is a Class, use new_object
            return [apply [concat [set ${type}::PUBLIC_new_object] ${type}] {*}[lrange $args 0 end-1]]
        }
    }
}


namespace eval ::CLASSES {
    namespace export <<
}

namespace eval :: {
    namespace import ::CLASSES::<<
}
