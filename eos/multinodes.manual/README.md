# 搭建本地多节点测试网络
此次测试需要开启 4 个命令行窗口。当然，也可以开一个，其它的作为后台进程运行，这样可以脚本化。

## 1. 启动钱包管理器
启动第 1 个命令行窗口。

```
keosd --http-server-address 127.0.0.1:8899
```

还可以通过下列命令对非本地节点开放，不过这样不安全。
```
keosd --http-server-address 0.0.0.0:8899
```

## 2. 创建钱包
启动第 2 个命令行窗口。

```
cleos --wallet-url http://127.0.0.1:8899  wallet create --to-console
```

这里需要记住生成的钱包密码。

## 3. 导入密钥
在第 2 个命令行窗口执行。

### 3.1 导入账户 eosio 的密钥
```
$ cleos --wallet-url http://127.0.0.1:8899 wallet import --private-key 5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3
```

### 3.2 导入通用密钥
这里提供一对通用密钥对，避免每次重新创建时都会生成不同的随机密钥，方便测试，尤其是在不同机器上多次执行，有利于脚本化。
```
$ cleos --wallet-url http://127.0.0.1:8899 wallet import --private-key 5JgbL2ZnoEAhTudReWH1RnMuQS6DBeLZt4ucV6t8aymVEuYg7sr
```

这些密钥对可以在文档 KEY-ACCOUNT.md 中找到。

## 3. 启动第 1 个生产者
启动第 3 个命令行窗口。

```
nodeos --enable-stale-production --producer-name eosio --config-dir node1/config --data-dir node1/data --plugin eosio::chain_api_plugin --plugin eosio::net_api_plugin
```

上述命令会创建一个特殊的生产者，就是 bios 生产者。

## 4. 启动第 2 个生产者之前的一些准备工作
启动另外节点之前，需要先加载智能合约 eosio.bios。智能合约 eosio.bios 使你可以直接控制对其它账户的资源分配，和访问特权 API。

这个可以在第 2 个命令行执行。
```
cleos --wallet-url http://127.0.0.1:8899 set contract eosio /PATH/TO/eosio.bios
```

智能合约 eosio.bios 的构建可以参考文档 《智能合约 - bios》。

我们创建账户 `inita` 作为生产者。这个生产者的密钥利用之前导入的通用密钥。
```
cleos --wallet-url http://127.0.0.1:8899 create account eosio inita EOS6hMjoWRF2L8x9YpeqtUEcsDKAyxSuM1APicxgRU1E3oyV5sDEg
```

## 5. 启动第 2 个生产者
启动第 4 个命令行窗口。
```
nodeos --producer-name inita --plugin eosio::chain_api_plugin --plugin eosio::net_api_plugin --http-server-address 127.0.0.1:8889 --p2p-listen-endpoint 127.0.0.1:9877 --p2p-peer-address 127.0.0.1:9876 --config-dir node2/config --data-dir node2/data --private-key [\"EOS6hMjoWRF2L8x9YpeqtUEcsDKAyxSuM1APicxgRU1E3oyV5sDEg\",\"5JgbL2ZnoEAhTudReWH1RnMuQS6DBeLZt4ucV6t8aymVEuYg7sr\"]
```

此时，会启动第 2 个 nodeos 节点。但是，这个节点并不会生产区块，它只会不断地去同步第一个节点生产的区块。

可以通过下列命令将第 2 个节点设置为生产者节点，但是这样的话第 1 节点又不是生产者节点了。
```
cleos --wallet-url http://127.0.0.1:8899 push action eosio setprods "{ \"schedule\": [{\"producer_name\": \"inita\",\"block_signing_key\": \"EOS6hMjoWRF2L8x9YpeqtUEcsDKAyxSuM1APicxgRU1E3oyV5sDEg\"}]}" -p eosio@active
```

或者通过下列命令，直接启动第 2 个生产者节点？这样会有两个生产者节点？
```
nodeos --enable-stale-production --producer-name inita --plugin eosio::chain_api_plugin --plugin eosio::net_api_plugin --http-server-address 127.0.0.1:8889 --p2p-listen-endpoint 127.0.0.1:9877 --p2p-peer-address 127.0.0.1:9876 --config-dir node2/config --data-dir node2/data --private-key [\"EOS6hMjoWRF2L8x9YpeqtUEcsDKAyxSuM1APicxgRU1E3oyV5sDEg\",\"5JgbL2ZnoEAhTudReWH1RnMuQS6DBeLZt4ucV6t8aymVEuYg7sr\"]
```

## 6. 测试
通过之前的步骤，已经成功启动了 2 个节点。

获取第 1 个节点的信息
```
cleos get info
```

或者等价的
```
cleos --url http://127.0.0.1:8888 get info
```

获取第 2 个节点的信息
```
cleos --url http://127.0.0.1:8889 get info
```

## 附录 1. 设置生产者
```
cleos --wallet-url http://127.0.0.1:8899 push action eosio setprods "{ \"schedule\": [{\"producer_name\": \"inita\",\"block_signing_key\": \"EOS6hMjoWRF2L8x9YpeqtUEcsDKAyxSuM1APicxgRU1E3oyV5sDEg\"}]}" -p eosio@active
```

```
cleos --url http://127.0.0.1:8888 --wallet-url http://127.0.0.1:8899 push action eosio setprods "{ \"schedule\": [{\"producer_name\": \"inita\",\"block_signing_key\": \"EOS6hMjoWRF2L8x9YpeqtUEcsDKAyxSuM1APicxgRU1E3oyV5sDEg\"}]}" -p eosio@active
```

```
cleos --wallet-url http://127.0.0.1:8899 push action eosio setprods "{ \"schedule\": [{\"producer_name\": \"eosio\",\"block_signing_key\": \"EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV\"}]}" -p eosio@active
```
