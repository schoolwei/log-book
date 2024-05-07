class-map type inspect match-all $CMAP
    match access-group $ACL
    exit 

policy-map type inspect $PMAP 
    class type inspect $CMAP
        inspect
        exit 
    exit 

zone-pair security $ZPAIR source $ZONE destination $ZONE
    service-policy type inspect $PMAP
    exit

interface $IFNAME
    zone-member security $ZONE
    exit