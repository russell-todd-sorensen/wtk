
# create db schema

<< Class ::wtk::db::SQLComponent \
    -ObjNameFormat DB_SQLCMP%03i \
    -ObjCounter 0 \
    -VARIABLES {
	{name {{}} - {::wtk::db::checkStringLength name 64 1}}
	{singular {{}} - {::wtk::db::checkStringLength singular 64 0}}
	{abbrev {{}} - {::wtk::db::checkStringLength abbrev 8 1}}
	{comments {{}} + {} }
    }\
    +METHODS getName\
    +METHODS getSingular\
    +METHODS getAbbrev\
    +METHODS getComments\
    +METHODS printSql\
>>

<< ::wtk::db::SQLComponent.method getName {} {
    variable name
    set name
} PUBLIC >>

<< ::wtk::db::SQLComponent.method getSingular {} {
    variable singular
    variable name
    expr {$singular ne "" ? $singular : $name}
} PUBLIC >>

<< ::wtk::db::SQLComponent.method getAbbrev {} {
    variable abbrev
    set abbrev
} PUBLIC >>

<< ::wtk::db::SQLComponent.method getComments {} {
    variable comments
    set comments
} PUBLIC >>

############ DATABASE CLASS ###########
# Each database contains one or more schemas


<< Class ::wtk::db::Database +Public ::wtk::db::SQLComponent \
    -ObjNameFormat DB_DB%03i \
    -ObjCounter 0 \
    -VARIABLES {
	{owner {russell} - {}}
	{template {template1} - {}}
	{encoding {UTF-8} {}}
	{schemas {{}} + {}}
    }\
    +METHODS addSchema\
    +METHODS getSchemas\
>>

<< ::wtk::db::Database.method addSchema {schemaObject} {
    variable schemas
    lappend schemas $schemaObject
} PUBLIC >>

<< ::wtk::db::Database.method getSchemas {} {
    variable schemas
    set schemas
} PUBLIC >>

<< ::wtk::db::Database.method printSql { {colIndent 4} } {

    variable name
    variable owner
    variable template
    variable encoding
    variable schemas

    set sql "
CREATE DATABASE $name
  WITH OWNER = $owner
       TEMPLATE = $template
       ENCODING = '[::wtk::db::quoteSingleQuotes $encoding]';

-- connect to $name

\\c $name
"

    foreach schema $schemas {
	append sql [<< $schema.printSql $colIndent >>]
    }

    return $sql

} >>

########## SCHEMA CLASS ##############
# Each schema contains one or more modules


<< Class ::wtk::db::Schema +Public ::wtk::db::SQLComponent \
    -ObjNameFormat DB_SCHEMA%03i \
    -ObjCounter 0 \
    -VARIABLES {
	{database {{}} - {}}
	{modules {{}} + {}}
    }\
    +METHODS addModule\
    +METHODS getModules\
    +METHODS getDatabase\
>>

<< ::wtk::db::Schema.method addModule {moduleObject} {
    variable modules
    lappend modules $moduleObject
} PUBLIC >>

<< ::wtk::db::Schema.method getModules {} {
    variable modules
    set modules
} PUBLIC >>

<< ::wtk::db::Schema.method getDatabase {} {
    variable database
    set database
} PUBLIC >>

<< ::wtk::db::Schema.method printSql { {colIndent 4} } {

    variable name
    variable modules
    set sql "\ncreate schema $name;\n"

    foreach module $modules {
	append sql [<< $module.printSql $colIndent >>]
    }

    return $sql
} >>


########## MODULES CLASS ############
# Each module contains one or more tables


<< Class ::wtk::db::Module +Public ::wtk::db::SQLComponent \
    -ObjNameFormat DB_MODULE%03i \
    -ObjCounter 0 \
    -VARIABLES {
	{schema {{}} - {}}
	{tables {{}} + {}}
    }\
    +METHODS addTable\
    +METHODS getTables\
    +METHODS getSchema\
>>

<< ::wtk::db::Module.method addTable {tableObject} {
    variable tables
    lappend tables $tableObject
} PUBLIC >>

<< ::wtk::db::Module.method getTables {} {
    variable tables
    set tables
} PUBLIC >>

<< ::wtk::db::Module.method getSchema {} {
    variable schema
    set schema
} PUBLIC >>

<< ::wtk::db::Module.method printSql { {colIndent 4} } {

    variable name
    variable tables
    variable schema
    set sql "\n"

    foreach table $tables {
	append sql [<< $table.printSql $colIndent >>]
    }

    return $sql
} >>

set db1     [<< ::wtk::db::Database -name testdb -abbrev tdb -owner russell >>]
set schema1 [<< ::wtk::db::Schema -name mySchema -abbrev mys-database $db1
		+comments "This is my first schema" >>]
set module1 [<< ::wtk::db::Module -name testmodule -abbrev tmo -module $module1  >>]

::wtk::log::log Notice "Schema name is '[<< $schema1.getName >>]'"
::wtk::log::log Notice "Module1 name = '[<< $module1.getName >>]' schema = '[<< $module1.getSchema >>]'"




