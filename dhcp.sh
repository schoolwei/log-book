# server router

ip dhcp excluded-address $START $END
ip dhcp excluded-address $IP

ip dhcp pool $NAME
    network $NETWORK $SUBNET
    default-router $IP
    dns-server $IP
    domain-name $DOMAIN
    lease infinite
    exit

service dhcp

# switches

ip dhcp snooping
ip dhcp snooping vlan $VLAN
ip dhcp snooping information option allow-untrusted
 
int $IFNAME
    ip dhcp snooping trust

# intermediary routers

ip dhcp relay information trust-all

int $IFNAME # client facing
    ip helper-address $DHCP_SERVER_IP