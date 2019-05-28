

if {0} {
    set myActiveCell [<< ::Sudoku::ActiveCell\
        -type ActiveCell -puzzle SUDOKU_PUZZLE001\
        -id 1 -value 5 >>]

    log Debug "<< $myActiveCell.getId >> =   '[<< $myActiveCell.getId >>]'"
    log Debug "<< $myActiveCell.getType >> = '[<< $myActiveCell.getType >>]'"
    log Debug "<< $myActiveCell.getValue >> = '[<< $myActiveCell.getValue >>]'"
    log Debug "<< $myActiveCell.forward >> = '[<< $myActiveCell.forward >>]'"
    log Debug "<< $myActiveCell.back >> = '[<< $myActiveCell.back >>]'"
    log Debug "<< SUDOKU_PUZZLE001.getCellMask >> = '[<< SUDOKU_PUZZLE001.getCellMask 5 >>]'"
}