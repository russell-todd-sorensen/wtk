set fileDirectory [file dirname [info script]]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-puzzle-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-cell-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-exitcell-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-printcell-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-datacell-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-fixedcell-procs.tcl]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-activecell-procs.tcl]


