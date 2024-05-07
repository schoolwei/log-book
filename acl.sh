ip access-list standard $ACL
    permit $SOURCE $WILDCARD
    deny $SOURCE $WILDCARD
    $ACE...
    exit

access-list 1 $ACE
access-list 99 $ACE

ip access-list extended $XACL
    permit ip $SOURCE $WILDCARD $DEST $WILDCARD
    deny ip $DITTO
    permit tcp host $IP host $IP eq $PROTO
    permit icmp host $IP host $IP
    $XACE...
    exit

access-list 100 $XACE

interface $IFNAME
    access-group $XACL
    exit