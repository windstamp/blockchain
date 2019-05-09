#!/bin/bash

# 停止之前启动的所有 nodeos
source stop.sh

# 清空所有的 nodeos 数据
source clean.sh

# 启动部署
source deploy.sh


