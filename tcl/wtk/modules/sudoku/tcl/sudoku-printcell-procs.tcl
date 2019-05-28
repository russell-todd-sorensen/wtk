# Sudoku PrintCell class:
#   redefines forward & back
#
####
#

<< Class ::Sudoku::PrintCell +Public ::Sudoku::Cell \
    -ObjNameFormat SUDOKU_PRINTCELL%0.3i \
    -ObjCounter 0 \
    +METHODS forward +METHODS back\
    -InitCode {
        {set type Print}
    }\
>>

<< ::Sudoku::PrintCell.method forward {} {

    variable puzzle
    << $puzzle.print >>
    return -1

} PUBLIC >>

<< ::Sudoku::PrintCell.method back {} {return 0} PUBLIC >>
