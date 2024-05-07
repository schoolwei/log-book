ip domain-name $DOMAIN

crypto key zeroize rsa
crypto key generate rsa general-keys modulus $MOD

ip ssh version 2
ip ssh time-out $SECONDS  
ip ssh authentication-retries $NUMBER

! # $PRIV = 0-15 ASC
username $USERNAME privilege $PRIV secret $PASS

line vty 0 4
    privilege level $PRIV
    login local
    transport input ssh
    exit
