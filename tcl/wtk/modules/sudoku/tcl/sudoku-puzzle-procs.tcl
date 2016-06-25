
namespace eval ::Sudoku {
    variable defaultSymbols "123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcd";
}

<< Class ::Sudoku::Puzzle \
    -ObjNameFormat SUDOKU_PUZZLE%0.3i \
    -ObjCounter 0 \
    -VARIABLES {
	{boxCols 9 - {string is integer -strict $boxCols}}
	{boxRows 9 - {string is integer -strict $boxRows}}
	{puzzleData 0 - {}}
	{puzzleDimension 81 - {set puzzleDimension [expr {$boxCols*$boxRows}]}}
	{symbols {} - {
	    # symbols come in as string 123456789 => [list 1 2 3 4 5 6 7 8 9]
	    if {![info exists symbols]} {
		set symbols [split [string range $::Sudoku::defaultSymbols 0 [expr {$puzzleDimension -1}]] ""]
	    } else {
		set symbols [split $symbols ""]
	    }
	}
	}
    } \
    +METHODS init \
    +METHODS solve\
    +METHODS print\
    +METHODS getPuzzleDimension\
    +METHODS getBoxCols\
    +METHODS getBoxRows\
    +METHODS getPuzzleData\
    +METHODS getSymbols\
    +METHODS setCell\
    +METHODS unsetCell\
>>
    
<< ::Sudoku::Puzzle.method init {} {

    set puzzle [this]

    variable boxRows
    variable boxCols
    variable cellRow  [list "0"]
    variable cellCol  [list "0"]
    variable cellBox  [list "0"]
    variable CELLBOX  [list "0"]
    variable cellType [list "E"]
    variable puzzleDimension
    variable symbols
    variable activeCells [expr {$puzzleDimension * $puzzleDimension} ]
    variable puzzleData [split $puzzleData ""]
    
    set puzzleMask [expr {(1<<$puzzleDimension)-1}]
    variable rowMask [list $puzzleMask]
    variable colMask [list $puzzleMask]
    variable boxMask [list $puzzleMask]
    
    variable symbol_index [list]
    variable Cells [list]
    for {set i 0} {$i <= 256} {incr i} {
	lappend symbol_index x
    }
    puts "symbol_index = $symbol_index"
    puts "symbols = $symbols"
    for {set i 0} {$i < $puzzleDimension} {incr i} {
	set index  [scan [lindex $symbols $i] %c]
	puts " i = $i, index = $index"
	lset symbol_index $index $i
    }

    for {set i 1} {$i < [expr {$puzzleDimension +1}]} {incr i} {
	lappend rowMask $puzzleMask
	lappend colMask $puzzleMask
	lappend boxMask $puzzleMask
    }

    puts "activeCells = $activeCells"

    lappend Cells [<< ::Sudoku::ExitCell -id 0 -type ExitCell -puzzle $puzzle >>]
    for {set i 1} {$i <= $activeCells} {incr i} {
	lappend cellRow [expr {(($i -1)/$puzzleDimension + 1)}]
	lappend cellCol [expr {(($i -1)%$puzzleDimension + 1)}]
	lappend cellBox [expr {(([lindex $cellCol $i] -1)/$boxRows + 1 + (([lindex $cellRow $i] -1)/$boxCols)*$boxCols)}]
	lappend CELLBOX [lindex $cellBox $i]

	if {[lindex $puzzleData $i] == "0"} {
	    lappend cellType "A"
	    puts "i = $i, Active cell"
	    lappend Cells [<< ::Sudoku::ActiveCell -puzzle $puzzle\
			       -type Fixed\
			       -value 0\
			       -id $i >>]
	} else {
	    lappend cellType "F"
	    set index [scan [lindex $puzzleData $i] %c]   ;# ???
	    puts "Puzzle.init: i = '$i', \[lindex $puzzleData $i\] = '[lindex $puzzleData $i]'"
	    set cellValue [lindex $symbol_index $index]   ;# ???
	    puts "Puzzle.init: index = '$index', cellValue = '$cellValue'"
	    set CR [lindex $cellRow $i]
	    set CC [lindex $cellCol $i]
	    set CB [lindex $cellBox $i]
	    puts "i = $i, CR = $CR, CC = $CC CB = $CB cellValue = $cellValue"
	    #puts "\[lindex \$rowMask $CR\] & ~(1<< $cellValue) = [lindex $rowMask $CR] & [expr {~(1<<$cellValue)}] = [expr {[lindex $rowMask $CR] & ~(1<< $cellValue)}]"
	    
	    lset rowMask $CR [expr {[lindex $rowMask $CR] & ~(1<< $cellValue)}]
	    lset colMask $CC [expr {[lindex $colMask $CC] & ~(1<< $cellValue)}]
	    lset boxMask $CB [expr {[lindex $boxMask $CB] & ~(1<< $cellValue)}]
	    puts "rowMask $i = [lindex $rowMask $i]"
	    puts "colMask $i = [lindex $colMask $i]"
	    puts "boxMask $i = [lindex $boxMask $i]"

	    lappend Cells [<< ::Sudoku::FixedCell -puzzle $puzzle\
			       -value $cellValue\
			       -row $CR\
			       -col $CC\
			       -box $CB\
			       -type Fixed\
			       -id $i >>]
	}

    }

    lappend Cells [<< ::Sudoku::PrintCell -puzzle $puzzle\
		       -row 100\
		       -col 100\
		       -box 100\
		       -type Print\
		       -id $i >>]

} PUBLIC >>


<< ::Sudoku::Puzzle.method getCellMask {id} {
    variable rowMask
    variable colMask
    variable boxMask
    variable cellRow
    variable cellCol
    variable cellBox
    set CR [lindex $cellRow $id]
    set CC [lindex $cellCol $id]
    set CB [lindex $cellBox $id]
    ::wtk::log::log Debug "cellRow = $cellRow"
    ::wtk::log::log Debug "cellCol = $cellCol"
    ::wtk::log::log Debug "cellBox = $cellBox"

    ::wtk::log::log Debug "id = $id \[lindex $rowMask $CR\] = [lindex $rowMask $CR] \[lindex $colMask $CC\] = [lindex $colMask $CC] \[lindex $boxMask $CB\] [lindex $boxMask $CB]"
    expr {[lindex $rowMask $CR] & [lindex $colMask $CC] & [lindex $boxMask $CB]}
} PUBLIC >>
    

<< ::Sudoku::Puzzle.method unsetCell {id index} {
    variable rowMask
    variable colMask
    variable boxMask
    variable cellRow
    variable cellCol
    variable cellBox
    variable symbols
    variable puzzleData

    set CR [lindex $cellRow $id]
    set CC [lindex $cellCol $id]
    set CB [lindex $cellBox $id]

    set cellValue [expr {(1<< $index)}]
    
    lset rowMask $CR [expr {[lindex $rowMask $CR] | $cellValue}]
    lset colMask $CC [expr {[lindex $colMask $CC] | $cellValue}]
    lset boxMask $CB [expr {[lindex $boxMask $CB] | $cellValue}]

    lset puzzleData $id 0
    return

} PUBLIC >>
  
<< ::Sudoku::Puzzle.method setCell {id index} {

    variable rowMask
    variable colMask
    variable boxMask
    variable cellRow
    variable cellCol
    variable cellBox
    variable symbols
    variable puzzleData

    set CR [lindex $cellRow $id]
    set CC [lindex $cellCol $id]
    set CB [lindex $cellBox $id]

    set cellValue [expr {(1<< $index)}]

    ::wtk::log::log Debug "setCell CellRow = $CR cellCol = $CC cellBox = $CB cellValue = $cellValue "
    ::wtk::log::log Debug "setCell rowMask = '[lindex $rowMask $CR]' [lindex $rowMask $CR] & ~($cellValue) = [expr {[lindex $rowMask $CR] & ~($cellValue)}]'"

    lset rowMask $CR [expr {[lindex $rowMask $CR] & ~($cellValue)}]
    lset colMask $CC [expr {[lindex $colMask $CC] & ~($cellValue)}]
    lset boxMask $CB [expr {[lindex $boxMask $CB] & ~($cellValue)}]
    
    ::wtk::log::log Debug "setCell rowMask = $rowMask"
    ::wtk::log::log Debug "setCell colMask = $colMask"
    ::wtk::log::log Debug "setCell boxMask = $boxMask"

    lset puzzleData $id [lindex $symbols $index]

    return

} PUBLIC >>
    


<< ::Sudoku::Puzzle.method getPuzzleDimension {} {
    variable puzzleDimension
    return $puzzleDimension
} PUBLIC >>


<< ::Sudoku::Puzzle.method print {} {

    variable puzzleData
    variable count
    variable solution
    variable activeCells
    variable puzzleDimension
    variable cellBox
    variable boxRows

    incr solution

    set output ""
    for {set i  1} {$i <= $activeCells} {incr i} {
					    
	append output "[lindex $puzzleData $i] "
	
	if {($i % $puzzleDimension) == 0 } {
	    append output "\n"
	    if {($puzzleDimension * [lindex $cellBox $i]) == $i} {
		append output "\n"
	    }
	} elseif {($i % $boxRows)  == 0 } {
	    append output "  ";
	}
    }

    ::wtk::log::log Notice "count = $count solution\# = $solution solution = \n$output"

    return -1

} PUBLIC >>


<< ::Sudoku::Puzzle.method solve {} {

    variable Cells
    variable count
    variable solution 0
    

    set puzzle [this]

    set index 1
    set direction forward 
    set count 0
    while {[set change [<< [lindex $Cells $index].$direction >>]] != 0  && $count < 1000000 } {
	incr index $change
	incr count
	switch -exact $change {
	    1 {
		set direction forward
	    }
	    -1 {
		set direction back
	    }
	    0 - default {
		break
	    }
	}
	::wtk::log::log Debug "Puzzle count='$count', dir='$direction', index='$index' cell = [lindex $Cells $index]"
    }
    ::wtk::log::log Notice "Exiting puzzle $puzzle with count $count"

} PUBLIC >>
