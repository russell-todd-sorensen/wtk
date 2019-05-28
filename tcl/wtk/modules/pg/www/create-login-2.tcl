set template login-2

::wtk::form::getPostedData conn QS FILES

set original_user_name $QS(user_name)

set user_name [::wtk::db::quoteSqlData $original_user_name]

set original_password $QS(password)
set original_password2 $QS(password2)

set good 1
set messages [list]

if {$original_password ne $original_password2} {
    set template create-login
    lappend messages "Passwords don't match."
    set good 0
}

if {![::wtk::db::checkUserName $user_name]} {
    set template create-login
    lappend messages "Username is invalid."
    set good 0
}

if {$good} {


    set sql "select *
from
 cordb.cor_identities
where
 ident_login_name = '$user_name'
and
 ident_domain_id = 1000"

    ::wtk::log::log Debug "create-login-2.tcl: sql=$sql"

    set dbHandle [wtk::pg::getHandle russell]

    if {$dbHandle eq ""} {
        return -code error "create-login-2.tcl: no database handles available"
    }

    set rs [pg_exec $dbHandle $sql]
    set status [pg::result $rs -status]
    set attributes [list]
    set rows       [list]


    switch -exact -- $status {
        "PGRES_TUPLES_OK" {
            set attributes [pg::result $rs -attributes]
            set rows [pg::result $rs -llist]
            set good 1
            if {[llength $rows] == 0} {
                set good 1
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
            set good 0
        }
    }
}

# Get rid of results and return handle:
::pg::result $rs -clear
::wtk::pg::releaseHandle $dbHandle

if {$good} {

    set hashSaltList [::wtk::http::sha::generateNewPasswordHash $original_password]
    set salt [lindex $hashSaltList 0]
    set hash [lindex $hashSaltList 1]

    set object_sql "insert into
cordb.cor_objects (
 object_id,
 class_id,
 obj_owner,
 create_date,
 change_date,
 object_descr
) values (
 object_id,
 class_id,
 obj_owner,
 create_date,
 change_date,
 object_descr
)
"

    set ident_sql "insert into
 cordb.cor_identities
(
 identity_id,
 ident_type_id,
 ident_domain_id,
 ident_name,
 ident_login_name,
 ident_password_hash,
 ident_password_salt,
 encryption_method,
 ident_descr
) values
(
 $identity_id,
 $ident_type_id,
 $ident_domain_id,
 $ident_name,
 $ident_login_name,
 $ident_password_hash,
 $ident_password_salt,
 $encryption_method,
 $ident_descr
)"

    set result [::wtk::http::sha::checkPassword $ident_password_salt $password $ident_password_hash]

} else {
    set goodUserName [::wtk::db::checkUserName $user_name]
    set template create-login
}

::t3::respond $connId $template text/html 200