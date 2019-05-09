#!/bin/bash

CONTRACT_DIR=~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts

# eosio.token
# cleos set contract eosio.token ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.token/
cleos set contract eosio.token ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.token --abi eosio.token.abi -p eosio.token@active

# eosio.bios
# cleos set contract eosio.bios ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.bios/
cleos set contract eosio ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.bios/ --abi eosio.bios.abi -p eosio@active

# eosio.msig
# cleos set contract eosio.msig ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.msig/
cleos set contract eosio.msig ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.msig/ --abi eosio.msig.abi -p eosio.msig@active

# eosio.system
# cleos set contract eosio.system ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.system/
# cleos set contract eosio ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.system/ --abi eosio.system.abi -p eosio@active
