# 搭建多主机多节点测试网络
具体的节点信息参考附录 1。

## 1. 启动创世节点 genesis
```
$ cd genesis
$ source genesis_start.sh
```

## 2. 前置条件
注意，下述脚本需要在启动创世节点之后来运行，因为它们都需要已经存在一个区块链。

### 2.1 创建账号 (node1, node2, node3)
通过外部脚本 scripts 中对应的脚本来实现。
```
$ cd path/to/scripts
$ source create_accounts.sh
```

这一步可能需要先解锁钱包才行
```
$ source wallet_unlock_*.sh
```

### 2.2 编译和部署智能合约 (eosio.bios)
通过外部脚本 scripts 中对应的脚本来实现。
```
$ cd path/to/scripts
$ source contract_compile.sh
$ source contract_deploy.sh
```

其中，编译脚本只需要执行一次，如果已经编译好了则不需要再编译，直接部署即可。

## 3. 启动节点 node1
```
$ cd node1
$ source genesis_start.sh
```

## 4. 启动节点 node2
```
$ cd node2
$ source genesis_start.sh
```

## 5. 设置生产者
```
$ cd scripts
$ tree -L 1
.
├── set_prods_eosio_node1.sh
├── set_prods_eosio.sh
├── set_prods_node1_node2.sh
├── set_prods_node1.sh
├── set_prods_node2.sh
├── set_prods_node3.sh
└── set_prods.sh

0 directories, 7 files
```

根据生产者的具体配置，可以执行相应的脚本。如：
```
$ source set_prods.sh
$ source set_prods_eosio.sh
$ source set_prods_eosio_node1.sh
```

## 附录 1. 节点信息

### 1.0 genesis
需要先启动一个创世节点，因为这个时候链上只有一个默认账户 eosio，从而使得节点 node1, node2, node3 都启动不了，因为此时链上还没有对应的账户 node1, node2, node3。

genesis 暂时选择 node3 来代替。所以我们这里暂时没有节点 node3。

## 1. node1
- IP Address: 192.168.56.101

## 2. node2
- IP Address: 192.168.56.102

## 3. node3 
- IP Address: 192.168.56.103

## 附录 2. 注册生产者
```
$ cleos system regproducer node1 EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV https://github.com/windstamp
$ cleos system regproducer node2 EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV https://github.com/windstamp
$ cleos system regproducer node3 EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV https://github.com/windstamp
```

也可以通过将 eosio.bios 智能合约部署到网络，然后通过合约的 action setprods 来完成。

## 附录 3. 账户 eosio
- public key: EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV
- private key: 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
