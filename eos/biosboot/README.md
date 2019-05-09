# 搭建 bios-boot 网络

## 0. 前置条件

当前目录
```
furnace@furnace:~/bitbucket/zblockchain/blockchain/eos$ pwd
~/bitbucket/zblockchain/blockchain/eos
```

## 1. Create, configure and start the genesis node

### 1.1 创建目录 biosboot/genesis
```
mkdir biosboot
cd biosboot
mkdir genesis
cd genesis
```

### 1.2 在 biosboot/genesis 目录下创建配置和脚本文件。
目录 biosboot 的整体结构。
```
furnace@furnace:~/bitbucket/zblockchain/blockchain/eos/biosboot$ pwd
/home/furnace/bitbucket/zblockchain/blockchain/eos/biosboot
furnace@furnace:~/bitbucket/zblockchain/blockchain/eos/biosboot$ tree -L 2
.
├── genesis
│   ├── clean.sh
│   ├── genesis_start.sh
│   ├── hard_start.sh
│   ├── start.sh
│   └── stop.sh
├── genesis.json
└── README.md

1 directory, 7 files
```

### 1.3 创建相应账号
通过脚本 create_account.sh 实现

### 1.4 编译和部署合约
这里假设合约的顶级目录为 ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts。

#### 1.4.1 eosio.bios
```
furnace@furnace:~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.bios$ pwd
/home/furnace/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.bios
furnace@furnace:~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.bios$ eosio-cpp -I include -I ../eosio.token/include -o eosio.bios.wasm src/eosio.bios.cpp --abigen
```

```
cleos set contract eosio ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.bios/
```

```
cleos set contract eosio ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.bios/ --abi eosio.bios.abi -p eosio@active
```

#### 1.4.2 eosio.token
```
furnace@furnace:~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.token$ pwd
/home/furnace/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.token
furnace@furnace:~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.token$ eosio-cpp -I include -o eosio.token.wasm src/eosio.token.cpp --abigen
```

```
cleos set contract eosio.token ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.token/
```

```
cleos set contract eosio.token ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.token --abi eosio.token.abi -p eosio.token@active
```

#### 1.4.3 eosio.msig
```
furnace@furnace:~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.msig$ pwd
/home/furnace/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.msig
furnace@furnace:~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.msig$ eosio-cpp -I include -o eosio.msig.wasm src/eosio.msig.cpp --abigen
```

```
cleos set contract eosio.msig ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.msig/
```

```
cleos set contract eosio.msig ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.msig/ --abi eosio.msig.abi -p eosio.msig@active
```

#### 1.4.4 Create and allocate the SYS currency
```
cleos push action eosio.token create '[ "eosio", "10000000000.0000 SYS" ]' -p eosio.token@active
```

```
cleos push action eosio.token issue '[ "eosio", "1000000000.0000 SYS", "memo" ]' -p eosio@active
```

#### 1.4.5 eosio.system
```
furnace@furnace:~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.system$ pwd
/home/furnace/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.system
furnace@furnace:~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.system$ eosio-cpp -I include -I ../eosio.token/include -o eosio.system.wasm src/eosio.system.cpp --abigen
```

```
cleos set contract eosio ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.system/
```

```
cleos set contract eosio ~/bitbucket/zblockchain/eoscodes/contracts/eosio.contracts/eosio.system/ --abi eosio.system.abi -p eosio@active
```

## 2. Transition from single genesis producer to multiple producers

### 2.1. Make eosio.msig a privileged account
```
cleos push action eosio setpriv '["eosio.msig", 1]' -p eosio@active
```

### 2.2. Initialize system account
```
cleos push action eosio init '["0", "4,SYS"]' -p eosio@active
```

### 2.4. Create staked accounts
```
cleos system newaccount eosio --transfer accountnum11 EOS8mUftJXepGzdQ2TaCduNuSPAfXJHf22uex4u41ab1EVv9EAhWt --stake-net "100000.0000 SYS" --stake-cpu "100000.0000 SYS" --buy-ram-kbytes 8192
```

### 2.5. Register the new account as a producer
```
cleos system regproducer accountnum11 EOS8mUftJXepGzdQ2TaCduNuSPAfXJHf22uex4u41ab1EVv9EAhWt https://accountnum11.com
```

### 2.6. List the producers
```
cleos system listproducers
```

### 2.7. Set up and start a new producer
```
furnace@furnace:~/bitbucket/zblockchain/blockchain/eos/biosboot/accountnum11$ pwd
/home/furnace/bitbucket/zblockchain/blockchain/eos/biosboot/accountnum11
furnace@furnace:~/bitbucket/zblockchain/blockchain/eos/biosboot/accountnum11$ tree -L 2
.
├── clean.sh
├── genesis_start.sh
├── hard_start.sh
├── start.sh
└── stop.sh

0 directories, 5 files
```

```
furnace@furnace:~/bitbucket/zblockchain/blockchain/eos/biosboot/accountnum11$ source genesis_start.sh
furnace@furnace:~/bitbucket/zblockchain/blockchain/eos/biosboot/accountnum11$ tail -f blockchain/nodeos.log
```

### 2.8. repeat the process of creating as many producers as you want
You can now repeat the process (started at point 2.4. till 2.8.) of creating as many producers as you want each with its own staked account, own dedicated directory named accountnumXY (with X and Y int values in interval [1..5]), and their own dedicated script files: genesis_start.sh, start.sh, stop.sh, clean.sh located in their corresponding folder.

### 2.9. vote for each of the block producers started
```
cleos system voteproducer prods accountnum11 accountnum11 accountnum12 accountnum13
```

```
cleos system voteproducer prods accountnum12 accountnum11
```

```
cleos system voteproducer prods accountnum13 accountnum11
```

## 3. Resign eosio account and system accounts

## 附录 2. accountnum12
```
cleos system newaccount eosio --transfer accountnum12 EOS8mUftJXepGzdQ2TaCduNuSPAfXJHf22uex4u41ab1EVv9EAhWt --stake-net "100000.0000 SYS" --stake-cpu "100000.0000 SYS" --buy-ram-kbytes 8192
```

```
cleos system regproducer accountnum12 EOS8mUftJXepGzdQ2TaCduNuSPAfXJHf22uex4u41ab1EVv9EAhWt https://accountnum12.com
```

```
cleos system listproducers
```

## 附录 3. accountnum13
```
cleos system newaccount eosio --transfer accountnum13 EOS8mUftJXepGzdQ2TaCduNuSPAfXJHf22uex4u41ab1EVv9EAhWt --stake-net "100000.0000 SYS" --stake-cpu "100000.0000 SYS" --buy-ram-kbytes 8192
```

```
cleos system regproducer accountnum13 EOS8mUftJXepGzdQ2TaCduNuSPAfXJHf22uex4u41ab1EVv9EAhWt https://accountnum13.com
```

```
cleos system listproducers
```
