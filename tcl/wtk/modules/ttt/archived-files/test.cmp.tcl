if {[resource::exists command set]} {
    resource::eval command set a $a
}

append string {
}
if {[resource::exists command list]} {
    resource::eval command list a b c d $a
}

append string {
ls says }

append string $a

append string {


}