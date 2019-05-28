# Sudoku DataCell class adds "value" variable

<< Class ::Sudoku::DataCell +Public ::Sudoku::Cell \
    -ObjNameFormat SUDOKU_DATACELL%0.3i \
    -ObjCounter 0 \
    -VARIABLES {
        {value 0 - {string is integer -strict $value}}
    } \
    +METHODS getValue\
>>

# Following methods are inherited and not used in this class:
#<< ::Sudoku::Cell.method forward {} {} PUBLIC >> ;# virtual
#<< ::Sudoku::Cell.method back {} {} PUBLIC >>    ;# virtual

<< ::Sudoku::DataCell.method getValue {} {
    variable value
    return $value
} PUBLIC >>
