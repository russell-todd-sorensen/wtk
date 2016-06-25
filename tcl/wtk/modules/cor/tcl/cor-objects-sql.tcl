# Example of the cordb.cor_identities table:

namespace eval ::wtk::db::instance::mydb {

set db2 [<< ::wtk::db::Database -name mydb -abbrev mydb >>]

set mydbSchema [<< ::wtk::db::Schema -name cordb -abbrev "" -database $db2 >>]

<< $db2.addSchema $mydbSchema >>

set myModule [<< ::wtk::db::Module -name cor -abbrev cor -schema $mydbSchema >>]

<< $mydbSchema.addModule $myModule >>

set corTables [list]

# Classes table:

lappend corTables [<< ::wtk::db::Table\
		       -name classes\
		       -singular class\
		       -abbrev cla\
		       -module $myModule\
		       -primaryKeys {class_id}\
		       +tableConstraints {pk {class_id}}\
		       +comments "COR Classes table" >>]

<< [lindex $corTables end].addColumns {
    {class_id integer {{nn ""}}}
    {class_name "varchar(128)" {{nn ""} {un ""}}}
    {class_desr "varchar(1024)" {{nn ""}}}
    {class_table "name" {{nn ""}}}
} >>

lappend corTables [<< ::wtk::db::Table\
		       -name objects\
		       -singular object\
		       -abbrev obj\
		       -module $myModule\
		       -primaryKeys {object_id}\
		       +comments "COR Objects table" >>]

<< [lindex $corTables end].addColumns {
    {object_id integer {{pk ""} {nn ""}}}
    {class_id integer {{fk {classes}} {nn ""}}}
    {obj_owner integer {{df 100} {nn ""}}}
    {create_date timestamptz {{df {now()}} {nn ""}}}
    {change_date timestamptz {{df {now()}} {nn ""}}}
    {object_descr text {{nn ""}}}
} >>

lappend corTables [<< ::wtk::db::Table\
		       -name attribute_types\
		       -singular attribute_type\
		       -abbrev cat\
		       -module $myModule\
		       -primaryKeys {attr_type_id}\
		       +comments "COR Attributes Table" >>]

<< [lindex $corTables end].addColumns {
    {attr_type_id integer {{pk ""} {nn ""}}}
    {attr_type_name "varchar(255)" {{nn ""}}}
    {attr_sql_type "varchar(255)" {{nn ""}}}
    {attr_type_descr "varchar(255)" {{nn ""}}}
} >>

lappend corTables [<< ::wtk::db::Table\
		       -name attributes\
		       -singular attribute\
		       -abbrev att\
		       -module $myModule\
		       -primaryKeys {attribute_id}\
		       +tableConstraints {un {class_id attr_name}} >>]

<< [lindex $corTables end].addColumns {
    {attribute_id integer {{pk ""} {nn ""} {fk {objects object_id}}}}
    {class_id integer {{nn ""} {fk {classes}}}}
    {attr_type_id integer {{nn ""} {fk {attribute_types}}}}
    {attr_order integer {{nn ""} {df 1}}}
    {attr_name "name" {{nn ""}}}
    {attr_comment text {{nn ""}}}
} >>


######### RELATIONS TABLE

lappend corTables [<< ::wtk::db::Table\
		       -name relations\
		       -singular relation\
		       -abbrev rel\
		       -module $myModule\
		       -primaryKeys {subject_id predicate_id object_id}\
		       +tableConstraints {pk {subject_id predicate_id object_id}}\
		       +tableConstraints {un {subject_id object_id predicate_id}}\
		       +tableConstraints {un {object_id predicate_id subject_id}} >>]

<< [lindex $corTables end].addColumns {
    {subject_id integer {{nn ""} {fk {objects object_id}}}}
    {object_id integer {{nn ""} {fk {objects object_id}}}}
    {predicate_id integer {{nn ""} {fk {objects object_id}}}}
    {sort_order integer {{nn ""} {df 1}}}
} >>


########## IDENTITY TYPES TABLE #############

lappend corTables [<< ::wtk::db::Table\
		       -name identity_types\
		       -singular identity_type\
		       -abbrev itp\
		       -module $myModule\
		       -primaryKeys {type_id} >>]
		       
<< [lindex $corTables end].addColumns {
    {type_id integer {{nn ""} {pk ""}}}
    {identity_type_name "varchar(128)" {{nn ""} {un ""}}}
    {type_descr "varchar(1024)" {{nn ""}}}
} >>


######### DOMAINS TABLE ###############

lappend corTables [<< ::wtk::db::Table\
		       -name domains\
		       -singular domain\
		       -abbrev dom\
		       -module $myModule\
		       -primaryKeys {domain_id} >>]

<< [lindex $corTables end].addColumns {
    {domain_id integer {{nn ""} {pk ""} {fk {objects object_id}}}}
    {domain_name "varchar(128)" {{nn ""}}}
    {domain_descr "varchar(1024)" {{nn ""}}}
} >>


####### ENCRYPTION METHODS TABLE #####

lappend corTables [<< ::wtk::db::Table\
		       -name encryption_methods\
		       -singular encryption_method\
		       -abbrev enc\
		       -module $myModule\
		       -primaryKeys {method_id} >>]

<< [lindex $corTables end].addColumns {
    {method_id integer {{nn ""} {pk ""}}}
    {method_name "varchar(128)" {{nn ""} {un ""}}}
    {method_descr "varchar(1024)" {{nn ""}}}
} >>


######### Identities table ###########

lappend corTables [<< ::wtk::db::Table\
		       -name identities\
		       -singular identity\
		       -abbrev idt\
		       -module $myModule\
		       -primaryKeys [list identity_id]\
		       +comments "This is the Identities table"\
		       +tableConstraints {un "ident_domain_id ident_login_name"} >>]

<< [lindex $corTables end].addColumns {
    {identity_id integer {{pk ""} {fk "objects object_id"} {nn ""}} }
    {ident_type_id integer {{fk "identity_types type_id"} {nn ""} } }
    {ident_domain_id integer {{fk "domains domain_id"} {df "1"} {nn ""}} }
    {ident_name "varchar(128)" {{nn ""}} }
    {ident_login_name "varchar(128)" {{nn ""}} }
    {ident_password_hash "varchar(512)" {{nn ""} {df "'XXXXXXXX'"}} }
    {ident_password_salt "varchar(512)" {{nn ""} {df "'12345678'"}} }
    {encryption_method integer {{fk "encryption_methods method_id"} {df "1"} {nn ""}} {{Default encryption method is sha1}} }
    {ident_descr text {{nn ""}} }
} >>

################## USER TYPES TABLE ############

lappend corTables [<< ::wtk::db::Table\
		       -name user_types\
		       -singular user_type\
		       -abbrev ust\
		       -module $myModule\
		       -primaryKeys {type_id} >>]

<< [lindex $corTables end].addColumns {
    {type_id integer {{nn ""} {pk ""}}}
    {type_name "varchar(128)" {{nn ""} {un ""}}}
    {type_descr "varchar(1024)" {{nn ""}}}
} >>


################## USERS TABLE ############

lappend corTables [<< ::wtk::db::Table\
		       -name users\
		       -singular user\
		       -abbrev usr\
		       -module $myModule\
		       -primaryKeys {user_id} >>]

<< [lindex $corTables end].addColumns {
    {user_id integer {{nn ""} {pk ""} {fk {identities identity_id}}}}
    {user_type_id integer {{nn ""} {df 2} {fk {user_types type_id}}}}
} >>



foreach tableId $corTables {
    << $myModule.addTable $tableId >>
}

variable sql [<< $db2.printSql 2 >>]

::wtk::log::log Notice "\n$sql"
::wtk::log::log Notice "current namespace = [namespace current]"
::wtk::log::log Notice "info exists [namespace current]::db2 = [info exists [namespace current]::db2]"

}