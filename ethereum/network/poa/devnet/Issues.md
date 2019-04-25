# Issues

## Fatal: Error starting protocol stack: listen unix <PATH_TO_DATADIR>/geth.ipc: bind: invalid argument
Fatal: Error starting protocol stack: listen unix /home/furnace/bitbucket/zblockchain/ethereumcodes/linux/network/private/poa/hackernoon/devnet/node1/geth.ipc: bind: invalid argument

这个问题不是以太坊的问题 [1, 2]

## 解决办法
我这里的解决办法，是路径太长了 /home/furnace/bitbucket/zblockchain/ethereumcodes/linux/network/private/poa/hackernoon/devnet/

重新调整为：/home/furnace/ethereumcodes/linux/network/private/poa/hackernoon/devnet

## 需要注意的
当 PoA 的创建文件中的 period 调整为 0 之后，只有当有新的交易时才会创建新的区块，需要注意。


## Reference
1. https://github.com/ethereum/go-ethereum/issues/16342#issuecomment-406536834
2. https://github.com/ethereum/go-ethereum/blob/master/rpc/ipc_unix.go#L35
