# 搭建本地单节点测试网络
本教程用于描述如何搭建本地单节点测试网络。本教程功能上类似于 mininode，但是脚本更加实用，而且只通过脚本来运行，并且只通过命令行参数来指定需要启动的插件模块，如果需要通过配置文件指定，可以参考 mininode 教程。

## 1. 通过脚本启动本地单节点测试网络

### 1.1 配置创世区块
- genesis_start.sh

### 1.2 不配置创世区块
- start.sh

### 1.3 启动时强制检查区块
- hard_start.sh
    - --hard-replay-blockchain

## 附录 1. 选项参数说明

### 1.1 --signature-provider
--signature-provider EOS6MRyAjQq8ud7hVNYcfnVPJqcVpscN5So8BhtHuGYqET5GDW5CV=KEY:5KQwrPbwdL6PhXujxW37FSSQZ1JiwsST4cqQzDeyXtP79zkvFD3 \

- 注意，这里的 KESY 需要对应文件 genesis.json 中的字段 initial_key.
- 指不指定应该都一样，因为下面的 KEYS 是账户 eosio 的默认 KEYS.

### 1.2 --http-server-address
--http-server-address 0.0.0.0:8888

- 默认端口 8888
- 0.0.0.0 可以对外提供服务
- 127.0.0.1 只对本机提供服务
- <IP Address> 

### 1.3 --p2p-listen-endpoint
--p2p-listen-endpoint 0.0.0.0:9876

-默认端口 9876
- 0.0.0.0 可以对外提供服务
- 127.0.0.1 只对本机提供服务
- <IP Address> 
