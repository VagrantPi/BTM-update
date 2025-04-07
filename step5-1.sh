#!/bin/bash

echo "請輸入 加密金鑰:"
read SENSITIVE_DATA_ENCRYPT_KEY
echo "請輸入 Sumsub Webhook Secret Key:"
read SUMSUB_WEBHOOK_SECRET_KEY

# 設定 lamassu-server
echo "" >> /usr/lib/node_modules/lamassu-server/.env
echo "SENSITIVE_DATA_ENCRYPT_KEY=\"$SENSITIVE_DATA_ENCRYPT_KEY\"" >> /usr/lib/node_modules/lamassu-server/.env

# 設定 BTM-backend
echo "" >> BTM-backend/configs/dev.env
echo "SUMSUB.WEBHOOK_SECRET_KEY=$SUMSUB_WEBHOOK_SECRET_KEY" >> BTM-backend/configs/dev.env
echo "" >> BTM-backend/configs/dev.env
echo "SENSITIVE_DATA_ENCRYPT_KEY=$SENSITIVE_DATA_ENCRYPT_KEY" >> BTM-backend/configs/dev.env


cd BTM-backend
curl -L https://github.com/VagrantPi/BTM-Admin/releases/download/v0.0.43/dist.zip -o dist.zip
unzip dist.zip
rm dist.zip
cp ../ssl/* docker/ssl/
git pull
docker-compose build
docker-compose down
docker-compose up -d

cd ~


# lamassu-server 拉新程式碼
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/cash-in/cash-in-tx.js \
     -o /usr/lib/node_modules/lamassu-server/lib/cash-in/cash-in-tx.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/btm-crypto.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm-crypto.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/notifier/index.js \
     -o /usr/lib/node_modules/lamassu-server/lib/notifier/index.js
supervisorctl restart lamassu-admin-server lamassu-server


