#!/bin/bash

echo "請輸入 加密金鑰:"
read SENSITIVE_DATA_ENCRYPT_KEY
echo "請輸入 Sumsub API Token:"
read SUMSUB_APP_TOKEN
echo "請輸入 Sumsub API Secret:"
read SUMSUB_APP_SECRET
echo "請輸入 Sumsub Webhook Secret Key:"
read SUMSUB_WEBHOOK_SECRET_KEY

# 設定 lamassu-server
echo "" >> /usr/lib/node_modules/lamassu-server/.env
echo 'SENSITIVE_DATA_ENCRYPT_KEY="$SENSITIVE_DATA_ENCRYPT_KEY"' >> /usr/lib/node_modules/lamassu-server/.env

# 設定 BTM-backend
echo "" >> BTM-backend/configs/dev.env
echo "# [SUMSUB]" >> BTM-backend/configs/dev.env
echo "SUMSUB.API_URL=https://api.sumsub.com" >> BTM-backend/configs/dev.env
echo "SUMSUB.APP_TOKEN=$SUMSUB_APP_TOKEN" >> BTM-backend/configs/dev.env
echo "SUMSUB.APP_SECRET=$SUMSUB_APP_SECRET" >> BTM-backend/configs/dev.env
echo "" >> BTM-backend/configs/dev.env
echo "" >> BTM-backend/configs/dev.env
echo 'SUMSUB.WEBHOOK_SECRET_KEY="$SUMSUB_WEBHOOK_SECRET_KEY"' >> BTM-backend/configs/dev.env
echo "" >> BTM-backend/configs/dev.env
echo "" >> BTM-backend/configs/dev.env
echo 'SENSITIVE_DATA_ENCRYPT_KEY=$SENSITIVE_DATA_ENCRYPT_KEY' >> BTM-backend/configs/dev.env


cd BTM-backend
git pull
docker-compose build
docker-compose down
docker-compose up -d

cd ~
