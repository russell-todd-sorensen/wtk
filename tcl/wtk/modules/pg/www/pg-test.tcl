::wtk::form::parseQueryToArray $URL(query-)

if {[info exists QUERY(table)]} {
    set table $QUERY(table)
    set template pg-table
    set sqlCmd "select * from $table"
} else {
    set table "information_schema.tables"
}

if {$table eq "information_schema.tables" ||
    $table eq "information_schema.columns" ||
    $table eq "information_schema.column_privileges" ||
    $table eq "information_schema.column_domain_usage" ||
    $table eq "information_schema.constraint_column_usage" ||
    $table eq "information_schema.constraint_table_usage" ||
    $table eq "information_schema.column_udt_usage" ||
    $table eq "information_schema.role_column_grants" ||
    $table eq "information_schema.role_table_grants" ||
    $table eq "information_schema.table_constraints" ||
    $table eq "information_schema.table_privileges" ||
    $table eq "information_schema.view_column_usage" ||
    $table eq "information_schema.view_routine_usage" ||
    $table eq "information_schema.views" ||
    $table eq "information_schema.view_table_usage"
} {
    set template pg-test
    set sqlCmd "select * 
from 
 $table
order by 
 table_catalog, 
 table_schema,
 table_name"
}

if {[info exists QUERY(db)]} {
    set db $QUERY(db)
} else {
    set db russell
}

set dbHandle [::wtk::pg::getHandle $db]

if {$dbHandle eq ""} {
    return -code error "pg-test.tcl: no database handles available"
}



set rs         [pg_exec $dbHandle $sqlCmd]
set status     [pg::result $rs -status]
set conndefaults   [pg::conndefaults]
set attributes [list]
set rows       [list]

switch -exact -- $status {
    "PGRES_TUPLES_OK" {
	set attributes [pg::result $rs -attributes]
	set rows [pg::result $rs -llist]
    }
    "PGRES_FATAL_ERROR" {
	::wtk::pg::releaseHandle $dbHandle 
	return -code error "pg-test.tcl: Postgres Fatal Error"
    }
    default {
	::wtk::log::log Notice "pg-test.tcl result status is '$status'"
    }
}

pg::result $rs -clear

::wtk::pg::releaseHandle $dbHandle

::t3::respond $connId $template text/html 200


