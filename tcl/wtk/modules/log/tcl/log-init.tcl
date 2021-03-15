
namespace eval ::wtk::log {

    variable method [expr {[llength [info commands ns_log]] > 0 ? "ns_log" : "stderr"}]
    variable logChannel stderr
    variable debug 1
}
