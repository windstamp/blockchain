#!/bin/bash

# 本脚本需要先启动对应的 nodeos 节点，并且默认在端口 8888 提供服务。
# 这是因为账号的数据是存在于区块链上的，因此需要先启动一个区块链节点来生成区块链。

PUBLIC_KEY=EOS6hMjoWRF2L8x9YpeqtUEcsDKAyxSuM1APicxgRU1E3oyV5sDEg
SYSTEM_ACCOUNT_PUBLIC_KEY=EOS6hMjoWRF2L8x9YpeqtUEcsDKAyxSuM1APicxgRU1E3oyV5sDEg

cleos create account eosio eosio.bpay $SYSTEM_ACCOUNT_PUBLIC_KEY
cleos create account eosio eosio.msig $SYSTEM_ACCOUNT_PUBLIC_KEY
cleos create account eosio eosio.names $SYSTEM_ACCOUNT_PUBLIC_KEY
cleos create account eosio eosio.ram $SYSTEM_ACCOUNT_PUBLIC_KEY
cleos create account eosio eosio.ramfee $SYSTEM_ACCOUNT_PUBLIC_KEY
cleos create account eosio eosio.saving $SYSTEM_ACCOUNT_PUBLIC_KEY
cleos create account eosio eosio.stake $SYSTEM_ACCOUNT_PUBLIC_KEY
cleos create account eosio eosio.token $SYSTEM_ACCOUNT_PUBLIC_KEY
cleos create account eosio eosio.vpay $SYSTEM_ACCOUNT_PUBLIC_KEY
cleos create account eosio eosio.rex $SYSTEM_ACCOUNT_PUBLIC_KEY

# cleos create account eosio eosio.system $SYSTEM_ACCOUNT_PUBLIC_KEY
# cleos create account eosio eosio.bios $SYSTEM_ACCOUNT_PUBLIC_KEY

cleos create account eosio inita $SYSTEM_ACCOUNT_PUBLIC_KEY

cleos create account eosio node1 $SYSTEM_ACCOUNT_PUBLIC_KEY
cleos create account eosio node2 $SYSTEM_ACCOUNT_PUBLIC_KEY
cleos create account eosio node3 $SYSTEM_ACCOUNT_PUBLIC_KEY

cleos create account eosio alice $SYSTEM_ACCOUNT_PUBLIC_KEY
cleos create account eosio bob $SYSTEM_ACCOUNT_PUBLIC_KEY
