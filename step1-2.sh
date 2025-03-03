#!/bin/bash

# Step1. get postgres env
# 提示用戶輸入 PostgreSQL URL

echo "請輸入 伺服器ip:"
read IP
echo "請輸入 PostgreSQL URL:"
read POSTGRES_URL

# 取得內網 ip
eth0_secondary_ip=$(ip -4 addr show eth0 | grep -oP '(?<=inet\s)\d+(\.\d+){3}' | sed -n '2p')

# 移除所有空白字元
POSTGRES_URL=$(echo "$POSTGRES_URL" | tr -d '[:space:]')
IP=$(echo "$IP" | tr -d '[:space:]')

# 使用正則表達式解析 URL
if [[ $POSTGRES_URL =~ postgres://([^:]+):([^@]+)@[^/]+/(.+)$ ]]; then
    USERNAME="${BASH_REMATCH[1]}"
    PASSWORD="${BASH_REMATCH[2]}"
    DATABASE="${BASH_REMATCH[3]}"
else
    echo "無效的 PostgreSQL URL 格式"
    exit 1
fi


# Step2. Install Git
sudo apt-get update
if ! command -v git &> /dev/null; then
    echo "Git 未安裝，正在安裝..."
    sudo apt-get install -y git
else
    echo "Git 已安裝"
fi


# Step3. install docker
# Add Docker's official GPG key:
sudo apt-get update -y
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
# install
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin unzip jq docker-compose -y


# Step 4. clone project
if [ ! -d "BTM-backend" ]; then
    git clone https://github.com/VagrantPi/BTM-backend.git
fi
cd BTM-backend

if [ ! -f "configs/dev.env" ]; then
    cp configs/app.env configs/dev.env
fi


# Step 5. 下載靜態檔
# 取得最新的 Release Tag
LATEST_TAG=$(curl -s https://api.github.com/repos/VagrantPi/BTM-Admin/releases/latest | jq -r '.tag_name')

# 檢查是否成功取得標籤
if [ "$LATEST_TAG" == "null" ] || [ -z "$LATEST_TAG" ]; then
    echo "無法取得最新標籤。請檢查 repository 是否正確。"
    exit 1
fi
# 下載最新版本的 Release
curl -L https://github.com/VagrantPi/BTM-Admin/releases/download/$LATEST_TAG/dist.zip -o dist.zip

# 解壓縮檔案
unzip dist.zip

# 替換上 db ENV
sed -i "s/DB.USERNAME=.*/DB.USERNAME=$USERNAME/" configs/dev.env
sed -i "s/DB.PASSWORD=.*/DB.PASSWORD=$PASSWORD/" configs/dev.env
sed -i "s/DB.DATABASE=.*/DB.DATABASE=$DATABASE/" configs/dev.env
sed -i "s/DB.HOST=.*/DB.HOST=$eth0_secondary_ip/" configs/dev.env
JWT_SECRET=$(openssl rand -hex 32)
sed -i "s/JWT.SECRET=secret/JWT.SECRET=$JWT_SECRET/" configs/dev.env

# Step 6. 告誡名單 env
read -p "請輸入 告誡名單 使用者帳號: " CIB_ACCOUNT
CIB_ACCOUNT=$(echo "$CIB_ACCOUNT" | tr -d '[:space:]')
read -p "請輸入 告誡名單 使用者密碼: " CIB_PWD
CIB_PWD=$(echo "$CIB_PWD" | tr -d '[:space:]')
read -p "請輸入 告誡名單 解壓縮密碼: " CIB_ZIP_PWD
CIB_ZIP_PWD=$(echo "$CIB_ZIP_PWD" | tr -d '[:space:]')

# 檢查是否有空值
if [ -z "$CIB_ACCOUNT" ] || [ -z "$CIB_PWD" ] || [ -z "$CIB_ZIP_PWD" ]; then
    echo "錯誤：告誡名單 所有參數都不能為空"
    exit 1
fi

# 將特殊字元轉義，以免影響 sed 的處理
escaped_account=$(printf '%s\n' "$CIB_ACCOUNT" | sed 's/[&/\]/\\&/g')
escaped_pwd=$(printf '%s\n' "$CIB_PWD" | sed 's/[&/\]/\\&/g')
escaped_zip_pwd=$(printf '%s\n' "$CIB_ZIP_PWD" | sed 's/[&/\]/\\&/g')

# 僅替換 CIB.ZIP_PWD 的行，確保格式正確
sed -i "/^CIB.ACCOUNT=/s|^CIB.ACCOUNT=.*|CIB.ACCOUNT=$escaped_account|" configs/dev.env
sed -i "/^CIB.PWD=/s|^CIB.PWD=.*|CIB.PWD=$escaped_pwd|" configs/dev.env
sed -i "/^CIB.ZIP_PWD=/s|^CIB.ZIP_PWD=.*|CIB.ZIP_PWD=$escaped_zip_pwd|" configs/dev.env

# Step 7. 告誡名單 env
docker-compose build --no-cache

# Step 8. 更新 postgres 設定
echo "listen_addresses = '*'" | sudo tee -a /etc/postgresql/12/main/postgresql.conf > /dev/null
eth0_network_prefix=$(echo "$eth0_secondary_ip" | awk -F. '{print $1"."$2".0.0"}')
echo "host all all $eth0_network_prefix/16 md5" | sudo tee -a /etc/postgresql/12/main/pg_hba.conf > /dev/null
sudo service postgresql restart
sudo ufw allow 5432/tcp


# 防火牆
sudo ufw allow 8080/tcp

sleep 3

docker-compose up -d
docker ps

echo "http://$IP:8080/admin/#/dashboard"
