#!/bin/bash

# Step 1. Pull the docker image
sudo docker pull eosio/eos-dev:v1.5.2

# Step 2. Create Network
sudo docker network create eosdev

# Step 3. Boot Containers

# 3.1 Nodeos (Core Daemon)
sudo docker run \
  --name nodeos -d -p 8888:8888 \
  --network eosdev \
  -v /tmp/eosio/work:/work \
  -v /tmp/eosio/data:/mnt/dev/data \
  -v /tmp/eosio/config:/mnt/dev/config \
  eosio/eos-dev \
/bin/bash -c \
  "nodeos -e -p eosio \
    --plugin eosio::producer_plugin \
    --plugin eosio::history_plugin \
    --plugin eosio::chain_api_plugin \
    --plugin eosio::history_api_plugin \
    --plugin eosio::http_plugin \
    -d /mnt/dev/data \
    --config-dir /mnt/dev/config \
    --http-server-address=0.0.0.0:8888 \
    --access-control-allow-origin=* \
    --contracts-console \
    --http-validate-host=false"

# 3.2 Run Keosd (Wallet and Keystore)
sudo docker run -d --name keosd --network=eosdev \
-i eosio/eos-dev /bin/bash -c "keosd --http-server-address=0.0.0.0:9876"

