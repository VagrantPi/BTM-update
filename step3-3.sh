#!/bin/bash

# 設定 lamassu-server
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/notifier/index.js \
     -o /usr/lib/node_modules/lamassu-server/lib/notifier/index.js

# 重啟 lamassu-server
supervisorctl restart lamassu-admin-server lamassu-server

cd ~