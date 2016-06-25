
::wtk::nv::create myNameValueList {
    {a this is a}
    {b this is b}
    {c this is c}
    {cc this is cc}
    {ccc this is ccc}
    {c this is another c}


::wtk::log::log Debug "namespace = [namespace current]"
::wtk::log::log Debug "nvGet myNameValueList a = '[::wtk::nv::nvGet myNameValueList a]'"
::wtk::log::log Debug "nvGet myNameValueList b = '[::wtk::nv::nvGet myNameValueList b]'"
::wtk::log::log Debug "nvGet myNameValueList c = '[::wtk::nv::nvGet myNameValueList c]'"
::wtk::log::log Debug "nvGetAll myNameValueList c = '[::wtk::nv::nvGetAll myNameValueList c]'"
::wtk::log::log Debug "nvGet myNameValueList d = '[::wtk::nv::nvGet myNameValueList d]'"
::wtk::log::log Debug "nvGet myNameValueList cc = '[::wtk::nv::nvGet myNameValueList cc]'"
::wtk::log::log Debug "nvGetAll myNameValueList c* = '[::wtk::nv::nvGetAll myNameValueList c*]'"

for {set i 0} {$i < [llength $myNameValueList]} {incr i} {

    ::wtk::log::log Debug "$i key = [::wtk::nv::nvKey myNameValueList $i] value = '[::wtk::nv::nvValue myNameValueList $i]'"
}


::wtk::log::log Debug "nvSearch myNameValueList  C* -all 0 -nocase 1 -start 4 = [::wtk::nv::nvSearch myNameValueList  C* -all 0 -nocase 1 -start 4]"

unset myNameValueList

}

::wtk::log::log Notice "Loading namespace is '[namespace current]'"
::wtk::nv::nvEnumeration Directions Back -1 Exit Forward
::wtk::nv::nvEnumeration Directions2 {Back -1 Exit Forward}
::wtk::nv::nvEnumeration Codes {OK ERROR BREAK CONTINUE}

::wtk::nv::nvBitMap LogLevels {Notice Warning Debug Error Special}