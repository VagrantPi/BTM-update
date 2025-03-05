#!/bin/bash

rm /usr/lib/node_modules/lamassu-server/lib/whitelist.js

curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/btm-api.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-api.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/btm-cibs.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-cibs.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/btm-whitelist.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-whitelist.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/cash-in/cash-in-tx.js \
     -o /usr/lib/node_modules/lamassu-server/lib/cash-in/cash-in-tx.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/db.js \
     -o /usr/lib/node_modules/lamassu-server/lib/db.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/routes/customerRoutes.js \
     -o /usr/lib/node_modules/lamassu-server/lib/routes/customerRoutes.js


# 重啟 lamassu-server
supervisorctl restart lamassu-admin-server lamassu-server

cd ~