# 搭建本地多节点测试网络

## 1.1 启动节点 node1
```
$ cd node1
$ source genesis_start.sh
```

## 1.2 创建账号
外层目录 scripts 中
```
$ source create_account.sh
```

## 1.3 启动节点 node2
```
$ cd node2
$ source genesis_start.sh
```

## 1.3 启动节点 node3
如果需要测试多个生产者节点，则可以启动节点 node3.
```
$ cd node3
$ source genesis_start.sh
```

## 1.4 设置生产者

### 1.4.0 前置条件
这需要满足前置条件
- 账户 inita 已经创建
- 智能合约 eosio.bios 已经被部署到区块链上

具体的可参考外层目录 scripts 中的相应脚本。

### 1.4.1 设置账户 eosio 为生产者
执行下列命令将 node1 设为生产者节点。
```
$ cleos push action eosio setprods "{ \"schedule\": [{\"producer_name\": \"eosio\",\"block_signing_key\": \"EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV\"}]}" -p eosio@active
```

或者执行
```
$ source scripts/set_prods_eosio.sh
```

### 1.4.2 设置账户 inita 为生产者
执行下列命令将 node3 设为生产者节点。
```
$ cleos push action eosio setprods "{ \"schedule\": [{\"producer_name\": \"inita\",\"block_signing_key\": \"EOS6hMjoWRF2L8x9YpeqtUEcsDKAyxSuM1APicxgRU1E3oyV5sDEg\"}]}" -p eosio@active
```

或者执行
```
$ source scripts/set_prods_inita.sh
```

### 1.4.3 设置账户 eosio 和 inita 为生产者
执行下列命令将 node1 和 node3 设为生产者节点。
```
$ cleos push action eosio setprods "{ \"schedule\": [{\"producer_name\": \"inita\",\"block_signing_key\": \"EOS6hMjoWRF2L8x9YpeqtUEcsDKAyxSuM1APicxgRU1E3oyV5sDEg\"}, {\"producer_name\": \"eosio\",\"block_signing_key\": \"EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV\"}]}" -p eosio@active
```

或者执行
```
$ source scripts/set_prods.sh
```

## 附录 1. 生产者 & 非生产者
节点可以是生产者，也可以是非生产者。

为了测试方便，这里我们将 node1 配置成生产者，node2 配置成非生产者，node3 配置成生产者。

### 1.1 单个生产者
先启动生产者节点 node1，再启动非生产者节点 node2。节点 node1 会不停地生产区块，节点 node2 会不停地去接收和同步 node1 生产的区块。

### 1.2 多个生产者
先启动生产者节点 node1，再启动非生产者节点 node2。节点 node1 会不停地生产区块，节点 node2 会不停地去接收和同步 node1 生产的区块。

再启动生产者节点 node3。
