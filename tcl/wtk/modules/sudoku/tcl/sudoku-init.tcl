set fileDirectory [file dirname [info script]]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-puzzle-init.tcl]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-cell-init.tcl]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-exitcell-init.tcl]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-printcell-init.tcl]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-datacell-init.tcl]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-fixedcell-init.tcl]
::wtk::modules::sourceFile [file join $fileDirectory sudoku-activecell-init.tcl]


