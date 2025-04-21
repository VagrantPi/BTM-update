#!/bin/bash


# lamassu-server 拉新程式碼
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/btm-tools/email.js \
     -o /usr/lib/node_modules/lamassu-server/btm-tools/email.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/btm-change-log.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-change-log.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/btm-invoice.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-invoice.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/btm-mock-tx-history-logs.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-mock-tx-history-logs.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/btm-risk-control-customer-limit-setting.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-risk-control-customer-limit-setting.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/btm-riskcontrol.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-riskcontrol.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/btm-tx.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-tx.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/cash-in/cash-in-tx.js \
     -o /usr/lib/node_modules/lamassu-server/lib/cash-in/cash-in-tx.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/notifier/index.js \
     -o /usr/lib/node_modules/lamassu-server/lib/notifier/index.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/routes/customerRoutes.js \
     -o /usr/lib/node_modules/lamassu-server/lib/routes/customerRoutes.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/routes/phoneCodeRoutes.js \
     -o /usr/lib/node_modules/lamassu-server/lib/routes/phoneCodeRoutes.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/tx.js \
     -o /usr/lib/node_modules/lamassu-server/lib/tx.js

supervisorctl restart lamassu-admin-server lamassu-server


cd BTM-backend
curl -L https://github.com/VagrantPi/BTM-Admin/releases/download/v0.0.49/dist.zip -o dist.zip
unzip dist.zip
rm dist.zip
git pull
docker-compose build
docker-compose down
docker-compose up -d

cd ~

