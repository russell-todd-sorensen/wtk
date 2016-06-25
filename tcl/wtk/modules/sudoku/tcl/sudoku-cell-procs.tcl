# Sudoku Cell: An abstract base class for all cell types
<< Class ::Sudoku::Cell \
    -ObjNameFormat SUDOKU_CELL%0.3i \
    -ObjCounter 0 \
    -VARIABLES {
	{puzzle {{}} - {}}
	{id {{}} - {string is integer -strict $id}}
	{type Cell - {expr {$type in {Cell Active ExitCell Fixed Print}}}}
    } \
    -NamespaceInitCode {
	::wtk::log::log Notice "NamespaceInitCode for Cell"
	variable type Cell
    }\
    +METHODS forward\
    +METHODS back\
    +METHODS getId\
    +METHODS getType\
>>

<< ::Sudoku::Cell.method forward {} {} PUBLIC >> ;# virtual
<< ::Sudoku::Cell.method back {} {} PUBLIC >>    ;# virtual

<< ::Sudoku::Cell.method getId {} {
    variable id
    return $id
} PUBLIC >>

<< ::Sudoku::Cell.method getType {} {
    variable type
    return $type
} PUBLIC >>
