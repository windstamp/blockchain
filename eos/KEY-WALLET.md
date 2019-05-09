# WALLET KEY

## 1. dfg

### 1.1 remote centos (172.17.3.223)
PW5Jn3ZuytL3QpCQ8ABzKquUrV3g98yBXXgL47jnARAFNe6nERASw

### 1.2 local centos (192.168.56.101)
PW5KFqk3HHmhb2SMLW6Hkk1jVU4PDy4h8gUiCFNPM5NmcSAQw7ST1

### 1.3 local ubuntu (192.168.56.102)
PW5KCzAhiEtadFUeQZkgyttHrVLdQY8eXsMr6BxV8G6vbj3vnN1pz

### 1.4 local ubuntu (192.168.56.103)
PW5KCzAhiEtadFUeQZkgyttHrVLdQY8eXsMr6BxV8G6vbj3vnN1pz

## 2. home

### centos (192.168.56.101)
PW5KM45mLaY5ibuQq6s4S9ueBoMkQuxVJqm5shJHwV1bCfZGknsiJ

### ubuntu (192.168.56.102)
PW5KSymLBmah2wAqi5KrhiJgPnPnLA1BgQwSp5cDG94kcJbDjmyUj

## 附录 1. 钱包的常用操作

### 1.1 查看钱包
```
cleos wallet list
```

### 1.2 打开钱包
```
cleos wallet open
``` 

### 1.3 创建钱包
```
cleos wallet create --to-console
```

### 1.4 解锁钱包
```
cleos wallet unlock
cleos --wallet-url http://127.0.0.1:8899 wallet unlock
```

#### 1.4.1 ubuntu@local@dfg
```
cleos wallet unlock --password PW5KCzAhiEtadFUeQZkgyttHrVLdQY8eXsMr6BxV8G6vbj3vnN1pz
```

### 1.5 查看公钥-私钥对
```
cleos wallet private_keys
```

### 1.6 查看公钥
```
cleos wallet keys
```

### 1.7 导入公钥
```
cleos wallet import --private-key TEXT
```
