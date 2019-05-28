# Sudoku FixedCell class:
# redefines: forward & back
#
#####
#

<< Class ::Sudoku::FixedCell +Public ::Sudoku::DataCell \
    -ObjNameFormat SUDOKU_FIXEDCELL%0.3i \
    -ObjCounter 0 \
    +METHODS forward +METHODS back\
>>

#Following methods are redefined in this class:
<< ::Sudoku::FixedCell.method forward {} {return "1"} PUBLIC >>
<< ::Sudoku::FixedCell.method back {} {return "-1"} PUBLIC >>
