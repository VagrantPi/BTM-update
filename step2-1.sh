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

# 重啟後台
cd BTM-backend
git pull
docker-compose build
docker-compose down
docker-compose up -d

# pull lamassu-server code
cd /usr/lib/node_modules/lamassu-server
git pull

# 重啟 lamassu-server
supervisorctl restart lamassu-admin-server lamassu-server

cd ~
