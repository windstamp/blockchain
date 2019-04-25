#!/bin/bash

# Clear node1 & node2 & node3
echo "Clear node1 & node2 & node3."
rm -rf ~/.ethash
rm -rf node1/geth
rm -rf node2/geth
rm -rf node3/geth
rm -rf node1/eth_output.log
rm -rf node2/eth_output.log
rm -rf node3/eth_output.log
rm -rf bootnode_output.log

# Init node1 & node2 & node3
echo "Init node1 & node2 & node3."
geth --datadir node1 init genesis.json
geth --datadir node2 init genesis.json
geth --datadir node3 init genesis.json

# Startup bootnode
# echo "Startup bootnode."
nohup bootnode -nodekey boot.key -verbosity 9 -addr :30301 2>> bootnode_output.log &
sleep 1s

# Startup node1
echo "Startup node1."
nohup geth --datadir=node1 --bootnodes=enode://2cb6fe8f4a73fdc962bae49cfcc131e642a9f3b9d6cff1384d5e14ad7d25ebf715286e812b3ce70a5c9c6797d71cdbd1432e2ac1a0f6cb06cab3e9e7dd33aea4@127.0.0.1:30301 --networkid 25252 --port=30303 --rpc --rpcaddr 0.0.0.0 --rpcport=8545 --rpcapi 'personal,db,eth,net,web3,txpool,miner' --ws --wsaddr 0.0.0.0 --wsport 8546 --wsapi 'personal,db,eth,net,web3,txpool,miner' --wsorigins "*" 2>>node1/eth_output.log &
sleep 1s

# Startup node2
echo "Startup node2."
nohup geth --datadir=node2 --bootnodes=enode://2cb6fe8f4a73fdc962bae49cfcc131e642a9f3b9d6cff1384d5e14ad7d25ebf715286e812b3ce70a5c9c6797d71cdbd1432e2ac1a0f6cb06cab3e9e7dd33aea4@127.0.0.1:30301 --networkid 25252 --port=30304 --rpc --rpcaddr 0.0.0.0 --rpcport=8645 --rpcapi 'personal,db,eth,net,web3,txpool,miner' --ws --wsaddr 0.0.0.0 --wsport 8646 --wsapi 'personal,db,eth,net,web3,txpool,miner' --wsorigins "*" 2>>node2/eth_output.log &

# Startup node3
echo "Startup node3."
nohup geth --datadir=node3 --bootnodes=enode://2cb6fe8f4a73fdc962bae49cfcc131e642a9f3b9d6cff1384d5e14ad7d25ebf715286e812b3ce70a5c9c6797d71cdbd1432e2ac1a0f6cb06cab3e9e7dd33aea4@127.0.0.1:30301 --networkid 25252 --port=30305 --rpc --rpcaddr 0.0.0.0 --rpcport=8745 --rpcapi 'personal,db,eth,net,web3,txpool,miner' --ws --wsaddr 0.0.0.0 --wsport 8746 --wsapi 'personal,db,eth,net,web3,txpool,miner' --wsorigins "*" --mine --minerthreads=1 --etherbase="0x72284351d139d28c0220238fd9292689ef9a10df" -unlock '0x72284351d139d28c0220238fd9292689ef9a10df' --password node3/password.txt 2>>node3/eth_output.log &

# Jobs command
# jobs
# kill %1 for bootnode
# kill %2 for geth of node1
# kill %3 for geth of node2
# kill %4 for geth of node3

## Reference
# http://www.cnblogs.com/xd502djj/p/3612131.html
# https://blog.csdn.net/fengyifei11228/article/details/5737371
# http://www.cnblogs.com/mfryf/archive/2012/05/09/2491322.html
