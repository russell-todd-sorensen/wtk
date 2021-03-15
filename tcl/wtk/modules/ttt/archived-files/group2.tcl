set base "/web/zmbh/www/tcl-template"

### Add Resources ########
source $base/resource.tcl
# initialize resource list
resource::init
# add matrix command
resource::add command matrix
##########################

set color(C) red
set color(1B) blue
set color(2B) green
set color(3B) yellow
set color(SS) silver
set color(LF) orange
set color(CF) aqua
set color(RF) tan
set color(DH) pink
set color(PH) "#335566"
set color(P)  "#663311"
set color(SP) "#996633"
set color(Mariners) "#336699"
set color(Yankees) "#654321"


set teams [list Mariners Yankees]

set positions [list C 1B 2B 3B SS LF CF RF DH PH P SP]

set Mariners [list {"Dan Wilson" "Ben Davis"} {"John Olerud" "John Mabry"} \
    {"Bret Boone" "Mark McLemore"} {"Jeff Cirillo" "Willie Bloomquist"} \
    {"Carlos Guillen" "Rey Sanchez"} {"Randy Winn" "Chad Meyers"} \
    {"Mike Cameron" "Jamal Strong"} {"Ichiro Suzuki" "Randy Winn"} \
    {"Edgar Martinez" "Luis Ugueto"} {"John Mabry" "Ben Davis"} \
    {"Arthor Rhodes" "Shigetoshi Hasegawa"} {"Jamie Moyer" "Freddy Garcia"}]

set Yankees [list {"Jorge Posada" "John Flaherty"} {"Jason Giambi" "Nick Johnson"} \
    {"Alfonso Soriano" "Enrique Wilson"} {"Robin Ventura" "Todd Zeile"} \
    {"Derek Jeter" "Erick Almonte"} {"Hediki Matsui" "Juan Rivera"} \
    {"Bernie Williams" "Charles Gipson"} {"Raul Mondesi" "Juan Rivera"} \
    {"Jason Giambi" "Ruben Sierra"} {"Ruben Sierra" "Robin Ventura"} \
    {"Mariano Rivera" "Chris Hammond"} {"Roger Clemens" "Andy Pettitte"}]

set i 0
set rows [list]

foreach team_name $teams {

    set j 0
    foreach position $positions {

        set row_${i}(rownum) [expr $i + 1]                      
        set row_${i}(team) $team_name    
        set row_${i}(position) $position
        set row_${i}(player) [lindex [set $team_name] $j 0]

        lappend rows "row_$i"

        incr i

        set row_${i}(rownum) [expr $i + 1]                      
        set row_${i}(team) $team_name
        set row_${i}(position) $position
        set row_${i}(player) [lindex [set $team_name] $j 1]

        lappend rows "row_$i"

        incr i
        incr j
    }
}

source "$base/group2.cmp"

ns_return 200 text/html $string

