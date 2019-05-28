
if {0} {
    ::wtk::log::log Debug "[file tail [info script]]: creating puzzle E1234000000000000P"
    set p [<< ::Sudoku::Puzzle -boxCols 2 -boxRows 2 -puzzleData E0000000000000000P >>]

    ::wtk::log::log Debug "[file tail [info script]]: running $p.init:"

    << $p.init >>

    << $p.solve >>

    # runs about 450k
    set p2 [<< ::Sudoku::Puzzle -boxCols 3 -boxRows 3 -puzzleData E000002800003040009090008030000000370030070005206000000700500081005200900000090400P >>]

    << $p2.init >>

    << $p2.solve >>

    set p3 [<< ::Sudoku::Puzzle -boxCols 2 -boxRows 3  -puzzleData E001506025100000300003000002410504600P >>]

    << $p3.init >>

    << $p3.solve >>

    set p4 [<< ::Sudoku::Puzzle -boxCols 3 -boxRows 3\
        -puzzleData E000007300800050402001020050000039020560000037040710000010070200302090008008100000P >>]

    << $p4.init >>
    << $p4.solve >>

    set p4 [<< ::Sudoku::Puzzle -boxCols 3 -boxRows 3\
        -puzzleData E000007300800050402001020050000039020560000037040710000010070200302090008008100000P >>]

    << $p4.init >>
    << $p4.solve >>

    set p5 [<< ::Sudoku::Puzzle -boxCols 2 -boxRows 2\
        -puzzleData E1234341200000000P >>]

    << $p5.init >>
    << $p5.solve >>
}