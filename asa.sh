# Image Software Management  
copy tftp flash  
config t
boot system flash:/asa911-k8.bin  

int vlan $VLAN
    nameif $NAME
    security-level $LEVEL
    exit

int $IFNAME
    switchport access vlan 1
    exit

crypto key generate rsa modulus $MOD
username $USER password $PASS priv $PRIV
aaa authentication ssh console LOCAL 

ssh $ALLOWED_IP $NETWORK $WHICH_SIDE
ssh timeout $MINUTE

class-map $CLASS_NAME
    match default-inspection-traffic
exit

policy-map $POLICY_NAME
    class $CLASS_NAME
        inspect $PROTO
    exit

service-policy $POLICY_NAME global

# Port NAT dynamic for subnet

object network $NAME
    subnet $FROM_IP $SUBNET_MASK
    nat ( $FROM, $TO) dynamic interface



# Static IP NAT

object network $OBJECT_NAME
    host $FROM_IP
    nat ( $FROM, $TO ) static $TO_IP # or
    nat ( $FROM, $TO ) static $TO_IP service $PROTO3 $FROM_PORT $TO_PORT

object-group network $GROUP_NAME
    network-object host $IP
    network-object $NETWORK $SUBNET_MASK

object-group service $GROUP_NAME
    port-object eq $PROTO_NAME
    port-object range $START $END


# acl and apply
access-list OUTSIDE-DMZ permit tcp any host $IP eq $PORT
access-group OUTSIDE-DMZ in interface $NAME

# Routing

route $VIA_IFNAME $NETWORK $SUBNET $TARGET_IP

# Clock

clock set $HH:$MM:$SS $MMM $DD $YYYY
clock timezone EST -5
clock summer-time EST recurring

# Logging

logging enable  
logging timestamp
logging buffer-size 64000
logging buffered warnings
logging asdm errors
logging host inside $SYSLOG_SERVER_IP
logging trap errors

# Enable HTTP ASDM
http server enable 
http $ALLOWED_NET $SUBNET $WHICH_SIDE
username $USER password $PASS

# DHCPD

dhcpd address $FROM_IP - $TO_IP $IFNAME
dhcpd dns $DNS_IP interface $IFNAME
dhcpd enable $IFNAME

# Permit Traffic Between Same Security Levels

same-security-traffic permit inter-interface
same-security-traffic permit intra-interface

# Useful Verification and Troubleshooting Commands

show access-list $IFNAME
show clock
show crypto ipsec sa
show crypto isakmp sa
show disk
show interface
show local-host
show memory
show route
show version
show xlate
