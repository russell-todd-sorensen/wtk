set directory $dir
set file_list [glob -nocomplain -tails -directory $directory -type f *]
append __string "
"
set dir_list [glob -nocomplain -tails -directory $directory -type d * .*]
append __string "
<h3>Directories:</h3>
"
foreach dirname $dir_list {
append __string "
  <li><a href='"

append __string ${dirname}
append __string "' class='dir'>"
append __string [file tail $dirname]
append __string "</a></li>"
}
append __string "
<h3>Files:</h3>
"
foreach obj $file_list {
set file_extension [file extension $obj]
set file_extension [string trimleft $file_extension "."]
append __string "
  "
switch -glob -- $file_extension {
   *~ - *.o {
      }
   default {
   append __string "
 <li><a href='"

append __string $obj
append __string "' class='"

append __string $file_extension
append __string "'>"
append __string [file tail $obj]
append __string "</a></li>"
   }
}
append __string "
"
}
append __string "
"
