#!/bin/bash

echo "請輸入 sumsub API Token:"
read SUMSUB_APP_TOKEN
echo "請輸入 sumsub API Secret:"
read SUMSUB_APP_SECRET
echo "請輸入 Server Key:"
read SERVER_KEY


# 設定 BTM-backend
echo "" >> BTM-backend/configs/dev.env
echo "#[SUMSUB]" >> BTM-backend/configs/dev.env
echo "SUMSUB.API_URL=https://api.sumsub.com" >> BTM-backend/configs/dev.env
echo "SUMSUB.APP_TOKEN=$SUMSUB_APP_TOKEN" >> BTM-backend/configs/dev.env
echo "SUMSUB.APP_SECRET=$SUMSUB_APP_SECRET" >> BTM-backend/configs/dev.env
echo "" >> BTM-backend/configs/dev.env
echo "" >> BTM-backend/configs/dev.env
echo "SERVER_KEY=$SERVER_KEY" >> BTM-backend/configs/dev.env

# 設定 lamassu-server
echo "" >> /usr/lib/node_modules/lamassu-server/.env
echo "BTM_API_URL=http://127.0.0.1:8080" >> /usr/lib/node_modules/lamassu-server/.env
echo "BTM_API_KEY=$SERVER_KEY" >> /usr/lib/node_modules/lamassu-server/.env


# pull lamassu-server code
rm /usr/lib/node_modules/lamassu-server/lib/whitelist.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/btm-api.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-api.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/btm-cibs.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-cibs.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/cash-in/cash-in-tx.js \
     -o /usr/lib/node_modules/lamassu-server/lib/cash-in/cash-in-tx.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/db.js \
     -o /usr/lib/node_modules/lamassu-server/lib/db.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/routes/customerRoutes.js \
     -o /usr/lib/node_modules/lamassu-server/lib/routes/customerRoutes.js


# 重啟後台
cd BTM-backend
git pull
docker-compose build
docker-compose down
docker-compose up -d


# 重啟 lamassu-server
supervisorctl restart lamassu-admin-server lamassu-server