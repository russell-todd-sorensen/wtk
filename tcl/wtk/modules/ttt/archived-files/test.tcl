source /web/zmbh/vhost/budigan/resource.tcl

set a {[puts stdout "this is a test"]}

source /web/zmbh/vhost/budigan/www/photos/test.cmp

ns_return 200 text/plain $string
