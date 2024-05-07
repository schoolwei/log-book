
# enable secret specify algo
enable algorithm-type scrypt secret $SECRET
# or enable secret with default algo
enable secret $SECRET
security passwords min-length $NUMBER

username $USERNAME secret $PASSWORD

aaa new-model
aaa authentication login $NAME local

# use aaa
line vty 0 15
    login authentication $NAME
    transport input ssh

# use local db directly
line console 0
    login local
    exit

# or without local DB
line console 0
    password $PASS
    login
    exec-timeout $MIN $SEC
    logging synchronous

tacacs-server host $IP
tacacs-server key $SECRET
radius-server host $IP
radius-server key $SECRET
aaa authentication login $NAME group radius local
aaa authentication login $NAME group tacacs+ local