# 搭建本地单节点测试网络
本教程用于描述如何搭建本地单节点测试网络。这里是迷你型节点，脚本也是最简单的，但是所需要了解的知识也是最少的。

## 1. 从命令行启动
下列命令可以启动一个 EOS 节点，并且会不断地生产区块。
```
$ nodeos -e -p eosio
```

上述命令还会生成相应的目录，默认的位置为 ~/.local/share/eosio/nodeos/. 其中， 目录 data 中对应生成的区块链数据，目录 config 包含配置信息。

```
$ tree -L 2 ~/.local/share/eosio/nodeos/
/home/furnace/.local/share/eosio/nodeos/
├── config
│   └── config.ini
└── data
    ├── blocks
    ├── snapshots
    └── state

5 directories, 1 file
```

可以看出，上述命令并没有指定生产区块等相应的插件，却仍然能够正常生产区块。这是因为 nodeos 会默认启动两个插件，即 chain_plugin 和 producer_plugin 。因此，上述命令等价于
```
$ nodeos -e -p eosio --plugin eosio::chain_plugin --plugin eosio::producer_plugin
```

## 附录 1. 生成配置文件
```
$ nodeos -e -p eosio --data-dir data --config-dir config --plugin eosio::chain_plugin --plugin eosio::producer_plugin
```

执行上述命令，在生产区块之后按 CTRL + C 结束，会在当前目录生成 config/config.ini 文件。
```
$ tree -L 2
.
├── config
│   └── config.ini
├── data
│   ├── blocks
│   ├── snapshots
│   └── state
└── README.md

5 directories, 2 files
```

## 附录 2. 指定数据目录和配置文件
```
$ nodeos -e -p eosio --data-dir data --config-dir config
```

注意，这里指定了 data 目录，还有 config 目录。

## 附录 3. 打开指定插件
这里打开 RPC 插件，从而可以通过 RPC 接口查询节点信息。

```
nodeos -e -p eosio --plugin eosio::chain_plugin --plugin eosio::producer_plugin --plugin eosio::chain_api_plugin
```

打开另一个命令行窗口，执行下列命令可以获取到指定节点信息。
```
curl http://127.0.0.1:8888/v1/chain/get_info
```

打开更多的插件模块。
```
$ nodeos -e -p eosio --plugin eosio::chain_plugin --plugin eosio::producer_plugin --plugin eosio::chain_api_plugin --plugin eosio::http_plugin --plugin eosio::history_plugin --plugin eosio::history_api_plugin
```

## 附录 4. 设置 nodeos 的 RPC 端口
```
$ nodeos -e -p eosio --plugin eosio::chain_plugin --plugin eosio::producer_plugin --plugin eosio::chain_api_plugin --plugin eosio::http_plugin --plugin eosio::history_plugin --plugin eosio::history_api_plugin --http-server-address=0.0.0.0:8888 --access-control-allow-origin='*'
```

可以获取到指定节点信息。
```
curl http://<IP Address>:8888/v1/chain/get_info
```

假设 IP Address 为 192.168.56.101。则可以通过浏览器访问下列 URL 获取节点信息。
```
http://192.168.56.101:8888/v1/chain/get_info
```

## 附录 5. 清除之前的区块链数据
通过添加选项 --delete-all-blocks 清除之前的区块链数据。

```
$ nodeos -e -p eosio --delete-all-blocks --data-dir data --plugin eosio::chain_api_plugin --plugin eosio::history_api_plugin
```

## 附录 6. 通过脚本启动
通过命令行参数指定插件模块等信息。
```
$ source deploy.sh
```

通过配置文件指定插件模块等信息。
```
$ source deploy_with_config.sh
```

通过后台进程运行 nodeos，并将日志输出到文件 nodeos.log 中。
```
$ source deploy_as_daemon.sh
```

通过下列命令显示输出日志。
```
$ tail -f nodeos.log
```

通过脚本结束上述运行的后台 nodeos 进程。
```
$ source stop.sh
```

通过下列命令清除历史数据
```
$ source clean.sh
```
