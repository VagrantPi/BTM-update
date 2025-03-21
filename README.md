# BTM-update

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

## 告誡名單版本 2025/2/27

### step1

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step2-1.sh && bash step2-1.sh
```

### step2

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step2-2.sh && bash step2-2.sh
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

## 命中限額寄信 2025/3/18

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step4-1.sh && bash step4-1.sh
```
