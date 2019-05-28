
<< Class ::wtk::db::Table +Public ::wtk::db::SQLComponent\
    -ObjNameFormat DB_TABLE%03i \
    -ObjCounter 0 \
    -VARIABLES {
        {primaryKeys {{}} - {}}
        {tableConstraints {{}} + {}}
        {columns {{}} + {}}
        {colCount 0 - {string is integer -strict $colCount}}
        {module {{}} - {}}
    } \
    +METHODS getPrimaryKeys\
    +METHODS getTableConstraints\
    +METHODS addTableConstraint\
    +METHODS addTableConstraints\
    +METHODS getColumns\
    +METHODS incrColCount\
    +METHODS addColumns\
    +METHODS getModule\
    +METHODS printSql\
    +METHODS printPlSql\
>>

<< ::wtk::db::Table.method getPrimaryKeys {} {
    variable primaryKeys
    return $primaryKeys
} PUBLIC >>

<< ::wtk::db::Table.method getTableConstraints {} {
    variable tableConstraints
    return $tableConstraints
} PUBLIC >>

<< ::wtk::db::Table.method addTableConstraint {constraint} {
    variable tableConstraints
    lappend constraints $constraint
} PUBLIC >>

<< ::wtk::db::Table.method addTableConstraints {constraints} {
    variable tableConstraints
    foreach constraint $constraints {
        lappend constraints $constraint
    }
} PUBLIC >>

<< ::wtk::db::Table.method colCount {} {
    variable colCount
    return $colCount
} PUBLIC >>

<< ::wtk::db::Table.method incrColCount {} {
    variable colCount
    return [incr colCount]
} PUBLIC >>


<< ::wtk::db::Table.method addColumns { columnList } {

    variable columnCount
    variable name
    variable primaryKeys
    variable columns

    foreach col $columnList {

        lassign $col colName colType colConstraints colComments
        set constraintList [list]
        set commentList   [list]

        foreach constraint $colConstraints {
            lappend constraintList +constraints $constraint
        }

        foreach comment $colComments {
            lappend commentList +comments $comment
        }
        lappend columns\
            [<< ::wtk::db::Column \
            -name $colName\
            -table $name\
            -type $colType\
            {*}$constraintList\
            {*}$commentList\
            -pos [incr columnCount] >>]
    }

} PUBLIC >>

<< ::wtk::db::Table.method getModule {} {
    variable module
    set module
} PUBLIC >>

<< ::wtk::db::Table.method printSql { {colIndent 1} } {

    variable name
    variable abbrev
    variable primaryKeys
    variable columns
    variable tableConstraints
    variable module


    set moduleObject $module
    set schemaObject [<< $moduleObject.getSchema >>]
    set tableSql ""
    set indent [string repeat " " $colIndent]

    foreach comment [<< [this].getComments >>] {
        append tableSql "-- [::wtk::db::quoteTableComments $comment]\n"
    }

    set schema [expr {$schemaObject ne "" ? [<< $schemaObject.getName >>] : ""}]
    set tableName [expr {$schema ne "" ? "${schema}." : ""}]

    set moduleAbbrev [expr {$moduleObject ne "" ? [<< $moduleObject.getAbbrev >>] : ""}]

    if {$moduleAbbrev ne ""} {
        append tableName "${moduleAbbrev}_"
    }

    append tableName $name

    append tableSql "\nCREATE TABLE $tableName (\n"

    set tableCols [list]

    foreach col $columns {
        set colName [<< $col.getName >>]
        set tableCol ""
        foreach comment [<< $col.getComments >>] {
            append tableCol "$indent-- [::wtk::db::quoteColumnComments $comment $colIndent]\n"
        }
        append tableCol "$indent$colName [<< $col.getType >>]"
        append tableCol [::wtk::db::formatConstraints [<< $col.getConstraints >>] $abbrev $colIndent $moduleObject $schemaObject $colName]
        lappend tableCols $tableCol
    }


    foreach constraint $tableConstraints {
        lappend tableCols [::wtk::db::formatConstraints [list $constraint] $abbrev $colIndent $moduleObject $schemaObject {}]
    }

    append tableSql "[join $tableCols ",\n"]\n);\n"

    append tableSql "\n--plpgsql \n[<< [this].printPlSql $colIndent >>]\n"
} PUBLIC >>



# constraint is [list constraint_type definition]

<< Class ::wtk::db::Column +Public ::wtk::db::SQLComponent\
    -ObjNameFormat DB_COLUMN%03i\
    -ObjCounter 0\
    -VARIABLES {
        {table       {{}} - {::wtk::db::checkStringLength table 64 1} }
        {type        {{}} - {} }
        {constraints {{}} + {::wtk::db::checkListLength constraints 2 2} }
        {pos           0  - {string is integer -strict $pos} }
    } \
    +METHODS getTable\
    +METHODS getType\
    +METHODS getConstraints\
    +METHODS getPos\
>>

<< ::wtk::db::Column.method getTable {} {
    variable table
    return $table
} PUBLIC >>

<< ::wtk::db::Column.method getType {} {
    variable type
    return $type
} PUBLIC >>

<< ::wtk::db::Column.method getConstraints {} {
    variable constraints
    return $constraints
} PUBLIC >>

<< ::wtk::db::Column.method addConstraint {constraint} {
    variable constraints
    lappend constraints $constraint
} PUBLIC >>

<< ::wtk::db::Column.method addConstraints {constraints} {
    variable constraints
    foreach constraint $constraints {
        lappend constraints $constraint
    }
} PUBLIC >>

<< ::wtk::db::Column.method getPos {} {
    variable pos
    return $pos
} PUBLIC >>
