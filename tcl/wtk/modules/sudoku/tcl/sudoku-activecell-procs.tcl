# Sudoku ActiveCell class:
#    adds: cellMask, index and end vars,
#    redefines: forward & back
#
#######

<< Class ::Sudoku::ActiveCell +Public ::Sudoku::DataCell \
    -ObjNameFormat SUDOKU_ACTIVECELL%0.3i \
    -ObjCounter 0 \
    -VARIABLES {
        {cellMask 0 - {string is integer -strict $cellMask}}
        {index 0 - {string is integer -strict $index}}
        {end 0 - {}}
    } \
    -InitCode {
        {
        set end [<< $puzzle.getPuzzleDimension >>]
        ::wtk::log::log Debug "set end to '$end'"
        set type Active
        }
    }\
    +METHODS forward +METHODS back\
>>

# Following methods are redefined in this class:
<< ::Sudoku::ActiveCell.method forward {} {

    variable id
    variable puzzle
    variable cellMask
    variable index
    variable end
    variable value

    #::wtk::log::log Debug "[this].forward "
    set cellMask [<< $puzzle.getCellMask $id >>]
    set index 0

    while {(($index <= $end) && ($cellMask & (1 << $index)) == 0) } {
        #::wtk::log::log Debug "ActiveCell.forward index = '$index' cellMask = '$cellMask' "
        incr index
    }

    ::wtk::log::log Debug "[this].forward cellMask = '$cellMask' index =\
        $index value = '[expr {($index >= $end) ? 0 : $index}]'\
        symbol = '[lindex [split $::Sudoku::defaultSymbols ""] $index]'"

    if {$index > $end} {
        set value 0
        return "-1"
    }

    set value $index
    << $puzzle.setCell $id $index >>
    return "1"

} PUBLIC >>


<< ::Sudoku::ActiveCell.method back {} {

    variable id
    variable puzzle
    variable cellMask
    variable index
    variable end
    variable value

    << $puzzle.unsetCell $id $index >> ; # mask |= 1<< index
    set cellMask [<< $puzzle.getCellMask $id >>]

    while {(([incr index] <= $end) && ($cellMask & (1<< $index)) == 0)} {
        # note no while body
        # we are just fast forwarding past invalid choices
    }

    if {$index > $end} {
        set value 0
        return "-1"
    }

    set value $index;

    << $puzzle.setCell $id $index >> ;# // mask &= ~(1<< index)

    return "1"

} PUBLIC >>
