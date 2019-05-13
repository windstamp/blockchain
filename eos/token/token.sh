#!/bin/bash

# Token SYS
cleos push action eosio.token create '[ "eosio", "10000000000.0000 SYS" ]' -p eosio.token@active
cleos push action eosio.token issue '[ "eosio", "1000000000.0000 SYS", "memo" ]' -p eosio@active
cleos push action eosio.token issue '[ "alice", "10000.0000 SYS", "memo" ]' -p eosio@active
cleos push action eosio.token transfer '[ "alice", "bob", "25.0000 SYS", "m" ]' -p alice@active
cleos get currency balance eosio.token eosio SYS
cleos get currency balance eosio.token alice SYS
cleos get currency balance eosio.token bob SYS

# Toekn ATC
cleos push action eosio.token create '[ "eosio", "10000000000.0000 ATC" ]' -p eosio.token@active
cleos push action eosio.token issue '[ "eosio", "1000000000.0000 ATC", "memo" ]' -p eosio@active
cleos push action eosio.token issue '[ "alice", "10000.0000 ATC", "memo" ]' -p eosio@active
cleos push action eosio.token transfer '[ "alice", "bob", "25.0000 ATC", "m" ]' -p alice@active
cleos get currency balance eosio.token eosio ATC
cleos get currency balance eosio.token alice ATC
cleos get currency balance eosio.token bob ATC
