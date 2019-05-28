source /www/tcl/wtk/init.tcl



<< ::wtk::db::Table.method printPlSql {moduleId schemaId {colIndent 1} } {

    variable name
    variable abbrev
    variable primaryKeys
    variable columns
    variable tableConstraints
    variable colCount

    set schema [expr {$schemaId ne "" ? [<< $schemaId.getName >>] : ""}]

    set functionPrefix [expr {$schema ne "" ? "${schema}." : ""}]

    set moduleAbbrev [expr {$moduleId ne "" ? [<< $moduleId.getAbbrev >>] : ""}]

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

    # fix up table name to get to singular case
    switch -glob -- $name {
        "*ies" {
            set tableSingular "[string range $name 0 end-3]y"
        }
        "*s" {
            set tableSingular "[string range $name 0 end-1]"
        }
        default {
            set tableSingular $name
        }
    }
    # function: __create

    set createFunction "CREATE OR REPLACE FUNCTION ${functionPrefix}__create ("

    array unset columnDataArray

    set columnListDataNames {colName colType
        colConstraints colHasDefault
        colDefault colIsPrimaryKey}

    set tmpPrimaryKeys [list]
    set primayKeyType [list]

    foreach column $columns {

        set colName        [<< $column.getName >>]
        set colType        [<< $column.getType >>]
        set colConstraints [<< $column.getConstraints >>]
        set colHasDefault  0
        set colDefault     ""
        set colPos         [<< $column.getPos >>]

        foreach constraint $colConstraints {
            lassign $constraint constType constDef
            if {$constType eq "df"} {
                set colDefault $constDef
                set colHasDefault 1
            }
            if {$constType eq "pk"} {
                if {!$foundPrimaryKeys} {
                    lappend tmpPrimaryKeys $colName
            }
            lappend primaryKeyType $colType
        }
    }

    if {[lsearch -exact $primaryKeys $colName] > -1
        || [lsearch -exact $tmpPrimaryKeys $colName] > -1
    } {
        set colIsPrimaryKey 1
    } else {
        set colIsPrimaryKey 0
    }

    set columnDataArray($colPos) [list $colName $colType\
                      $colConstraints $colHasDefault\
                      $colDefault $colIsPrimaryKey]
    }

    # update primary keys with found pks in table column defs
    if {!$foundPrimaryKeys} {
        if {[llength $tmpPrimaryKeys]} {
            set primaryKeys $tmpPrimaryKeys
        }
    }


    set colPositions [lsort -integer [array keys columnDataArray]]

    set signatureDef [list]

    foreach pos $colPositions {
        lassign $columnDataArray($pos) {*}$colListDataNames

        if {$colIsPrimaryKey} {
            set ioType "in out"
        } else {
            set ioType "in"
        }

        lappend signatureDef " [format %6.6s $ioType] p_$colName $colType\n"
    }

    append createFunction [join $signatureDef ",\n"]

    if {[llength $primaryKeys] > 1} {
        set returns "record"
    } else {
        set returns [lindex $primaryKeyType 0]
    }

    append createFunction "} returns $returns\nlanguage 'plpgsql' as '
DECLARE


BEGIN

"

    append createFunction "END;\n'"

    return $createFunction

} PUBLIC >>
