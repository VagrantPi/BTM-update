#!/bin/bash

curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/btm_cibs.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm_cibs.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/btm_custom_info_reuqest.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm_custom_info_reuqest.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/btm_whitelist.js \
     -o /usr/lib/node_modules/lamassu-server/lib/btm_whitelist.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/cash-in/cash-in-tx.js \
     -o /usr/lib/node_modules/lamassu-server/lib/cash-in/cash-in-tx.js
curl -L https://raw.githubusercontent.com/VagrantPi/lamassu-server-release/main/lib/db.js \
     -o /usr/lib/node_modules/lamassu-server/lib/db.js

# 檢查下載是否成功
if [ $? -eq 0 ]; then
    echo "更新檔 Step1 成功\n請複製接下來 log 中 PSQL_URL 並按 control + c 鍵離開"
else
    echo "更新檔 Step1 失敗"
fi


supervisorctl restart lamassu-admin-server lamassu-server
sleep 5
tail /var/log/supervisor/lamassu-server.out.log -n 10 -f

