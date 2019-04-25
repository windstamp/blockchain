# Setup your own private Proof-of-Authority Ethereum network with Geth

## Appendix A. The whole steps

### 1. Prepare
#### 1.1 Create workspace
[furnace@localhost devnet]$ mkdir devnet
[furnace@localhost devnet]$ cd devnet
[furnace@localhost devnet]$ mkdir node1 node2
[furnace@localhost devnet]$

#### 1.2 Create accounts
[furnace@localhost devnet]$ geth --datadir node1 account new
[furnace@localhost devnet]$ geth --datadir node1 account new

[furnace@localhost devnet]$ echo 'bac5564cc4f7528ebb6150270ee63b3fa1641b17' >> accounts.txt
[furnace@localhost devnet]$ echo '8a6673dc85e544bce6d4876f63cfcdc4e5c8cc08' >> accounts.txt

[furnace@localhost devnet]$ echo 'pwdnode1' > node1/password.txt
[furnace@localhost devnet]$ echo 'pwdnode2' > node2/password.txt

#### 1.3 Create genesis file
By tool `puppeth`.

### 2. Play
The following can execute by script `deploy.sh`.

#### 2.1 Clear nodes
[furnace@localhost devnet]$ rm -rf node1/geth
[furnace@localhost devnet]$ rm -rf node2/geth
[furnace@localhost devnet]$ rm -rf node1/eth_output.log
[furnace@localhost devnet]$ rm -rf node2/eth_output.log
[furnace@localhost devnet]$ rm -rf bootnode_output.log

#### 2.2 Init nodes
[furnace@localhost devnet]$ geth --datadir node1 init genesis.json
[furnace@localhost devnet]$ geth --datadir node2 init genesis.json

#### 2.3 Create bootnode
[furnace@localhost devnet]$ bootnode -genkey boot.key

#### 2.4 Startup bootnode
[furnace@localhost devnet]$ bootnode -nodekey boot.key -verbosity 9 -addr :30310

#### 2.5 Startup node1
[furnace@localhost devnet]$ geth --datadir node1/ --syncmode 'full' --port 30311 --rpc --rpcaddr 0.0.0.0 --rpcport 8501 --rpcapi 'personal,db,eth,net,web3,txpool,miner' --rpccorsdomain "*" --ws --wsaddr 0.0.0.0 --wsport 8601 --wsapi 'personal,db,eth,net,web3,txpool,miner' --wsorigins "*" --bootnodes 'enode://bde0739c7d9f213054575574d6e8e1df21147066a666bc939f29634dac947ad5c715a990d878264fe91a83c9fa0495911c824fe43329570c8d0510c8fa3243f2@127.0.0.1:30310' --networkid 1515 --gasprice '1' -unlock '0xbac5564cc4f7528ebb6150270ee63b3fa1641b17' --password node1/password.txt --mine 2>>node1/eth_output.log &

#### 2.6 Startup node2
[furnace@localhost devnet]$ geth --datadir node2/ --syncmode 'full' --port 30312 --rpc --rpcaddr 'localhost' --rpcport 8502 --rpcapi 'personal,db,eth,net,web3,txpool,miner' --ws --wsaddr 0.0.0.0 --wsport 8602 --wsapi 'personal,db,eth,net,web3,txpool,miner' --wsorigins "*" --bootnodes 'enode://bde0739c7d9f213054575574d6e8e1df21147066a666bc939f29634dac947ad5c715a990d878264fe91a83c9fa0495911c824fe43329570c8d0510c8fa3243f2@127.0.0.1:30310' --networkid 1515 --gasprice '1' -unlock '0x8a6673dc85e544bce6d4876f63cfcdc4e5c8cc08' --password node2/password.txt --mine 2>>node2/eth_output.log &

## Reference
1. Setup your own private Proof-of-Authority Ethereum network with Geth, https://hackernoon.com/setup-your-own-private-proof-of-authority-ethereum-network-with-geth-9a0a3750cda8
