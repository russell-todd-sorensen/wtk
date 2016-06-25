
# Base database related procs
namespace eval ::wtk::db {

    variable version 1.0

    variable userNameRegexp {\A[a-zA-Z][a-zA-Z0-9_\.@\:-]+\Z}
    namespace import -force ::wtk::nv::*
    namespace import -force ::wtk::log::log
}

proc ::wtk::db::quoteSqlData { data } {

    string map {' ''} $data
}

proc ::wtk::db::quoteSingleQuotes { string } {
    string map {' ''} $string
}

proc ::wtk::db::checkUserName { userName } {

    variable userNameRegexp

    regexp  $userNameRegexp $userName
}

proc ::wtk::db::quoteTableComments { string {indents 0} } {
    
    set indents 0
    quoteColumnComments $string $indents
}

# Note extra space indentation in column comments
proc ::wtk::db::quoteColumnComments { string {indents 1} } {
    
    set indent [string repeat " " $indents]
    log Notice "quoteColumnComments  indents=$indents in='$string'"
    string map [list "\n--" "\n$indent--"\
		     "\n --" "\n$indent--"\
		     "\n  --" "\n$indent--"\
		     "\n$indent--" "\n$indent--"\
		     "\n" "\n$indent--"\
		     "''" "''"\
		     "'" "''"] $string

}

proc ::wtk::db::checkStringLength { stringVar max {min 0} } {

    upvar $stringVar VAR
    log Notice "^^^^^^checkStringLength stringVar = $stringVar max = $max min = $min"
    return [string length $VAR] >= $min && [string length $VAR] <= $max

}

proc ::wtk::db::checkStringRegexp { stringVar regexp } {

    upvar $stringVar VAR
    regexp $regexp $VAR

}

proc ::wtk::db::checkStringGlob { stringVar glob } {

    upvar $stringVar VAR
    string match $glob $VAR
}

proc ::wtk::db::checkListLength { listVar max {min 0} } {

    upvar $listVar VAR
    set length [llength $VAR]
    return $length >= $min && $length <= $min
}

proc ::wtk::db::formatConstraints { constraints tableAbbrev colIndent moduleId schemaId {columnName {}} } {

    if {$columnName eq "" } {
	set colName ""
	
    } else {
	set colName ${columnName}_
	# this implies a column constraint, not a table constraint!
	set colIndent [expr {2*$colIndent}]
    }

    set schemaAbbrev [expr {$schemaId ne "" ? [<< $schemaId.getAbbrev >>] : ""}]
    set schema [expr {$schemaAbbrev ne "" ? "${schemaAbbrev}_" : ""}]

    set moduleAbbrev [expr {$moduleId ne "" ? [<< $moduleId.getAbbrev >>] : "" }]
    set module [expr {$moduleAbbrev ne "" ? "${moduleAbbrev}_" : ""}]

    set abbrev $tableAbbrev

    set constSql ""

    set indent [string repeat " " $colIndent]
 
    foreach constraint $constraints {

	lassign $constraint constType constDef
	
	switch -exact -- $constType {
	    "nn" { # no constDef
		append constSql "
${indent}CONSTRAINT ${schema}${module}${abbrev}_${colName}nn NOT NULL"
		continue
	    }
	    "fk" { # special constDef
		set constDef [formatForeignKeyConstraint $moduleId $schemaId $constDef]
		# references is complicated, constDef is a list:
		# [list fTableName fColNameList {fSchemaId ""} {fModuleId ""}]
		append constSql "
${indent}CONSTRAINT ${schema}${module}${abbrev}_${colName}fk REFERENCES $constDef"
		continue
	    }
	    "pk" {
		set colAbbrev [expr {$colName eq "" ? "[join $constDef _]_" : $colName}]
		set constDef [formatColumnList $colName $constDef]
		
		append constSql "
${indent}CONSTRAINT ${schema}${module}${abbrev}_${colAbbrev}pk PRIMARY KEY$constDef"
		continue
	    }
	    "un" {
		set colAbbrev [expr {$colName eq "" ? "[join $constDef _]_" : $colName}]
		set constDef [formatColumnList $colName $constDef]
		append constSql "
${indent}CONSTRAINT ${schema}${module}${abbrev}_${colAbbrev}un UNIQUE$constDef"
		continue
	    }
	}

	set constDef [expr {$constDef ne "" ? " $constDef" : ""}]
	
	switch -exact -- $constType {
	    "df" {
		set constDef [string trim $constDef]
		log Debug "formatConsraints: constDef = >$constDef<"
		append constSql "
${indent}CONSTRAINT ${schema}${module}${abbrev}_${colName}df DEFAULT $constDef"
	    }
	    "ck" {
		append constSql "
${indent}CONSTRAINT ${module}${abbrev}_${colName}ck CHECK$constDef"
	    }
	    default {
		append constSql "
${indent}CONSTRAINT ${schema}${module}${abbrev}_${colName}${constType}$constDef"
	    }
	}
    }

    return $constSql
}

proc ::wtk::db::formatColumnList { colName keyColList } {

    if {$colName ne ""} { 
	# not a table constraint
	# keyColList should be empty
	return ""
    }

    return " ([join $keyColList ", "])"
}

proc ::wtk::db::formatForeignKeyConstraint { moduleId schemaId argList } {

    set extra [lassign $argList fTableName fColNameList fModuleId fSchemaId]
    
    if {$extra ne ""} {
	return -code error "formatForeignKeyConstraint: extra args provided! '$extra'"
    }

    set moduleId [expr {$fModuleId ne "" ? $fModuleId : $moduleId}]
    set moduleAbbrev [expr {$moduleId ne "" ? [<< $moduleId.getAbbrev >>] : ""}]
    set moduleAbbrev [expr {$moduleAbbrev ne "" ? "${moduleAbbrev}_" : ""}]

    set schemaId [expr {$fSchemaId ne "" ? $fSchemaId : $schemaId}]
    set schemaName [expr {$schemaId ne "" ? [<< $schemaId.getName >>] : ""}]
    set schemaName [expr {$schemaName ne "" ? "${schemaName}." : ""}]
 
    if {[llength $fColNameList] > 0} {
	set fColNameList "([join $fColNameList ", "])"
    }

    return "${schemaName}${moduleAbbrev}${fTableName}$fColNameList"
}














