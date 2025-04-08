#!/bin/bash

cd BTM-backend
curl -L https://github.com/VagrantPi/BTM-Admin/releases/download/v0.0.45/dist.zip -o dist.zip
unzip dist.zip
rm dist.zip
git pull
docker-compose build
docker-compose down
docker-compose up -d
