! # SETUP THE VPN, PHASE 1

crypto isakmp policy $POLICY
    hash sha
    encryption aes
    authentication pre-share
    group $KEY_SIZE # 5
    exit

crypto isakmp key $SECRET address $PEER_IP

! # IKE PHASE 2

crypto ipsec transform-set $TSET esp-aes esp-sha-hmac

crypto map $MAP 10 ipsec-isakmp
    set peer $PEER_IP
    set transform-set $TSET
    match address $ACL
    exit

int $IFNAME
    crypto map $MAP
    exit