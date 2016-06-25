if {0} {

    set myCell [<< ::Sudoku::ExitCell -id 0 -type ExitCell >>]

    log Debug "<< $myCell.getId >> =   '[<< $myCell.getId >>]'"
    log Debug "<< $myCell.getType >> = '[<< $myCell.getType >>]'"
    log Debug "<< $myCell.forward >> = '[<< $myCell.forward >>]'"
}