namespace eval ::wtk::http::sha {

    variable external_sha1sum_program /usr/bin/sha1sum
}

proc ::wtk::http::sha::sha1sum { args } {

    variable external_sha1sum_program

    set text [join $args ""]

    set sha1 [lindex [exec echo "$text" | $external_sha1sum_program -] 0]

    return $sha1

}

proc ::wtk::http::sha::generateNewPasswordHash { password } {

    set salt [expr {rand()}]

    set sha1 [sha1sum $salt $password]

    return [list $salt $sha1]
}

proc ::wtk::http::sha::checkPassword { salt password sha1} {

    expr {[sha1sum $salt $password] eq $sha1}
}

