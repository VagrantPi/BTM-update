# BTM-update

## 新增後台 RD 工具頁 2025/5/9

- BTM-Admin - v0.0.52
- BTM-backend - v0.0.22
- lamassu-server - v0.0.6

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step7-3.sh && bash step7-3.sh
```

### hotfix 有 runtine error 變數沒宣告引用問題，順便處理特殊 case。當用戶 EDD 卻手動在 lamassu 後台解除 block，則該用戶還是需為黑名單被阻擋購買

- lamassu-server - v0.0.6

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step7-2.sh && bash step7-2.sh
```

## 添加 log，添加後台 log 2025/5/4

- BTM-Admin - v0.0.51
- BTM-backend - v0.0.21
- lamassu-server - v0.0.5

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step7-1.sh && bash step7-1.sh
```

## 限額、EDD 功能 2025/4/16

- BTM-Admin - v0.0.49
- BTM-backend - v0.0.19
- lamassu-server - v0.0.3

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step6-1.sh && bash step6-1.sh
```

先檢查是否有重複

```
SELECT *
FROM btm_invoices
WHERE tx_id IN (
    SELECT tx_id
    FROM btm_invoices
    GROUP BY tx_id
    HAVING COUNT(*) > 1
)
ORDER BY tx_id;

```

手動下 SQL

```
DROP INDEX "public"."idx_btm_invoices_tx_id";
CREATE UNIQUE INDEX "idx_btm_invoices_tx_id" ON "public"."btm_invoices" USING BTREE ("tx_id");
```


## hotfix 後台權限控管, sumsub 串接 2025/4/8

- BTM-Admin - v0.0.48
- BTM-backend - v0.0.17
- lamassu-server - v0.0.2

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
