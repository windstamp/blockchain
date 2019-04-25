#!/bin/bash

# Clear node1 & node2
echo "Clear node1 & node2."
rm -rf node1/geth
rm -rf node2/geth
rm -rf node1/eth_output.log
rm -rf node2/eth_output.log
rm -rf bootnode_output.log

# Init node1 & node2
echo "Init node1 & node2."
geth --datadir node1 init genesis.json
geth --datadir node2 init genesis.json

# Startup bootnode
# echo "Startup bootnode."
nohup bootnode -nodekey boot.key -verbosity 9 -addr :30310 2>> bootnode_output.log &
sleep 1s

# Startup node1
echo "Startup node1."
nohup geth --datadir node1/ --syncmode 'full' --port 30311 --rpc --rpcaddr 0.0.0.0 --rpcport 8501 --rpcapi 'personal,db,eth,net,web3,txpool,miner' --rpccorsdomain "*" --ws --wsaddr 0.0.0.0 --wsport 8601 --wsapi 'personal,db,eth,net,web3,txpool,miner' --wsorigins "*" --bootnodes 'enode://bde0739c7d9f213054575574d6e8e1df21147066a666bc939f29634dac947ad5c715a990d878264fe91a83c9fa0495911c824fe43329570c8d0510c8fa3243f2@127.0.0.1:30310' --networkid 15151 --gasprice '1' -unlock '066b5f0e04a5f7f80c546968c71ec5306539b5c0' --password node1/password.txt --mine 2>>node1/eth_output.log &
sleep 1s

# Startup node2
echo "Startup node2."
nohup geth --datadir node2/ --syncmode 'full' --port 30312 --rpc --rpcaddr 'localhost' --rpcport 8502 --rpcapi 'personal,db,eth,net,web3,txpool,miner' --ws --wsaddr 0.0.0.0 --wsport 8602 --wsapi 'personal,db,eth,net,web3,txpool,miner' --wsorigins "*" --bootnodes 'enode://bde0739c7d9f213054575574d6e8e1df21147066a666bc939f29634dac947ad5c715a990d878264fe91a83c9fa0495911c824fe43329570c8d0510c8fa3243f2@127.0.0.1:30310' --networkid 15151 --gasprice '1' -unlock '904c86728fc92d78147b1c4b97b07006e62c937c' --password node2/password.txt --mine 2>>node2/eth_output.log &

# Jobs command
# jobs
# kill %1 for bootnode
# kill %2 for geth of node1
# kill %3 for geth of node2

## Reference
# http://www.cnblogs.com/xd502djj/p/3612131.html
# https://blog.csdn.net/fengyifei11228/article/details/5737371
# http://www.cnblogs.com/mfryf/archive/2012/05/09/2491322.html
