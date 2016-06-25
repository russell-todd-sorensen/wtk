
if {0} {
    # Using Column Class directly:
    set colOnePos [<< $emp.incrColCount >>]

    set col1 [<< ::wtk::cor::Column\
	     -name emp_id\
	     -table employees\
	     -type integer\
	     +constraints {pk {}}\
	     -pos $colOnePos >>]
	     

    set colTwoPos [<< $emp.incrColCount >>]

    set col2 [<< ::wtk::cor::Column\
	     -name emp_name\
	     -table employees\
	     -type varchar(128)\
	      +constraints {un {}}\
	      +constraints {nn {}}\
	      -pos $colTwoPos >>]

    ::wtk::log::log Notice "<< \$col1.getPos >>= [<< $col1.getPos >>]"
    ::wtk::log::log Notice "<< \$col2.getPos >>= [<< $col2.getPos >>]"

}