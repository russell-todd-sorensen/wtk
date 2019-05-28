

if {0} {
    set myFixedCell [<< ::Sudoku::FixedCell\
        -type FixedCell -puzzle SUDOKU_PUZZLE001\
        -id 1 -value 5 >>]

    log Debug "<< $myFixedCell.getId >> =   '[<< $myFixedCell.getId >>]'"
    log Debug "<< $myFixedCell.getType >> = '[<< $myFixedCell.getType >>]'"
    log Debug "<< $myFixedCell.getValue >> = '[<< $myFixedCell.getValue >>]'"
    log Debug "<< $myFixedCell.forward >> = '[<< $myFixedCell.forward >>]'"
    log Debug "<< $myFixedCell.back >> = '[<< $myFixedCell.back >>]'"
}