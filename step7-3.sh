#!/bin/bash


echo "請輸入 SMS Username:"
read SMS_USERNAME
echo "請輸入 SMS Password:"
read SMS_PASSWORD


echo "" >> BTM-backend/configs/dev.env
echo "#[TWILIO]" >> BTM-backend/configs/dev.env
echo "WILIO.USERNAME=$SMS_USERNAME" >> BTM-backend/configs/dev.env
echo "TWILIO.PASSWORD=$SMS_PASSWORD" >> BTM-backend/configs/dev.env

# lamassu-server 拉新程式碼
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/notifier/index.js \
     -o /usr/lib/node_modules/lamassu-server/lib/notifier/index.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/refs/heads/main/lib/routes/customerRoutes.js \
     -o /usr/lib/node_modules/lamassu-server/lib/routes/customerRoutes.js

supervisorctl restart lamassu-admin-server lamassu-server


# BTM-Backend
cd BTM-backend
git checkout
git pull



curl -L https://github.com/VagrantPi/BTM-Admin/releases/download/v0.0.52/dist.zip -o dist.zip
unzip dist.zip
rm dist.zip
docker-compose build
docker-compose down
docker-compose up -d

cd ~



