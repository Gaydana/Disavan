#!/usr/bin/expect -f
set timeout -1
spawn windscribe login
expect "Username: "
send -- "mwermuth3\n"
expect "Password: "
send -- "shell8812\n"
expect eof
