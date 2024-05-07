end # goto user exec
clock set $HH:$MM:$SS $DAY $MMM $YYYY
conf t # goto conf t
clock timezone EST -5
clock summer-time EST recurring

# master
ntp authentication-key $KEY_ID md5 $SECRET
ntp authenticate
ntp trusted-key $KEY_ID
ntp master $LEVEL

# peer
ntp authentication-key $KEY_ID md5 $SECRET
ntp authenticate
ntp trusted-key $KEY_ID
ntp server $IP
ntp update-calendar
