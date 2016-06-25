# Configure pgtcl connection to postgres databases

namespace eval ::wtk::pg {

    variable localDatabase 
    variable remoteDatabase
    variable dbHandles
}

::wtk::pg::addDatabase russell -handles 2 -minHandles 2
#::wtk::pg::addDatabase template1 -handles 2 -minHandles 2
::wtk::pg::addDatabase postgres -handles 2 -minHandles 2


