![242064548-f5e9add1-5b55-40d2-83dd-539cbf64c266](https://github.com/molla202/empower-2/assets/91562185/1191c65e-441f-4d71-9acc-5ea06391b7ed)

<h1 align="center"> Empower Chain </h1>

> Topluluk kanalları: - [Sohbet](https://t.me/corenodechat) - [Empower Discord](https://discord.gg/Zs3GMUhg)

<h1 align="center"> Donanım </h1>

```sh
# Sistem
4 CPU
8 RAM
200 SSD
```

<h1 align="center"> Güncelleme </h1>

```
sudo apt update && sudo apt upgrade -y && \
sudo apt install curl tar wget clang pkg-config libssl-dev jq build-essential bsdmainutils git make ncdu gcc git jq chrony liblz4-tool -y
```

<h1 align="center"> Go kurulumu </h1>

```sh
sudo rm -rf /usr/local/go
wget https://golang.org/dl/go1.20.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.20.linux-amd64.tar.gz
export PATH=/usr/local/go/bin:$PATH

# go version 1.20 olmak zorunda yoksa hata alırsınız
go version
```

<h1 align="center"> Binary </h1>

```sh 
cd $HOME
rm -rf empowerchain

git clone https://github.com/EmpowerPlastic/empowerchain

cd empowerchain
cd chain

make install
```

<h1 align="center"> Genesis, addrbook ve servis (port ayarlaması var isteyen değiştirsin 35 ayarlı)</h1>

```sh
# Orjinal dökümasyonda genesis URL'ler yok, manuel ekliyorum:
curl -Ls https://ss-t.empower.nodestake.top/genesis.json > $HOME/.empowerchain/config/genesis.json 

curl -Ls https://ss-t.empower.nodestake.top/addrbook.json > $HOME/.empowerchain/config/addrbook.json

# Port Atama (izmir ayarladım isteyen 35 değiştirsin)
echo "export EMPOWERCHAİN_PORT="35"" >> $HOME/.bash_profile
source $HOME/.bash_profile

# Port app.toml ayarlaması
sed -i.bak -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${EMPOWERCHAİN_PORT}317\"%;
s%^address = \":8080\"%address = \":${EMPOWERCHAİN_PORT}080\"%;
s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:${EMPOWERCHAİN_PORT}090\"%; 
s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:${EMPOWERCHAİN_PORT}091\"%; 
s%^address = \"0.0.0.0:8545\"%address = \"0.0.0.0:${EMPOWERCHAİN_PORT}545\"%; 
s%^ws-address = \"0.0.0.0:8546\"%ws-address = \"0.0.0.0:${EMPOWERCHAİN_PORT}546\"%" $HOME/.empowerchain/config/app.toml

# Ports config.toml ayarlaması
sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${EMPOWERCHAİN_PORT}658\"%; 
s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://0.0.0.0:${EMPOWERCHAİN_PORT}657\"%; 
s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${EMPOWERCHAİN_PORT}060\"%;
s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${EMPOWERCHAİN_PORT}656\"%;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${EMPOWERCHAİN_PORT}656\"%;
s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${EMPOWERCHAİN_PORT}660\"%" $HOME/.empowerchain/config/config.toml
```
```
# Servis dosyası:
sudo tee /etc/systemd/system/empowerd.service > /dev/null <<EOF
[Unit]
Description=empowerd Daemon
After=network-online.target
[Service]
User=$USER
ExecStart=/root/go/bin/empowerd start
Restart=always
RestartSec=3
LimitNOFILE=65535
[Install]
WantedBy=multi-user.target
EOF
```
```
# Resetleme ve başlatma
sudo systemctl daemon-reload
sudo systemctl enable empowerd
sudo systemctl restart empowerd
# Log Kontrol
journalctl -u empowerd -f -o cat
```

<h1 align="center"> Cüzdan oluşturma </h1>

```sh
# cüzdan-adı değiştirin.
empowerd keys add cüzdan-adı
```
```sh
empowerd keys add cüzdan-adı --recover    (import etmek için)
```

### Senkronize olmayı bekleyin ardından validatör oluşturun (not: faucetin bir kaç gün içinde açılacağı söylendi)
```
empowerd tx staking create-validator \
  --amount 1000000umpwr \
  --from cüzdan-adı \
  --commission-max-change-rate "0.01" \
  --commission-max-rate "0.2" \
  --commission-rate "0.1" \
  --min-self-delegation "1" \
  --pubkey  $(empowerd tendermint show-validator) \
  --moniker node-adı \
  --website "websiteniz"
  --identity keybase.io idniz \
  --details "Core Node Community" \
  --chain-id circulus-1
  --y
```
## Restart node
```
sudo systemctl restart empowerd
```
## Log Kontrol
```
journalctl -u empowerd -f -o cat
```
# Sadece port değiştirmek isteyenler

# Port Atama (izmir ayarladım isteyen 35 değiştirsin)
```
echo "export EMPOWERCHAİN_PORT="35"" >> $HOME/.bash_profile
source $HOME/.bash_profile
```
```
systemctl stop empowerd
```
```
# Port app.toml ayarlaması
sed -i.bak -e "s%^address = \"tcp://0.0.0.0:1317\"%address = \"tcp://0.0.0.0:${EMPOWERCHAİN_PORT}317\"%;
s%^address = \":8080\"%address = \":${EMPOWERCHAİN_PORT}080\"%;
s%^address = \"0.0.0.0:9090\"%address = \"0.0.0.0:${EMPOWERCHAİN_PORT}090\"%; 
s%^address = \"0.0.0.0:9091\"%address = \"0.0.0.0:${EMPOWERCHAİN_PORT}091\"%; 
s%^address = \"0.0.0.0:8545\"%address = \"0.0.0.0:${EMPOWERCHAİN_PORT}545\"%; 
s%^ws-address = \"0.0.0.0:8546\"%ws-address = \"0.0.0.0:${EMPOWERCHAİN_PORT}546\"%" $HOME/.empowerchain/config/app.toml
```
```
# Ports config.toml ayarlaması
sed -i.bak -e "s%^proxy_app = \"tcp://127.0.0.1:26658\"%proxy_app = \"tcp://127.0.0.1:${EMPOWERCHAİN_PORT}658\"%; 
s%^laddr = \"tcp://127.0.0.1:26657\"%laddr = \"tcp://0.0.0.0:${EMPOWERCHAİN_PORT}657\"%; 
s%^pprof_laddr = \"localhost:6060\"%pprof_laddr = \"localhost:${EMPOWERCHAİN_PORT}060\"%;
s%^laddr = \"tcp://0.0.0.0:26656\"%laddr = \"tcp://0.0.0.0:${EMPOWERCHAİN_PORT}656\"%;
s%^external_address = \"\"%external_address = \"$(wget -qO- eth0.me):${EMPOWERCHAİN_PORT}656\"%;
s%^prometheus_listen_addr = \":26660\"%prometheus_listen_addr = \":${EMPOWERCHAİN_PORT}660\"%" $HOME/.empowerchain/config/config.toml
```
```
sudo systemctl daemon-reload
sudo systemctl restart empowerd
journalctl -u empowerd -f -o cat
```
