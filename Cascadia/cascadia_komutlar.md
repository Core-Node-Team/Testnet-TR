<h1 align=center> Komutlar </h1>
 
#
<h1 align=center> Cüzdan Yönetimi </h1>
 
## Cüzdan Oluştur
```
cascadiad keys add wallet
```
## Cüzdan Recover Et
```
cascadiad keys add wallet --recover
```
## Cüzdanları Listele
```
cascadiad keys list
```
## Cüzdan Sil
```
cascadiad keys delete wallet
```
## Cüzdan Bakiyesini Sorgula
```
cascadiad q bank balances $(cascadiad keys show wallet -a)
```
#
<h1 align=center> Validatör Yönetimi </h1>
 
## Validatör Oluştur
```
cascadiad tx staking create-validator \
--amount 1000000aCC \
--pubkey $(cascadiad tendermint show-validator) \
--moniker "MONİKER_İSMİNİZ" \
--identity "KEYBASE.İO_İD" \
--details "DETAYLAR" \
--website "WEBSİTE_LİNKİNİZ" \
--chain-id cascadia_6102-1 \
--commission-rate 0.05 \
--commission-max-rate 0.20 \
--commission-max-change-rate 0.01 \
--min-self-delegation 1 \
--from wallet \
--gas-adjustment 1.5 \
--gas auto \
--fees 300000000aCC \
-y
```
## Validatörü Düzenle
```
cascadiad tx staking edit-validator \
--new-moniker "MONİKER_İSMİNİZ" \
--identity "KEYBASE.İO_İD" \
--details "DETAYLAR" \
--website "WEBSİTE_LİNKİNİZ" \
--chain-id cascadia_6102-1 \
--commission-rate 0.05 \
--from wallet \
--gas-adjustment 1.5 \
--gas auto \
--fees 300000000aCC \
-y
```
## Validatör Detayları
```
cascadiad q staking validator $(cascadiad keys show wallet --bech val -a)
```
## Validatör Unjail
```
cascadiad tx slashing unjail --from wallet --chain-id cascadia_6102-1 --gas-adjustment 1.5 --gas auto --fees 300000000aCC -y
```
## Jail Olma Sebebi
```
cascadiad query slashing signing-info $(cascadiad tendermint show-validator)
```
## Tüm Aktif Validatörleri Listele
```
cascadiad q staking validators -oj --limit=3000 | jq '.validators[] | select(.status==BOND_STATUS_BONDED)' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) +  t  + .description.moniker' | sort -gr | nl
```
## Tüm İnaktif Validatörleri Listele
```
cascadiad q staking validators -oj --limit=3000 | jq '.validators[] | select(.status==BOND_STATUS_UNBONDED)' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) +  t  + .description.moniker' | sort -gr | nl
```
<h1 align=center> Token </h1>
 
## Token Gönder
```
cascadiad tx bank send wallet <HEDEF_CÜZDAN_ADRESİ> 1000000aCC --from wallet --chain-id cascadia_6102-1 --gas-adjustment 1.5 --gas auto --fees 300000000aCC -y
```
## Delegate
```
cascadiad tx staking delegate <VALOPER_ADRESİ> 1000000aCC --from wallet --chain-id cascadia_6102-1 --gas-adjustment 1.5 --gas auto --fees 300000000aCC -y
```
## Kendi Validatörüne Delegate
```
cascadiad tx staking delegate $(cascadiad keys show wallet --bech val -a) 1000000aCC --from wallet --chain-id cascadia_6102-1 --gas-adjustment 1.5 --gas auto --fees 300000000aCC -y
```
## Redelegate
```
cascadiad tx staking redelegate <İLK_VALOPER_ADRESİ> <HEDEF_VALOPER_ADRESİ> 1000000aCC --from wallet --chain-id cascadia_6102-1 --gas-adjustment 1.5 --gas auto --fees 300000000aCC -y
```
## Kendi Validatöründen Başka Validatöre Redelegate
```
cascadiad tx staking redelegate $(cascadiad keys show wallet --bech val -a) <VALOPER_ADRESİ> 1000000aCC --from wallet --chain-id cascadia_6102-1 --gas-adjustment 1.5 --gas auto --fees 300000000aCC -y
```
## Unbond
```
cascadiad tx staking unbond $(cascadiad keys show wallet --bech val -a) 1000000aCC --from wallet --chain-id cascadia_6102-1 --gas-adjustment 1.5 --gas auto --fees 300000000aCC -y
```
## Tüm Validatörlerden Komisyon ve Ödülleri Çekme
```
cascadiad tx distribution withdraw-all-rewards --commission --from wallet --chain-id cascadia_6102-1 --gas-adjustment 1.5 --gas auto --fees 300000000aCC -y
```
## Kendi Validatörünüze Ait Komisyon ve Ödülleri Çekme
```
cascadiad tx distribution withdraw-rewards $(cascadiad keys show wallet --bech val -a) --commission --from wallet --chain-id cascadia_6102-1 --gas-adjustment 1.5 --gas auto --fees 300000000aCC -y
```
<h1 align=center> Yönetim </h1>
 
## Tüm Oylamaları Görüntüle
```
cascadiad query gov proposals
```
## Oylama Detaylarını Görüntüle
```
cascadiad query gov proposal <ID>
```
## Evet Oyu Ver
```
cascadiad tx gov vote <ID> yes --from wallet --chain-id cascadia_6102-1 --gas-adjustment 1.5 --gas auto --fees 300000000aCC -y
```
## Hayır Oyu Ver
```
cascadiad tx gov vote <ID> no --from wallet --chain-id cascadia_6102-1 --gas-adjustment 1.5 --gas auto --fees 300000000aCC -y
```
## Çekimser Oyu Ver
```
cascadiad tx gov vote <ID> abstain --from wallet --chain-id cascadia_6102-1 --gas-adjustment 1.5 --gas auto --fees 300000000aCC -y
```
## Hayır Oyu ve Veto Et
```
cascadiad tx gov vote <ID> no_with_veto --from wallet --chain-id cascadia_6102-1 --gas-adjustment 1.5 --gas auto --fees 300000000aCC -y
```
<h1 align=center> Yapılandırma Ayarları </h1>
 
 ## Pruning
```
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "19"|' \
  $HOME/.cascadiad/config/app.toml
```
## İndexer Aç
```
sed -i -e 's|^indexer *=.*|indexer = kv|' $HOME/.cascadiad/config/config.toml
```
## İndexer Kapat
```
sed -i -e 's|^indexer *=.*|indexer = null|' $HOME/.cascadiad/config/config.toml
```
## Port Değiştir
> ### Port=119
```
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:11958\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:11957\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:11960\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:11956\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":11966\"%" $HOME/.cascadiad/config/config.toml
sed -i -e "s%^address = \"tcp://localhost:1317\"%address = \"tcp://localhost:11917\"%; s%^address = \":8080\"%address = \":11980\"%; s%^address = \"localhost:9090\"%address = \"localhost:11990\"%; s%^address = \"localhost:9091\"%address = \"localhost:11991\"%; s%:8545%:11945%; s%:8546%:11946%; s%:6065%:11965%" $HOME/.cascadiad/config/app.toml
```
## Min Gas Price Ayarla
```
sed -i.bak -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.0025aCC\"/" ~/.cascadiad/config/app.toml
```
## Prometheus Aktif Et
```
sed -i -e s/prometheus = false/prometheus = true/ $HOME/.cascadiad/config/config.toml
```
## Zincir Verilerini Sıfırla
```
cascadiad tendermint unsafe-reset-all --keep-addr-book --home $HOME/.cascadiad --keep-addr-book
```
<h1 align=center> Durum Sorgulama ve Kontrol </h1>
 
## Senkronizasyon Durumu
```
cascadiad status 2>&1 | jq .SyncInfo
```
## Validatör Durumu
```
cascadiad status 2>&1 | jq .ValidatorInfo
```
## Node Durumu
```
cascadiad status 2>&1 | jq .NodeInfo
```
## Validatör Key Kontrol
```
[[ $(cascadiad q staking validator $(cascadiad keys show wallet --bech val -a) -oj | jq -r .consensus_pubkey.key) = $(cascadiad status | jq -r .ValidatorInfo.PubKey.value) ]] && echo -e "\n\e[1m\e[32mTrue\e[0m\n" || echo -e "\n\e[1m\e[31mFalse\e[0m\n"
```
## TX Sorgulama
```
cascadiad query tx <TX_ID>
```
## Peer Adresini Öğren
```
echo $(cascadiad tendermint show-node-id)@$(curl -s ifconfig.me):$(cat $HOME/.cascadiad/config/config.toml | sed -n '/Address to listen for incoming connection/{n;p;}' | sed 's/.*://; s/".*//')
```
## Bağlı Peerleri Öğren
```
curl -sS http://localhost:11957/net_info | jq -r ".result.peers[] | "\(.node_info.id)@\(.remote_ip):\(.node_info.listen_addr)"" | awk -F ":" "{print $1":"$NF}"
```
<h1 align=center> Service Yönetimi </h1>
 
Servisi Etkinleştir
```
sudo systemctl enable cascadiad
```
Servisi Devre Dışı Bırak
```
sudo systemctl disable cascadiad
```
Servisi Başlat
```
sudo systemctl start cascadiad
```
Servisi Durdur
```
sudo systemctl stop cascadiad
```
Servisi Yeniden Başlat
```
sudo systemctl restart cascadiad
```
Servis Durumunu Kontrol Et
```
sudo systemctl status cascadiad
```
Servis Loglarını Kontrol Et
```
sudo journalctl -u cascadiad -f --no-hostname -o cat
```
<h1 align=center> Node Silmek </h1>
```
sudo systemctl stop cascadiad && sudo systemctl disable cascadiad && sudo rm /etc/systemd/system/cascadiad.service && sudo systemctl daemon-reload && rm -rf $HOME/.cascadiad && rm -rf $HOME/cascadia && sudo rm -rf $(which cascadiad)
```
