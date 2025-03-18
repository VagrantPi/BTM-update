#!/bin/bash

echo "請輸入 ECPay Merchant ID:"
read ECPAY_MERCHANT_ID
echo "請輸入 ECPay Hash Key:"
read ECPAY_HASH_KEY
echo "請輸入 ECPay Hash IV:"
read ECPAY_HASH_IV

# 設定 lamassu-server
echo "" >> /usr/lib/node_modules/lamassu-server/.env
echo "#[ECPay]" >> /usr/lib/node_modules/lamassu-server/.env
echo "ECPAY_IS_SANDBOX=True" >> /usr/lib/node_modules/lamassu-server/.env
echo "ECPAY_MERCHANT_ID=$ECPAY_MERCHANT_ID" >> /usr/lib/node_modules/lamassu-server/.env
echo "ECPAY_HASH_KEY=$ECPAY_HASH_KEY" >> /usr/lib/node_modules/lamassu-server/.env
echo "ECPAY_HASH_IV=$ECPAY_HASH_IV" >> /usr/lib/node_modules/lamassu-server/.env


# 重啟後台
cd BTM-backend
git checkout
git checkout main
git pull
docker-compose build
docker-compose down
docker-compose up -d


# 設定 lamassu-server
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