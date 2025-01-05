# BTM-update

## step1

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step1.sh && bash step1.sh
```

執行完後等待一段時間會看到 PSQL_URL

看到後複製後面那串 `postgres://lamassu_pg:....`，並按下 control + c 離開

## step2

執行並貼上剛剛複製的

```bash
curl -O https://raw.githubusercontent.com/VagrantPi/BTM-update/refs/heads/main/step2.sh && bash step2.sh
```


