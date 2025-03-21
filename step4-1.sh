#!/bin/bash

echo "請輸入 SMTP_PASSWORD:"
read SMTP_PASSWORD

# 設定 lamassu-server
echo "" >> /usr/lib/node_modules/lamassu-server/.env
echo "#[SMTP]" >> /usr/lib/node_modules/lamassu-server/.env
echo 'SMTP_HOST="smtp.mailgun.org"' >> /usr/lib/node_modules/lamassu-server/.env
echo 'SMTP_USER="noreply@coin-now.com"' >> /usr/lib/node_modules/lamassu-server/.env
echo "SMTP_PASSWORD=$SMTP_PASSWORD" >> /usr/lib/node_modules/lamassu-server/.env
echo 'SMTP_TO="risk@coin-now.com"' >> /usr/lib/node_modules/lamassu-server/.env

# 設定 lamassu-server
cd /usr/lib/node_modules/lamassu-server
npm i nodemailer
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/btm-tools/email.js \
     -o /usr/lib/node_modules/lamassu-server/btm-tools/email.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/routes/customerRoutes.js \
     -o /usr/lib/node_modules/lamassu-server/lib/routes/customerRoutes.js

# 重啟 lamassu-server
supervisorctl restart lamassu-admin-server lamassu-server

cd ~