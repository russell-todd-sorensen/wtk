
if {0} {
    set myDataCell [<< ::Sudoku::DataCell\
			-type DataCell -puzzle SUDOKU_PUZZLE001\
			-id 1 -value 5 >>]

    log Debug "<< $myDataCell.getId >> =   '[<< $myDataCell.getId >>]'"
    log Debug "<< $myDataCell.getType >> = '[<< $myDataCell.getType >>]'"
    log Debug "<< $myDataCell.getValue >> = '[<< $myDataCell.getValue >>]'"
    log Debug "<< $myDataCell.forward >> = '[<< $myDataCell.forward >>]'"
    log Debug "<< $myDataCell.back >> = '[<< $myDataCell.back >>]'"

}