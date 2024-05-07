snmp-server view $VIEW_NAME iso included
snmp-server view $VIEW_NAME system included
snmp-server group $GROUP_NAME v3 priv read $VIEW_NAME access $ACL_NAME
snmp-server user $USERNAME $GROUP_NAME v3 auth sha $SHA_KEY priv aes 128 $AES_KEY

snmp-server community public $RO_NAME
snmp-server community private $RW_NAME

snmp-server engineID local 111100000000000000000000
snmp-server user userone groupone v3 
snmp-server user usertwo grouptwo v3 
snmp-server user userthree groupthree v3 auth md5 user3passwd 
snmp-server user userfour groupfour v3 auth md5 user4passwd priv des56 
  user4priv 
snmp-server group groupone v3 noauth 
snmp-server group grouptwo v3 noauth read myview 
snmp-server group groupthree v3 auth 
snmp-server group groupfour v3 priv 
snmp-server view myview mib-2 included 
snmp-server view myview cisco excluded 
snmp-server community public RO
