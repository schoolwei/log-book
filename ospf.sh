router ospf $PID
    area 0 authentication message-digest
    network $IP $WILDCARD area $AREA
    passive-interface $IFNAME
    exit

int $IFNAME
    ip ospf authentication message-digest
    ip ospf message-digest-key $PID md5 $SECRET_KEY
    exit

