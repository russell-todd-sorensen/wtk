source test.tcl

set db [<< ::wtk::cor::Database\
	    -name mydb\
	    -abbrev mydb\
	    +comments "Database mydb" >>]

set schema [<< ::wtk::cor::Schema\
		-name biz\
		-abbrev biz2  >>]

<< $db.addSchema $schema >>

set module [<< ::wtk::cor::Module\
		-name biz1\
		-abbrev b1  >>]


<< $schema.addModule $module >>

set emp [<< ::wtk::cor::Table\
	     -name employees\
	     -abbrev emp1\
	     -primaryKeys [list emp_id]\
	     +comments "This is the employees table\n now what? \n--oh yeah, right!"\
	     +comments "Check out the multi-column constraint"\
	     +tableConstraints {un "emp_name emp_birthdate"} >>]


<< $emp.addColumns {
    {emp_id integer {{nn ""} {pk ""}} {{This is the EmployeeID column}}}
    {emp_name varchar(128) {{nn ""}} {"The employee's Name\n who cares?"} }
    {emp_birthdate date {{nn ""}} {{The employee's birthdate}}}
} >>


<< $module.addTable $emp >>

# myExtraPKCols Table:

set mepkTable [<< ::wtk::cor::Table\
		   -name my_extra_pk_cols_table\
		   -abbrev mepc\
		   -primaryKeys [list a b c]\
		   +tableConstraints {pk {a b c}} >>]

<< $mepkTable.addColumns {
    {a integer {{nn ""}}}
    {b varchar(10) {{nn ""}}}
    {c char {{nn ""} {df 'a'}}}
    {d text}
} >>

<< $module.addTable $mepkTable >>
		   

::wtk::log::log Notice "db = [<< $db.printSql >>]"