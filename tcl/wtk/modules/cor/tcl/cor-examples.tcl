
# Example of creating a table:


set emp [<< ::wtk::cor::Table\
    -name employees\
    -abbrev emp\
    -primaryKeys [list emp_id]\
    +comments "This is the employees table\n now what? \n--oh yeah, right!"\
    +comments "Check out the multi-column constraint"\
    +tableConstraints {un "emp_name emp_birthdate"} >>]


<< $emp.addColumns {
    {emp_id integer {{nn ""} {pk ""}} {{This is the EmployeeID column}}}
    {emp_name "varchar(128)" {{nn ""}} {"The employee's Name\n who cares?"} }
    {emp_birthdate date {{nn ""}} {{The employee's birthdate}}}
} >>


# Print the employees table
::wtk::log::log Notice "........emp = '$emp'"
::wtk::log::log Notice "<< \$emp.getName >> = [<< $emp.getName >>]"

::wtk::log::log Notice "\n[<< $emp.printSql xyz 4 >>]"
