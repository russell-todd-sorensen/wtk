namespace eval ::OBJECTS {

    variable OBJECT_TYPE
 
    set OBJECT_TYPE(CLASS000) ::CLASSES::Class

    # Specially named object:
    set OBJECT_TYPE(Class) ::CLASSES::Class
    
    namespace import ::wtk::oop::*
}
    
proc ::OBJECTS::registerObject { type ObjectId {ns {}} } {

    variable OBJECT_TYPE

    log Notice "registerObject: type = '$type' ObjectId = '$ObjectId'"

    set OBJECT_TYPE($ObjectId) $type
}