
log Notice ":::::::::::::::::::::: TEST OOP PACKAGE ::::::::::::::::::::::"
<< Class ::Shape::Rect \
    -ObjNameFormat SHAPE_RECT%0.3i\
    -ObjCounter 0 \
    -VARIABLES {{x 0 - {}} {y 0 - {}}} \
    +METHODS getX +METHODS getY +METHODS getArea \
>>

namespace eval ::Shape::Rect {

    variable PUBLIC_getX [list {} {
    variable x
    return $x
    }]

    variable PUBLIC_getY [list {} {
    variable y
    return $y
    }]
    variable PUBLIC_getArea [list {} {
    variable x
    variable y
    expr {$x * $y}
    }]

}

<< Class ::Shape::Box \
    -ObjNameFormat SHAPE_BOX%0.3i\
    -ObjCounter 0\
    -VARIABLES {
    {z 0 - {}}
    } \
    +METHODS getZ +METHODS getArea +METHODS getVolume \
    +Public ::Shape::Rect \
>>

if {0} {
namespace eval ::Shape::Box {

    variable PUBLIC_getZ [list {} {
    variable z
    return $z
    }]
    variable PUBLIC_getArea [list {} {
    variable x
    variable y
    variable z
    expr { 2 * ( ($x * $y) + ($x * $z) + ($y * $z) ) }
    }]
    variable PUBLIC_getVolume  [list {} {
    variable x
    variable y
    variable z
    expr {$x * $y * [<< [this].getZ >>]}
    }]

}
}

# Add methods:
<< ::Shape::Box.method getZ {} {
    variable z
    return $z
} PUBLIC >>

<< ::Shape::Box.method getArea {} {
    variable x
    variable y
    variable z
    expr { 2 * ( ($x * $y) + ($x * $z) + ($y * $z) ) }
} PUBLIC >>

<< ::Shape::Box.method getVolume {} {
    variable x
    variable y
    variable z
    expr {$x * $y * [<< [this].getZ >>]}
} PUBLIC >>


<< Class ::Shape::Circle \
    -ObjNameFormat SHAPE_CIRCLE%0.3i\
    -ObjCounter 0\
    -VARIABLES {{r 0 - {}}} \
    +METHODS PUBLIC_getR\
    +METHODS PUBLIC_getArea\
>>

if {0} {
namespace eval ::Shape::Circle {

    variable PUBLIC_getR [list {} {
    variable r
    return $r
    }]
    variable PUBLIC_getArea [list {} {
    variable r
    expr {3.14159 * $r * $r}
    }]
    variable PUBLIC_getCircumference [list {} {
    variable r
    expr {2 * 3.14159 * $r}
    }]

}
}

<< ::Shape::Circle.method getR {} {
    variable r
    return $r
} PUBLIC >>
<< ::Shape::Circle.method getArea {} {
    variable r
    expr {3.14159 * $r * $r}
} PUBLIC >>
<< ::Shape::Circle.method getCircumference {} {
    variable r
    expr {2 * 3.14159 * $r}
} PUBLIC >>


<< Class ::Shape::Cylinder \
    -ObjNameFormat SHAPE_CYL%0.3i\
    -ObjCounter 0\
    -VARIABLES {{h 0 - {}}}\
    +METHODS PUBLIC_getH \
    +METHODS PUBLIC_getVolume \
    +Public ::Shape::Circle \
>>


if {0} {
namespace eval ::Shape::Cylinder {
    variable PUBLIC_getH [list {} {
    variable h
    return $h
    }]
    variable PUBLIC_getArea [list {} {
    variable r
    variable h
    expr { (2.0 * 3.14159 * $r * $r) + (2.0 * $r * $h * 3.14159) }
    }]
    variable PUBLIC_getVolume [list {} {
    variable h
    variable r
    expr {3.14159 * $r * $r * $h}
    }]
}
}

<< ::Shape::Cylinder.method getH {} {
    variable h
    return $h
} PUBLIC >>

<< ::Shape::Cylinder.method getArea {} {
    variable r
    variable h
    expr { (2.0 * 3.14159 * $r * $r) + (2.0 * $r * $h * 3.14159) }
} PUBLIC >>

<< ::Shape::Cylinder.method getVolume {} {
    variable h
    variable r
    expr {3.14159 * $r * $r * $h}
} PUBLIC >>


#showVars ::CLASSES::Class::Rect

set myRect [<< ::Shape::Rect.new -y 5 -x 3 >>]
set myRect2 [<< ::Shape::Rect -x 4 -y 7 >>]
set myCyl [<< ::Shape::Cylinder -r 10 -h 3 >>]
log Notice "myRect.getX = '[<< $myRect.getX >>]'"
log Notice "myRect2.getY = '[<< $myRect2.getY >>]'"
log Notice "myCyl.getR = '[<< $myCyl.getR >>]'"
log Notice "myCyl.getH = '[<< $myCyl.getH >>]'"
log Notice "myCyl.getVolume = '[<< $myCyl.getVolume >>]'"


#showVars ::CLASSES::Class::Cylinder
set cylinders [list]
set volumes [list]
set r 1
set h 1
set time [time {
    set cyl [<< ::Shape::Cylinder -r [incr r] -h [expr {[incr h] * .1}] >>]
    lappend cylinders $cyl
    lappend volumes [<< $cyl.getVolume >>]

} 10]

log Notice "time = $time"

foreach cyl $cylinders vol $volumes {
   log Notice "<< $cyl.getVolume >> = $vol"

}

log Notice "time = $time"

set cyl [<< ::Shape::Cylinder -r 1 -h 2 >>]

log Notice "<< $cyl.getR >> = [<< $cyl.getR >>]"
log Notice "<< $cyl.getH >> = [<< $cyl.getH >>]"
log Notice "<< $cyl.getArea = [<< $cyl.getArea >>]"
log Notice "<< $cyl.getVolume >> = [<< $cyl.getVolume >>]"



set myBox [<< ::Shape::Box -x 3 -y 4 -z 5 >>]

log Notice "<< $myBox.getX >>      = [<< $myBox.getX >>]"
log Notice "<< $myBox.getY >>      = [<< $myBox.getY >>]"
log Notice "<< $myBox.getZ >>      = [<< $myBox.getZ >>]"
log Notice "<< $myBox.getArea >>   = [<< $myBox.getArea >>]"
log Notice "<< $myBox.getVolume >> = [<< $myBox.getVolume >>]"

log Notice "::::::::::::::::: END TEST OOP PACKAGE ::::::::::::::::::::::"