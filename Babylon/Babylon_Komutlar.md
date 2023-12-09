<h1 align=center> Komutlar </h1>
 
#
<h1 align=center> Cüzdan Yönetimi </h1>

NOT: HATA VEREN BAZI KODLARDA HATA BELİRTİYOR `staking` yerine `epoching` yazınız
 
## Cüzdan Oluştur
```
babylond keys add wallet
```
## Cüzdan Recover Et
```
babylond keys add wallet --recover
```
## Cüzdanları Listele
```
babylond keys list
```
## Cüzdan Sil
```
babylond keys delete wallet
```
## Cüzdan Bakiyesini Sorgula
```
babylond q bank balances $(babylond keys show wallet -a)
```



#
<h1 align=center> Validatör Yönetimi </h1>
 
## Validatör Oluştur
```
babylond tx staking create-validator \
--amount 1000000ubbn \
--pubkey $(babylond tendermint show-validator) \
--moniker "MONİKER_İSMİNİZ" \
--identity "KEYBASE.İO_İD" \
--details "DETAYLAR" \
--website "WEBSİTE_LİNKİNİZ" \
--chain-id bbn-test-2 \
--commission-rate 0.05 \
--commission-max-rate 0.20 \
--commission-max-change-rate 0.01 \
--min-self-delegation 1 \
--from wallet \
--gas-adjustment 1.5 \
--gas auto \
--fees 100ubbn \
-y
```
## Validatörü Düzenle
```
babylond tx staking edit-validator \
--new-moniker "MONİKER_İSMİNİZ" \
--identity "KEYBASE.İO_İD" \
--details "DETAYLAR" \
--website "WEBSİTE_LİNKİNİZ" \
--chain-id bbn-test-2 \
--commission-rate 0.05 \
--from wallet \
--gas-adjustment 1.5 \
--gas auto \
--fees 100ubbn \
-y
```
## Validatör Detayları
```
babylond q staking validator $(babylond keys show wallet --bech val -a)
```
## Validatör Unjail
```
babylond tx slashing unjail --from wallet --chain-id bbn-test-2 --gas-adjustment 1.5 --gas auto --fees 100ubbn -y
```
## Jail Olma Sebebi
```
babylond query slashing signing-info $(babylond tendermint show-validator)
```
## Tüm Aktif Validatörleri Listele
```
babylond q staking validators -oj --limit=3000 | jq '.validators[] | select(.status==BOND_STATUS_BONDED)' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) +  t  + .description.moniker' | sort -gr | nl
```
## Tüm İnaktif Validatörleri Listele
```
babylond q staking validators -oj --limit=3000 | jq '.validators[] | select(.status==BOND_STATUS_UNBONDED)' | jq -r '(.tokens|tonumber/pow(10; 6)|floor|tostring) +  t  + .description.moniker' | sort -gr | nl
```
<h1 align=center> Token </h1>
 
## Token Gönder
```
babylond tx bank send wallet <HEDEF_CÜZDAN_ADRESİ> 1000000ubbn --from wallet --chain-id bbn-test-2 --gas-adjustment 1.5 --gas auto --fees 100ubbn -y
```
## Delegate
```
babylond tx staking delegate <VALOPER_ADRESİ> 1000000ubbn --from wallet --chain-id bbn-test-2 --gas-adjustment 1.5 --gas auto --fees 100ubbn -y
```
## Kendi Validatörüne Delegate
```
babylond tx staking delegate $(babylond keys show wallet --bech val -a) 1000000ubbn --from wallet --chain-id bbn-test-2 --gas-adjustment 1.5 --gas auto --fees 100ubbn -y
```
## Redelegate
```
babylond tx staking redelegate <İLK_VALOPER_ADRESİ> <HEDEF_VALOPER_ADRESİ> 1000000ubbn --from wallet --chain-id bbn-test-2 --gas-adjustment 1.5 --gas auto --fees 100ubbn -y
```
## Kendi Validatöründen Başka Validatöre Redelegate
```
babylond tx staking redelegate $(babylond keys show wallet --bech val -a) <VALOPER_ADRESİ> 1000000ubbn --from wallet --chain-id bbn-test-2 --gas-adjustment 1.5 --gas auto --fees 100ubbn -y
```
## Unbond
```
babylond tx staking unbond $(babylond keys show wallet --bech val -a) 1000000ubbn --from wallet --chain-id bbn-test-2 --gas-adjustment 1.5 --gas auto --fees 100ubbn -y
```
## Tüm Validatörlerden Komisyon ve Ödülleri Çekme
```
babylond tx distribution withdraw-all-rewards --commission --from wallet --chain-id bbn-test-2 --gas-adjustment 1.5 --gas auto --fees 100ubbn -y
```
## Kendi Validatörünüze Ait Komisyon ve Ödülleri Çekme
```
babylond tx distribution withdraw-rewards $(babylond keys show wallet --bech val -a) --commission --from wallet --chain-id bbn-test-2 --gas-adjustment 1.5 --gas auto --fees 100ubbn -y
```
<h1 align=center> Yönetim </h1>
 
## Tüm Oylamaları Görüntüle
```
babylond query gov proposals
```
## Oylama Detaylarını Görüntüle
```
babylond query gov proposal <ID>
```
## Evet Oyu Ver
```
babylond tx gov vote <ID> yes --from wallet --chain-id bbn-test-2 --gas-adjustment 1.5 --gas auto --fees 100ubbn -y
```
## Hayır Oyu Ver
```
babylond tx gov vote <ID> no --from wallet --chain-id bbn-test-2 --gas-adjustment 1.5 --gas auto --fees 100ubbn -y
```
## Çekimser Oyu Ver
```
babylond tx gov vote <ID> abstain --from wallet --chain-id bbn-test-2 --gas-adjustment 1.5 --gas auto --fees 100ubbn -y
```
## Hayır Oyu ve Veto Et
```
babylond tx gov vote <ID> no_with_veto --from wallet --chain-id bbn-test-2 --gas-adjustment 1.5 --gas auto --fees 100ubbn -y
```
<h1 align=center> Yapılandırma Ayarları </h1>
 
 ## Pruning
```
sed -i \
  -e 's|^pruning *=.*|pruning = "custom"|' \
  -e 's|^pruning-keep-recent *=.*|pruning-keep-recent = "100"|' \
  -e 's|^pruning-keep-every *=.*|pruning-keep-every = "0"|' \
  -e 's|^pruning-interval *=.*|pruning-interval = "10"|' \
  $HOME/.babylond/config/app.toml
```
## İndexer Aç
```
sed -i -e 's|^indexer *=.*|indexer = kv|' $HOME/.babylond/config/config.toml
```
## İndexer Kapat
```
sed -i -e 's|^indexer *=.*|indexer = null|' $HOME/.babylond/config/config.toml
```
## Port Değiştir
> ### Port=311
```
sed -i -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:31158\"%; s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://127.0.0.1:31157\"%; s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:31160\"%; s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:31156\"%; s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":31166\"%" $HOME/.babylond/config/config.toml
sed -i -e "s%^address = \"tcp://localhost:1317\"%address = \"tcp://localhost:31117\"%; s%^address = \":8080\"%address = \":31180\"%; s%^address = \"localhost:9090\"%address = \"localhost:31190\"%; s%^address = \"localhost:9091\"%address = \"localhost:31191\"%; s%:8545%:31145%; s%:8546%:31146%; s%:6065%:31165%" $HOME/.babylond/config/app.toml
```
## Min Gas Price Ayarla
```
sed -i -e "s/^minimum-gas-prices *=.*/minimum-gas-prices = \"0.00001ubbn\"/" $HOME/.babylond/config/app.toml
```
## Prometheus Aktif Et
```
sed -i -e s/prometheus = false/prometheus = true/ $HOME/.babylond/config/config.toml
```
## Zincir Verilerini Sıfırla
```
babylond tendermint unsafe-reset-all --keep-addr-book --home $HOME/.babylond --keep-addr-book
```
<h1 align=center> Durum Sorgulama ve Kontrol </h1>
 
## Senkronizasyon Durumu
```
babylond status 2>&1 | jq .SyncInfo
```
## Validatör Durumu
```
babylond status 2>&1 | jq .ValidatorInfo
```
## Node Durumu
```
babylond status 2>&1 | jq .NodeInfo
```
## Validatör Key Kontrol
```
[[ $(babylond q staking validator $(babylond keys show wallet --bech val -a) -oj | jq -r .consensus_pubkey.key) = $(babylond status | jq -r .ValidatorInfo.PubKey.value) ]] && echo -e "\n\e[1m\e[32mTrue\e[0m\n" || echo -e "\n\e[1m\e[31mFalse\e[0m\n"
```
## TX Sorgulama
```
babylond query tx <TX_ID>
```
## Peer Adresini Öğren
```
echo $(babylond tendermint show-node-id)@$(curl -s ifconfig.me):$(cat $HOME/.babylond/config/config.toml | sed -n '/Address to listen for incoming connection/{n;p;}' | sed 's/.*://; s/".*//')
```
## Bağlı Peerleri Öğren
```
curl -sS http://localhost:31157/net_info | jq -r ".result.peers[] | "\(.node_info.id)@\(.remote_ip):\(.node_info.listen_addr)"" | awk -F ":" "{print $1":"$NF}"
```
<h1 align=center> Service Yönetimi </h1>
 
## Servisi Etkinleştir
```
sudo systemctl enable babylond
```
## Servisi Devre Dışı Bırak
```
sudo systemctl disable babylond
```
## Servisi Başlat
```
sudo systemctl start babylond
```
## Servisi Durdur
```
sudo systemctl stop babylond
```
## Servisi Yeniden Başlat
```
sudo systemctl restart babylond
```
## Servis Durumunu Kontrol Et
```
sudo systemctl status babylond
```
## Servis Loglarını Kontrol Et
```
sudo journalctl -u babylond -f --no-hostname -o cat
```
<h1 align=center> Node Silmek </h1>

```
sudo systemctl stop babylond && sudo systemctl disable babylond && sudo rm /etc/systemd/system/babylond.service && sudo systemctl daemon-reload && rm -rf $HOME/.babylond && rm -rf $HOME/babylon && sudo rm -rf $(which babylond)
```
