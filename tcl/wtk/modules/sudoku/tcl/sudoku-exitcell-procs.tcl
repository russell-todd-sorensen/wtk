# Sudoku ExitCell class:
#    redefines: forward & back
#
####
#
::wtk::log::log Debug "...........!!! ExitCell Definition"

<< Class ::Sudoku::ExitCell +Public ::Sudoku::Cell \
    -ObjNameFormat SUDOKU_EXITCELL%0.3i \
    -ObjCounter 0 \
    -VARIABLES {
    } \
    +METHODS forward +METHODS back\
>>

<< ::Sudoku::ExitCell.method forward {} {return 0} PUBLIC >> 
<< ::Sudoku::ExitCell.method back {} {::wtk::log::log Notice "ExitCell...exiting"; return 0} PUBLIC >>

::wtk::log::log Debug "...........!!! End ExitCell Definition"