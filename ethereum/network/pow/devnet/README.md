# Setup your own private Proof-of-Work Ethereum network with Geth

## Appendix A. The whole steps

### 1. Prepare
#### 1.1 Create workspace
[furnace@localhost devnet]$ mkdir devnet
[furnace@localhost devnet]$ cd devnet
[furnace@localhost devnet]$ mkdir node1 node2 node3
[furnace@localhost devnet]$

#### 1.2 Create accounts
[furnace@localhost devnet]$ geth --datadir node1 account new
[furnace@localhost devnet]$ geth --datadir node1 account new

[furnace@localhost devnet]$ echo "0xbbd1162680cd96607c8ad781a6ebeb319cddede4" >> node1/accounts.txt
[furnace@localhost devnet]$ echo "0x15b8f695c91015215473b3d6a2f2baadc8464cb3" >> node2/accounts.txt
[furnace@localhost devnet]$ echo '0x25f9e9382c87e9a080dce986b1b4e8355da8f43b' >> node3/accounts.txt

[furnace@localhost devnet]$ echo '123456' > node1/password.txt
[furnace@localhost devnet]$ echo '123456' > node2/password.txt
[furnace@localhost devnet]$ echo '123456' > node3/password.txt

#### 1.3 Create genesis file
By tool `puppeth`.

### 2. Play
The following can execute by script `deploy.sh`.

#### 2.1 Clear nodes
```
[furnace@localhost devnet]$ rm -rf ~/.ethash/
[furnace@localhost devnet]$ rm -rf node1/geth/
[furnace@localhost devnet]$ rm -rf node2/geth/
[furnace@localhost devnet]$ rm -rf node3/geth/
[furnace@localhost devnet]$ rm -rf node1/eth_output.log
[furnace@localhost devnet]$ rm -rf node2/eth_output.log
[furnace@localhost devnet]$ rm -rf node3/eth_output.log
[furnace@localhost devnet]$ rm -rf bootnode_output.log
```

#### 2.2 Init nodes
[furnace@localhost devnet]$ geth --datadir node1 init genesis.json
[furnace@localhost devnet]$ geth --datadir node2 init genesis.json
[furnace@localhost devnet]$ geth --datadir node3 init genesis.json

#### 2.3 Create bootnode
[furnace@localhost devnet]$ bootnode -genkey boot.key

#### 2.4 Startup bootnode
[furnace@localhost devnet]$ bootnode -nodekey boot.key -verbosity 9 -addr :30301

#### 2.5 Startup node1
[furnace@localhost devnet]$ geth --datadir=node1 --bootnodes=enode://2cb6fe8f4a73fdc962bae49cfcc131e642a9f3b9d6cff1384d5e14ad7d25ebf715286e812b3ce70a5c9c6797d71cdbd1432e2ac1a0f6cb06cab3e9e7dd33aea4@127.0.0.1:30301 --port=30303 --rpc --rpcaddr 0.0.0.0 --rpcport=8545 --rpcapi 'personal,db,eth,net,web3,txpool,miner' --ws --wsaddr 0.0.0.0 --wsport 8546 --wsapi 'personal,db,eth,net,web3,txpool,miner' --wsorigins "*" --verbosity 3 console 2>>node1/eth_output.log

#### 2.6 Startup node2
[furnace@localhost devnet]$ geth --datadir=node2 --bootnodes=enode://2cb6fe8f4a73fdc962bae49cfcc131e642a9f3b9d6cff1384d5e14ad7d25ebf715286e812b3ce70a5c9c6797d71cdbd1432e2ac1a0f6cb06cab3e9e7dd33aea4@127.0.0.1:30301 --port=30304 --rpc --rpcaddr 0.0.0.0 --rpcport=8645 --rpcapi 'personal,db,eth,net,web3,txpool,miner' --ws --wsaddr 0.0.0.0 --wsport 8646 --wsapi 'personal,db,eth,net,web3,txpool,miner' --wsorigins "*" --verbosity 3 console 2>>node2/eth_output.log

#### 2.7 Startup node2
```
[furnace@localhost devnet]$ geth --datadir=node3 --bootnodes=enode://2cb6fe8f4a73fdc962bae49cfcc131e642a9f3b9d6cff1384d5e14ad7d25ebf715286e812b3ce70a5c9c6797d71cdbd1432e2ac1a0f6cb06cab3e9e7dd33aea4@127.0.0.1:30301 --port=30305 --rpc --rpcaddr 0.0.0.0 --rpcport=8745 --rpcapi 'personal,db,eth,net,web3,txpool,miner' --ws --wsaddr 0.0.0.0 --wsport 8646 --wsapi 'personal,db,eth,net,web3,txpool,miner' --wsorigins "*" --mine --minerthreads=1 --etherbase="0x3ca39a64bc1eda8669d539631b44dbd4a43ed0f8" --verbosity 3 console 2>>node3/eth_output.log
```
