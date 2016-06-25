set data-to-encode "\xA4\xCF"
set HA [encoding convertfrom "euc-jp" "${data-to-encode}"]
append __string "

data-to-encode = "

append __string ${data-to-encode}
append __string "

encoded-data (HA) = "

append __string $HA
append __string " ("
append __string [encoding convertfrom euc-jp "${data-to-encode}"]
append __string ")


"
