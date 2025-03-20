#!/bin/bash

cd /usr/lib/node_modules/lamassu-server/
git checkout


# 設定 lamassu-server
mkdir -p /usr/lib/node_modules/lamassu-server/btm-tools
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/btm-tools/ecpay.js \
     -o /usr/lib/node_modules/lamassu-server/btm-tools/ecpay.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/btm-invoice.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-invoice.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/btm-sumsub.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-sumsub.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/notifier/index.js \
     -o /usr/lib/node_modules/lamassu-server/lib/notifier/index.js

# 重啟 lamassu-server
supervisorctl restart lamassu-admin-server lamassu-server

cd ~