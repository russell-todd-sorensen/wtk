set template login-2

::wtk::form::getPostedData conn QS FILES

set original_user_name $QS(user_name)

set user_name [::wtk::db::quoteSqlData $original_user_name]

set password $QS(password)

set sql "select *
from
 cordb.cor_identities
where
 ident_login_name = '$user_name'
and
 ident_domain_id = 1000"

::wtk::log::log Debug "login-2.tcl: sql=$sql"

set dbHandle [wtk::pg::getHandle russell]

if {$dbHandle eq ""} {
    return -code error "pg-test.tcl: no database handles available"
}

set rs [pg_exec $dbHandle $sql]
set status [pg::result $rs -status]
set attributes [list]
set rows       [list]

set good 0

switch -exact -- $status {
    "PGRES_TUPLES_OK" {
        set attributes [pg::result $rs -attributes]
        set rows [pg::result $rs -llist]
        set good 1
        if {[llength $rows] == 0} {
            set template login-not-found
            set good 0
        }
        if {[llength $rows] > 1} {
            ::wtk::pg::releaseHandle $dbHandle
            return -code error "Multiple Users with same name? '$rows'"
        }
        set rows [lindex $rows 0]
    }
    "PGRES_FATAL_ERROR" {
        ::wtk::pg::releaseHandle $dbHandle
        return -code error "pg-test.tcl: Postgres Fatal Error"
    }
    default {
        ::wtk::log::log Notice "pg-test.tcl result status is '$status'"
    }
}

# Get rid of results and return handle:
::pg::result $rs -clear
::wtk::pg::releaseHandle $dbHandle

if {$good} {

    lassign $rows {*}$attributes

    ::wtk::log::log Debug "user_name = '$user_name' password = '*******' salt = '$ident_password_salt'"

    set result [::wtk::http::sha::checkPassword $ident_password_salt $password $ident_password_hash]

} else {
    set goodUserName [::wtk::db::checkUserName $user_name]
    set template create-login
}

::t3::respond $connId $template text/html 200