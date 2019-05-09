#!/bin/bash

CONTRACT_DIR=~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts

# 当前目录
#workdir=$(cd $(dirname $0); pwd)
workdir=`pwd`
echo $workdir

# eosio.bios
echo "Compile eosio.bios"
cd $CONTRACT_DIR/eosio.bios
eosio-cpp -I include -I ../eosio.token/include -o eosio.bios.wasm src/eosio.bios.cpp --abigen

# eosio.token
echo "Compile eosio.token"
cd $CONTRACT_DIR/eosio.token
eosio-cpp -I include -o eosio.token.wasm src/eosio.token.cpp --abigen

# eosio.msig
echo "Compile eosio.msig"
cd $CONTRACT_DIR/eosio.msig
eosio-cpp -I include -o eosio.msig.wasm src/eosio.msig.cpp --abigen

# eosio.system
echo "Compile eosio.system"
cd $CONTRACT_DIR/eosio.system
eosio-cpp -I include -I ../eosio.token/include -o eosio.system.wasm src/eosio.system.cpp --abigen

# 返回当前目录
echo "Back to $workdir"
cd $workdir

