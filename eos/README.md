# 搭建 eos 测试网络

## 附录 1. eos 各进程常用的默认端口

### 1.1 nodeos
- http: 8888
- peer to peer: 9876

### 1.2 keosd
默认并不是通过 TCP 端口，而是通过 UNIX 套接字连接的。UNIX 套接字的位置如下。
```
~/eosio-wallet/keosd.sock
```
