source /www/tcl/wtk/init.tcl


# test base shape is a box with dim x and y

<< Class ::wtk::cor::base \
    -ObjNameFormat COR_BASE%03i \
    -ObjCounter 0 \
    -VARIABLES {
    {x {0} - {}}
    {y {0} - {}}
    }\
    +METHODS getX\
    +METHODS getY\
    +METHODS getArea\
>>

<< ::wtk::cor::base.method getX {} {
    variable x
    set x
} >>

<< ::wtk::cor::base.method getY {} {
    variable y
    set y
} >>

<< ::wtk::cor::base.method getArea {} {
    variable x
    variable y
    expr {$x * $y}
} >>


# test derived type Volume adds dim z plus volume Method
# redefines getArea.

<< Class ::wtk::cor::Volume +Public ::wtk::cor::base\
    -ObjNameFormat COR_VOL%03i \
    -ObjCounter 0 \
    -VARIABLES {
        {z {0} - {}}
    }\
    +METHODS getVolume\
    +METHODS getArea\
    +METHODS printVolume\
>>

<< ::wtk::cor::Volume.method getArea {} {
    variable y
    variable x
    variable z
    expr {2*(($y * $x) + ($y * $z) + ($x * $z))}
} PUBLIC >>

<< ::wtk::cor::Volume.method getVolume {} {
    variable y
    variable x
    variable z
    expr {$x * $y * $z}
} >>

<< ::wtk::cor::Volume.method printVolume {} {
    variable y
    variable x
    variable z
    set volume [expr {$x * $y * $z}]
    return "$volume cubic units"
} >>


set myVolume [<< ::wtk::cor::Volume -x 5 -y 3 -z 4 >>]

::wtk::log::log Notice "$myVolume.getVolume = [<< $myVolume.getVolume >>]"
::wtk::log::log Notice "$myVolume.printVolume = [<< $myVolume.printVolume >>]"

::wtk::log::log Notice "$myVolume.getArea = [<< $myVolume.getArea >>]"
