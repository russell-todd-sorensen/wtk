
<< ::wtk::db::Table.method printPlSql { {colIndent 1} } {

    variable name
    variable abbrev
    variable primaryKeys
    variable columns
    variable tableConstraints
    variable colCount
    variable module

    set moduleObject $module
    set schemaObject [<< $moduleObject.getSchema >>]

    # These are used to create object when necessary:
    set nameColumn [list] ;# can be more than one
    set tableSingular [<< [this].getSingular >>]
    set descrColumn ""
    set createObjectPl ""
    set writeVDescr 0

    set indent [string repeat " " $colIndent]

    set schema [expr {$schemaObject ne "" ? [<< $schemaObject.getName >>] : ""}]
    
    set functionPrefix [expr {$schema ne "" ? "${schema}." : ""}]

    set moduleAbbrev [expr {$moduleObject ne "" ? [<< $moduleObject.getAbbrev >>] : ""}]

    if {$moduleAbbrev ne ""} {
	append functionPrefix "${moduleAbbrev}_"
    }

    # Use table constraint as override for primary key def:

    set foundPrimaryKeys 0

    foreach constraint $tableConstraints {
	lassign $constraint tConstType tConstDef 

	if {$tConstType eq "pk"} {
	    set primaryKeys $tConstDef
	    set foundPrimaryKeys 1
	    break
	}
    }


    set createFunction "CREATE OR REPLACE FUNCTION ${functionPrefix}${tableSingular}__create ("
    
    array unset columnDataArray

    set columnListDataNames {colName colType
	colConstraints colHasDefault
	colDefault colIsPrimaryKey colPkRefsObjectId}

    set tmpPrimaryKeys [list]
    set primaryKeyType [list]
    set objectTableRef 0 ;# when a table column references the objects table = 1

    foreach column $columns {

	set colName        [<< $column.getName >>]
	set colType        [<< $column.getType >>]
	set colConstraints [<< $column.getConstraints >>]
	set colHasDefault  0
	set colDefault     ""
	set colPos         [<< $column.getPos >>]
	set colRefsObjectId 0

	foreach constraint $colConstraints {

	    lassign $constraint constType constDef

	    switch -exact -- $constType {
		"df" {

		    set colDefault $constDef
		    set colHasDefault 1
		}
		"pk" {

		    if {!$foundPrimaryKeys} {
			lappend tmpPrimaryKeys $colName
		    }

		    lappend primaryKeyType $colType
		}
		"fk" {

		    lassign $constDef fkTable fkColumn

		    if {[string tolower $fkTable] eq "objects" 
			&& [string tolower $fkColumn] eq "object_id"
		    } {
			set objectTableRef  1
			set colRefsObjectId 1
		    }
		}
		default {
		    # do nothing
		}
	    }
	}
	
	switch -glob -nocase -- $colType {
	    "varchar*" {
		set colType "varchar"
	    }
	    "char*" {
		set colType "char"
	    }
	    "numeric*" {
		set colType "numeric"
	    }  
	}
	
	if {[lsearch -exact $primaryKeys $colName] > -1  
	    || [lsearch -exact $tmpPrimaryKeys $colName] > -1
	} {
	    set colIsPrimaryKey 1
	} else {
	    set colIsPrimaryKey 0
	}

	# finish up the references to object(object_id)
	# If colPkRefsObjectId == 1, a function called with
	# the pk col set to null will generate an object_id,
	# and create a new object ref in the objects table.

	if {$colIsPrimaryKey && $colRefsObjectId} {
	    set colPkRefsObjectId 1
	} else {
	    set colPkRefsObjectId 0
	}
	
	set columnDataArray($colPos) [list $colName $colType\
					  $colConstraints $colHasDefault\
					  $colDefault $colIsPrimaryKey\
					  $colPkRefsObjectId]
    }

    # update primary keys with found pks in table column defs
    if {!$foundPrimaryKeys} {
	if {[llength $tmpPrimaryKeys]} {
	    set primaryKeys $tmpPrimaryKeys
	}
    }


    set colPositions [lsort -integer [array names columnDataArray]]

    set signatureDef [list]
    ::wtk::log::log Warning "current pkTypes = $primaryKeyType"
    set primaryKeyType [list]
    foreach pos $colPositions {
	lassign $columnDataArray($pos) {*}$columnListDataNames

	if {$colIsPrimaryKey} {
	    set ioType "in out"
	    lappend primaryKeyType $colType
	} else {
	    set ioType "in"
	}
	
	lappend signatureDef "\n${indent}[format %-6.6s $ioType] p_$colName $colType"
    }

    append createFunction [join $signatureDef ","]

    if {[llength $primaryKeys] > 1} {
	set returns "record"
    } else {
	set returns [lindex $primaryKeyType 0]
    }

    append createFunction "\n) returns $returns\nlanguage 'plpgsql' as '\nDECLARE\n\n"

    set colTempVars [list]
    set colTestCode ""
    set columnNameList [list]
    set columnVarsList [list]

    foreach pos $colPositions {

	lassign $columnDataArray($pos) {*}$columnListDataNames

	
	if {$colHasDefault} {

	    set quotedDefault [::wtk::db::quoteSingleQuotes $colDefault]

	    lappend colTempVars "${indent}t_$colName $colType := $quotedDefault;"

	    append colTestCode "
${indent}if p_$colName is not null
${indent}${indent}then
${indent}${indent}${indent}t_$colName := p_$colName;
${indent}end if;
"
	} elseif {$colPkRefsObjectId && [llength $primaryKeys] == 1} {
	    set createObjectPl "
${indent}if p_$colName is null
${indent}${indent}then
${indent}${indent}${indent}select ${functionPrefix}object__create(
${indent}${indent}${indent}${indent}null,
${indent}${indent}${indent}${indent}''$tableSingular'',
${indent}${indent}${indent}${indent}v_descr
${indent}${indent}${indent}) into p_$colName;
${indent}end if;
"
	    set writeVDescr 1
	}

	# Setup List for insert SQL:
	lappend columnNameList $colName

	if {$colHasDefault} {
	    lappend columnVarsList "t_$colName"
	} else {
	    lappend columnVarsList "p_$colName"
	}

	if {[string match -nocase "*name" $colName]} {
	    if {$colHasDefault} {
		lappend nameColumn v_$colName
	    } else {
		lappend nameColumn p_$colName
	    }
	}

	if {[string match -nocase "*descr*" $colName]} {
	    if {$colHasDefault} {
		set descrColumn v_$colName
	    } else {
		set descrColumn p_$colName
	    }
	}

    }

    set fullDescriptionTemplate {%s %s: %s} 
    set fullDescriptionColumns  {$nameColumn $tableSingular $descrColumn}

    if {$writeVDescr} {
	append createFunction "${indent}v_descr text; -- for objects\n"
    }

    append createFunction "[join $colTempVars "\n"]\n\nBEGIN\n$colTestCode\n"

    if {$writeVDescr} {
	append createFunction "\n${indent}v_descr := [join $nameColumn " || '', '' || "]\
 || '' is '' || ''[string totitle $tableSingular]'' || '' '' || $descrColumn;\n"
    }

    append createFunction $createObjectPl

    append createFunction "
${indent}insert into ${functionPrefix}$name (
${indent}${indent}[join $columnNameList ",\n${indent}${indent}"]
${indent}) values (
${indent}${indent}[join $columnVarsList ",\n${indent}${indent}"]
${indent});
"
    

    append createFunction "\nEND; -- CREATE OR REPLACE FUNCTION ${functionPrefix}${tableSingular}__create\n';"

    return $createFunction

} PUBLIC >>

