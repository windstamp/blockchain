#!/bin/bash

# 启动第 1 个节点，并且设置为生产者
	nohup nodeos --enable-stale-production --producer-name eosio --config-dir node1/config --data-dir node1/data --plugin eosio::chain_api_plugin --plugin eosio::net_api_plugin >> node1/nodeos.log 2>&1 &

# 启动第 2 个节点，并且设置为生产者
nohup nodeos --producer-name inita --plugin eosio::chain_api_plugin --plugin eosio::net_api_plugin --http-server-address 127.0.0.1:8889 --p2p-listen-endpoint 127.0.0.1:9877 --p2p-peer-address 127.0.0.1:9876 --config-dir node2/config --data-dir node2/data --private-key [\"EOS6hMjoWRF2L8x9YpeqtUEcsDKAyxSuM1APicxgRU1E3oyV5sDEg\",\"5JgbL2ZnoEAhTudReWH1RnMuQS6DBeLZt4ucV6t8aymVEuYg7sr\"] >> node2/nodeos.log 2>&1 &

