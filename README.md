# BTM-update


## hotfix 後台權限控管, sumsub 串接 2025/4/8

- BTM-Admin - v0.0.45
- BTM-backend - v0.0.15
- lamassu-server - v0.0.1

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step5-2.sh && bash step5-2.sh
```

## 後台權限控管, sumsub 串接 2025/3/31

- BTM-Admin - v0.0.44
- BTM-backend - v0.0.14
- lamassu-server - v0.0.1

### step1

```bash
mkdir ssl
```

### step2

手動上傳 rootCA.cer, server.key

### step3

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step5-1.sh && bash step5-1.sh
```

## 命中限額寄信 2025/3/18

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step4-1.sh && bash step4-1.sh
```

## 綠界發票版本 2025/3/18

### 更新綠界發票版本

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step3-1.sh && bash step3-1.sh
```

### 更新發票版本

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step3-4.sh && bash step3-4.sh
```

### 更新發票版本 - 調整環境變數

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step3-5.sh && bash step3-5.sh
```


## 告誡名單版本 2025/2/27

### step1

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step2-1.sh && bash step2-1.sh
```

### step2

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step2-2.sh && bash step2-2.sh
```

## 初次部署 2024

### step1

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step1-1.sh && bash step1-1.sh
```

執行完後等待一段時間會看到 PSQL_URL

看到後複製後面那串 `postgres://lamassu_pg:....`，並按下 control + c 離開

### step2

執行並貼上剛剛複製的

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step1-2.sh && bash step1-2.sh
```
