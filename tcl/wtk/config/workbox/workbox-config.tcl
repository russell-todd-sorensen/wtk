
namespace eval ::wtk::workbox {
    variable version 0.1
    variable initialized false
    variable interval 60000;# seconds
    variable binary "workbox"
    variable server [ns_info server]
    variable serverRoot [ns_server -server $server serverdir]
    variable pageroot [ns_server -server $server pagedir]
    variable swDirectory "$serverRoot/workbox-clock"
    variable config "$swDirectory/workbox-config.js"
    variable swFile "$pageroot/clock-app/sw.js"

}

::wtk::log::log Notice "wtk::workbox config..."