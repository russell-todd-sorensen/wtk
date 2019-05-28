
if {0} {
    set myCell [<< ::Sudoku::Cell \
        -type Fixed -puzzle SUDOKU_PUZZLE001\
        -id 1 >>]

    log Debug "<< $myCell.getId >> =   '[<< $myCell.getId >>]'"
    log Debug "<< $myCell.getType >> = '[<< $myCell.getType >>]'"
    log Debug "<< $myCell.forward >> = '[<< $myCell.forward >>]'"
}